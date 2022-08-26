/**
 * À soummettre pour véfification sur Etherscan.io
 ébauche de contrat pour le Hackathonci2022 
*/

/*
SPDX-License-Identifier: UNLICENSED
(c) Par ZTrade
This work is unlicensed.----La license pourra être modifiée selon les besoins opérationnels 
*/
pragma solidity 0.7.5;

/**
 * @dev Enveloppes pour les opérations arithmétiques de Solidity avec des contrôles de débordement supplémentaires.
 * vérifications.
 * Les opérations arithmétiques dans Solidity s'emballent en cas de débordement. Cela peut facilement entraîner
 * facilement des bogues, car les programmeurs supposent généralement qu'un débordement entraîne une
 * erreur, ce qui est le comportement standard dans les langages de programmation de haut niveau.
 *SafeMath` restaure cette intuition en inversant la transaction lorsqu'une opération déborde.
 * L'utilisation de cette bibliothèque au lieu des opérations non vérifiées élimine une classe entière de bugs.
 * il est donc recommandé de toujours l'utiliser.
 */
library SafeMath {
      /**
     * @dev Renvoie l'addition de deux entiers non signés, avec retour sur débordement.
     * Contrepartie de l'opérateur `+` de Solidity.
     *
     * Exigences :
     *
     * - L'addition ne peut pas déborder.
     */
    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;
        require(c >= a, "SafeMath: addition overflow");

        return c;
    }

    /**
     * @dev Renvoie la soustraction de deux entiers non signés, avec retour en arrière en cas de débordement (lorsque le résultat est 
     * négatif).
     *
     * Contrepartie de l'opérateur `-` de Solidity.
     *
     * Exigences :
     *
     * - La soustraction ne peut pas déborder.
     */
    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        return sub(a, b, "SafeMath: subtraction overflow");
    }

    /**
     * @dev Renvoie la soustraction de deux entiers non signés, avec un message personnalisé en cas de    
     * débordement (lorsque le résultat est négatif).
     *
     * Contrepartie de l'opérateur `-` de Solidity.
     *
     * Exigences :
     *
     * - La soustraction ne peut pas déborder.
     */
    function sub(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        require(b <= a, errorMessage);
        uint256 c = a - b;

        return c;
    }

    /**
     * @dev Renvoie la multiplication de deux entiers non signés, avec retour en arrière en cas de
     * débordement.
     *
     * Contrepartie de l'opérateur `*` de Solidity.
     *
     * Exigences :
     *
     * - La multiplication ne peut pas déborder.
     */
    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        // Optimisation des gaz : c'est moins cher que de demander que 'a' soit différent de zéro, mais le 
        // bénéfice est perdu si 'b' est aussi testé.
        if (a == 0) {
            return 0;
        }

        uint256 c = a * b;
        require(c / a == b, "SafeMath: debordement de multiplication");

        return c;
    }
    /**
     * @dev Renvoie la division entière de deux entiers non signés. Se retourne sur
     * la division par zéro. Le résultat est arrondi à zéro.
     *
     * Contrepartie de l'opérateur `/` de Solidity.
     * Note : cette fonction utilise un opcode `revert` (qui laisse le gaz restant intact) alors que Solidity
     * utilise un opcode invalide pour revenir en arrière (consommant tout le gaz restant).
     *
     * Exigences :
     *
     * - Le diviseur ne peut pas être zéro.
     */
    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        return div(a, b, "SafeMath: division par zero");
    }
   /**
     * @dev Renvoie la division entière de deux entiers non signés. Fait un retour avec un message personnalisé sur
     * la division par zéro. Le résultat est arrondi vers zéro.
     *
     * Contrepartie de l'opérateur `/` de Solidity.
     * Note : cette fonction utilise un opcode `revert` (qui laisse le gaz restant intact) alors que Solidity
     * utilise un opcode invalide pour revenir en arrière (consommant tout le gaz restant).
     *
     * Exigences :
     *
     * - Le diviseur ne peut pas être zéro.
     */
    function div(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        require(b > 0, errorMessage);
        uint256 c = a / b;
        // assertion(a == b * c + a % b); // Il n'y a pas de cas où cela ne tienne pas.

        return c;
    }

    /**
     * @dev Renvoie le reste de la division de deux entiers non signés. (modulo d'un entier non signé),
     * Retourne le reste de la division par zéro.
     *
     * Contrepartie de l'opérateur `%` de Solidity. Cette fonction utilise un opcode `revert`
     * (qui laisse le gaz restant intact) alors que Solidity utilise un
     * opcode invalide pour revenir en arrière (consommant tout le gaz restant).
     *
     * Exigences:
     *
     * - Le diviseur ne peut pas être zéro.
     */
    function mod(uint256 a, uint256 b) internal pure returns (uint256) {
        return mod(a, b, "SafeMath: modulo by zero");
    }
   /**
     * @dev Renvoie le reste de la division de deux entiers non signés. (modulo d'entiers non signés),
     * Se renverse avec un message personnalisé lors de la division par zéro.
     *
     * Contrepartie de l'opérateur `%` de Solidity. Cette fonction utilise un opcode `revert`
     * opcode (qui laisse le gaz restant intact) alors que Solidity utilise un
     * opcode invalide pour revenir en arrière (consommant tout le gaz restant).
     *
     * Exigences :
     *
     * - Le diviseur ne peut pas être zéro.
     */
    function mod(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        require(b != 0, errorMessage);
        return a % b;
    }
}

/**
 * @dev Interface de la norme ERC20 telle que définie dans l'EIP.
 */
interface IERC20 {
    /**
     * @dev Renvoie la quantité de tokens existants.
     */
    function totalSupply() external view returns (uint256);

    /**
     * @dev Renvoie la quantité de tokens detenus par `compte`.
     */
    function balanceOf(address account) external view returns (uint256);

    /**
     * @dev Déplace le montant `amount` de tokens du compte de l'appelant vers celui du `recipient`.
     *
     * Retourne une valeur booléenne indiquant si l'opération a réussi.
     *
     * Emet un événement {Transfer}.
     */
    function transfer(address recipient, uint256 amount) external returns (bool);

    /**
     * @dev Renvoie le nombre restant de tokens que le `spender` sera
     * autorisé à dépenser pour le compte du `owner` via {transferFrom}. Ce nombre est
     * zéro par défaut.
     *
     * Cette valeur change lorsque les events {approve} ou {transferFrom} sont appelés.
     */
    function allowance(address owner, address spender) external view returns (uint256);

    /**
     * @dev Définit le montant `amount` comme l'allocation de `spender` sur les tokens de l'appelant.
     *
     * Retourne une valeur booléenne indiquant si l'opération a réussi.
     *
     * IMPORTANT : Attention, changer une allocation avec cette méthode comporte le risque
     * que quelqu'un puisse utiliser à la fois l'ancienne et la nouvelle allocation en ordonnant
     * l'ordre des transactions. 
     * Une solution possible pour atténuer cela est de réduire d'abord l'allocation du spender à 0 et de définir   
     *ensuite la valeur souhaitée par la suite
     * Emet un event {Approval}.

     */
    function approve(address spender, uint256 amount) external returns (bool);

    /**
     * @dev Déplace le montant `amount` de tokens de l'expéditeur vers le destinataire en utilisant le mécanisme d'allocation.
     * Le montant est ensuite déduit de l'allocation de l'appelant.
     *
     * Retourne une valeur booléenne indiquant si l'opération a réussi.
     *
     * Emet un event {Transfert}.
     */
     
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);

    /**
     * @dev Emit lorsque des tokens `value` sont déplacés d'un compte (`from`) à un autre (`to`).
     *
     * Notez que `value` peut être zéro.
     */
    event Transfer(address indexed from, address indexed to, uint256 value);

    /**
     * @dev Emitted lorsque l'allocation d'un `spender` pour un `owner` est fixée par
     * un appel à {approve}. `value` est la nouvelle allocation.
     */
    event Approval(address indexed owner, address indexed spender, uint256 value);
}


/**
 * @title ZFT est un token qui fait référence à des productions agricoles réelles.
 * ZFT est un token administré par la société ZTrade. 
 * (représenté par la variable d'adresse Ethereum admin dans ce Smart Contract).
 * ZTrade exécute toutes les fonctions administratives
 * basées sur les documentations et les certifications des productions en partenariat avec les négociants agricoles (appelés Oracles)
 * et en accord avec les autorités locales.
 * */
contract ZFT is IERC20 {
    using SafeMath for uint256;
    //
    // events mint/burn events
    event Mint(address indexed _to, uint256 _amount, uint256 _newTotalSupply);
    event Burn(address indexed _from, uint256 _amount, uint256 _newTotalSupply);

    // events admin 
    event BlockLockSet(uint256 _value);
    event NewAdmin(address _newAdmin);
    event NewManager(address _newManager);
    event ProdStockChanged(
        uint256 indexed contractId,
        string prodCategory,
        string prodContractInfo,
        uint256 amount,
        uint8 status,
        uint256 newTotalSupplyAmount
    );

    modifier onlyAdmin {
        require(msg.sender == admin, "Seul l'administrateur peut effectuer cette operation");
        _;
    }    

    modifier boardOrAdmin {
        require(
            msg.sender == board || msg.sender == admin,
            "Seul l'administrateur ou les membres du board peuvent effectuer cette operation"
        );
        _;
    }

    modifier blockLock(address _sender) {
        require(
            !isLocked() || _sender == admin,
            "Le contrat est verrouille sauf pour l'admin"
        );
        _;
    }
    //struct Prod
    struct Prod {
        string category;
        string contractInfo;
        uint256 amount;
        uint8 status;
    }

    uint256 override public totalSupply;
    string public name;
    uint8 public decimals;
    string public symbol;
    address public admin;
    address public board;    
    uint256 public lockedUntilBlock;
    uint256 public tokenizationFee;
    uint256 public deTokenizationFee;
    uint256 public transferFee;
    mapping(address => uint256) public balances;
    mapping(address => mapping(address => uint256)) public allowed;
    Prod[] public prods;

    /**
     * @dev Constructeur
     */
    constructor() {
        name = "ZFT";
        decimals = 4;
        symbol = "ZFT";
        lockedUntilBlock = 0;
        admin = msg.sender;
        board = 0x0xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx; // Votre adresse admin ici
        totalSupply = 0;
        balances[address(this)] = totalSupply;
    }
    

    /**  
     -* @dev Ajouter un nouveau contrat au portfolio
     * @param _prodCategory - categorie de la Production
     * @param _prodContractInfo - details du Contrat 
     * @param _prodAmount - montant de la producton en Tonnes
     * @return success
     */
    function addNewProdContract(        
        string memory _prodCategory,
        string memory _prodContractInfo,
        uint256 _prodAmount
    ) public onlyAdmin returns (bool success) {
        Prod memory newProd = Prod(
            _prodCategory,
            _prodContractInfo,
            _prodAmount,
            1
        );
        prods.push(newProd);
        _mint(address(this), _prodAmount);
        emit ProdStockChanged(
            prods.length-1,
            _prodCategory,
            _prodContractInfo,
            _prodAmount,
            1,
            totalSupply
        );
        success = true;
        return success;
    }    
    /**
     * @dev Retirer un contrat du portfolio
     * @param _contractIndex - Indice du contrat dans le portefolio
     * @return True if success
     */
    function removeProdContract(uint256 _contractIndex) public onlyAdmin returns (bool) {
        require(
            _contractIndex < prods.length,
            "Numero d'indice de contrat invalide. Superieur au total des contrats de production"
        );
        Prod storage prod = prods[_contractIndex];
        require(prod.status == 1, "Ce contrat n'est plus actif");
        require(_burn(address(this), prod.amount), "Impossible de bruler les tokens");
        prod.status = 0;
        emit ProdStockChanged( 
            _contractIndex,           
            prod.category,
            prod.contractInfo,
            prod.amount,
            prod.status,
            totalSupply
        );
        return true;
    }
     
    /**
     * @dev met à jour un contrat
     * @param _contractIndex - Indice du contrat au sein du portefolio
     * @param _prodCategory - Catégorie des productions
     * @param _prodContractInfo - Détails du contrat de producution
     * @param _prodAmount - quantité de production en tonnes
     * @return True if success
     */
    function updateProdContract(
        uint256 _contractIndex,
        string memory _prodCategory,
        string memory _prodContractInfo,
        uint256 _prodAmount
    ) public onlyAdmin returns (bool) {
        require(
            _contractIndex < prods.length,
            "Numero d'indice de contrat invalide. Superieur au total des contrats de production"
        );
        require(_prodAmount > 0, "Impossible de definir un montant d'actif nul");
        Prod storage prod = prods[_contractIndex];
        require(prod.status == 1, "Ce contrat n'est plus actif");
        prod.category = _prodCategory;
        prod.contractInfo = _prodContractInfo;
        if (prod.amount > _prodAmount) {
            _burn(address(this), prod.amount.sub(_prodAmount));
        } else if (prod.amount < _prodAmount) {
            _mint(address(this), _prodAmount.sub(prod.amount));           
        }
        prod.amount = _prodAmount;
        emit ProdStockChanged(
            _contractIndex,
            prod.category,
            prod.contractInfo,
            prod.amount,
            prod.status,
            totalSupply
        );
        return true;
    }

    /**
     * @return Nombre de contrats de production dans le portfolio
     */
    function totalContracts() public view returns (uint256) {
        return prods.length;
    }

    /**
     * @dev ERC20 Transfer
     * @param _to -  addresse de destination
     * @param _value - valeur du transfer
     * @return True if success
     */
    function transfer(address _to, uint256 _value)
        override
        external
        blockLock(msg.sender)
        returns (bool)
    {
        address from = (admin == msg.sender) ? address(this) : msg.sender;
        require(
            isTransferValid(from, _to, _value),
            "Operation de transfert invalide"
        );
        balances[from] = balances[from].sub(_value);
        uint256 serviceAmount = 0;
        uint256 netAmount = _value;      
        (serviceAmount, netAmount) = calcFees(transferFee, _value); 
        balances[_to] = balances[_to].add(netAmount);
        balances[address(this)] = balances[address(this)].add(serviceAmount);
        emit Transfer(from, _to, netAmount);
        emit Transfer(from, address(this), serviceAmount);
        return true;
    }


    /**
     * @dev ERC20 TransferFrom
     * @param _from - addresse source 
     * @param _to - addresse de destination
     * @param _value - valeur
     * @return True if success
     */
    function transferFrom(address _from, address _to, uint256 _value)
        override
        external
        blockLock(_from)
        returns (bool)
    {
        // vérifier que l'allocation est suffisante
        require(
            _value <= allowed[_from][msg.sender],
            "La valeur renseignee n'est pas valide"
        );
        require(
            isTransferValid(_from, _to, _value),
            "Operation de transfert non valide"
        );
        // transférer tokens
        balances[_from] = balances[_from].sub(_value);
        uint256 serviceAmount = 0;
        uint256 netAmount = _value;      
        (serviceAmount, netAmount) = calcFees(transferFee, _value); 
        balances[_to] = balances[_to].add(netAmount);
        balances[address(this)] = balances[address(this)].add(serviceAmount);
        allowed[_from][msg.sender] = allowed[_from][msg.sender].sub(
            _value,
            "Valeur inferieure a l'autorisation"
        );

        emit Transfer(_from, _to, netAmount);
        emit Transfer(_from, address(this), serviceAmount);
        return true;
    }

    /**
     * @dev ERC20 Approuver les transferts de tokens au nom d'un autre propriétaire
     * @param _spender -  addresse de destination
     * @param _value - valeur à approuver
     * @return True if success
     */
    function approve(address _spender, uint256 _value)
        override
        external
        blockLock(msg.sender)
        returns (bool)
    {
        require(_spender != address(0), "ERC20: approuver l'adresse zero");

        address from = (admin == msg.sender) ? address(this) : msg.sender;
        require((_value == 0) || (allowed[from][_spender] == 0), "L'allocation ne peut pas etre augmentee ou diminuee si la valeur est differente de zero.");
        allowed[from][_spender] = _value;
        emit Approval(from, _spender, _value);
        return true;
    }
    /**
     * @dev Diminue de façon atomique l'allocation accordée à `spender` par le caller.
     *
     * C'est une alternative à {approve} qui peut être utilisée pour atténuer les problèmes décrits dans {IERC20-approve}.
     *
     * Emet un événement {Approval} indiquant l'allocation mise à jour.
     *
     * Exigences :
     *
     * - `spender` ne peut pas être l'adresse zéro.
     * - `spender` doit avoir une allocation pour le caller d'au moins
     * `subtractedValue`.
     */
    function decreaseAllowance(address _spender, uint256 _subtractedValue) public virtual returns (bool) {
        require(_spender != address(0), "ERC20: diminution de l'allocation e l'adresse zero");

        address from = (admin == msg.sender) ? address(this) : msg.sender;
        require(allowed[from][_spender] >= _subtractedValue, "ERC20: diminution de l'allocation en dessous de zero");
        _approve(from, _spender, allowed[from][_spender].sub(_subtractedValue));

        return true;
    }

   /**
     * @dev Augmente de façon atomique l'allocation accordée à `spender` par l'appelant.
     *
     * C'est une alternative à {approve} qui peut être utilisée pour atténuer les problèmes décrits dans {IERC20-approve}.
     *
     * Emet un événement {Approval} indiquant l'allocation mise à jour.
     *
     * Exigences :
     *
     * - `spender` ne peut pas être l'adresse zéro.
     */
     
    function increaseAllowance(address _spender, uint256 _addedValue) public virtual returns (bool) {
        require(_spender != address(0), "ERC20: Reduction de l'allocation de l'adresse zero");

        address from = (admin == msg.sender) ? address(this) : msg.sender;
        _approve(from, _spender, allowed[from][_spender].add(_addedValue));
        return true;
    }
   /**
     * @dev Définit `amount` comme l'allocation de `spender` sur les tokens du `owner`.
     *
     * Cette fonction interne est équivalente à `approve`, et peut être utilisée pour
     * par exemple, définir des allocations automatiques pour certains sous-systèmes, etc.
     *
     * Emet un événement {Approval}.
     *
     * Exigences :
     *
     * - `owner` ne peut pas être l'adresse zéro.
     * - `spender` ne peut pas être l'adresse zéro.
     */
    function _approve(address _owner, address _spender, uint256 _amount) internal virtual {
        require(_owner != address(0), "ERC20: approuver a partir de l'adresse zaro");
        require(_spender != address(0), "ERC20: approuver l'adresse zaro");

        allowed[_owner][_spender] = _amount;
        emit Approval(_owner, _spender, _amount);
    }
   /**
     * @dev retire les tokens collectés après les frais de réception 
     * @param _to - adresse de destination
     * @param _value - valeur à transférer
     * @return True if success
     */
     
    function withdraw(address _to, uint256 _value)
        external
        boardOrAdmin
        returns (bool)
    {
        address from = address(this);
        require(
            isTransferValid(from, _to, _value),
            "Operation de transfert invalide"
        );
        balances[from] = balances[from].sub(_value);
        balances[_to] = balances[_to].add(_value);
        emit Transfer(from, _to, _value);
        return true;
    }

    /**
     * @dev Mint new tokens. Ne peut être appelé que par mana
     * @param _to - adresse de destination
     * @param _value - valeur
     * @return True if success
     */
    function _mint(address _to, uint256 _value)
        internal
        onlyAdmin        
        returns (bool)
    {
        require(_to != address(0), "ERC20: mint a l'adresse zero");
        require(_to != admin, "L'administrateur ne peut pas miner des tokens pour lui-meme");
        uint256 serviceAmount;
        uint256 netAmount;
        (serviceAmount, netAmount) = calcFees(tokenizationFee, _value);

        balances[_to] = balances[_to].add(netAmount);
        balances[address(this)] = balances[address(this)].add(serviceAmount);
        totalSupply = totalSupply.add(_value);

        emit Mint(_to, netAmount, totalSupply);
        emit Mint(address(this), serviceAmount, totalSupply);
        emit Transfer(address(0), _to, netAmount);
        emit Transfer(address(0), address(this), serviceAmount);

        return true;
    }

    /**
     * @dev Brûluer Tokens
     * @param _account - adresse
     * @param _value - valeur
     * @return True if success
     */
    function _burn(address _account, uint256 _value)
        internal        
        onlyAdmin
        returns (bool)
    {
        require(_account != address(0), "ERC20: bruler a partir de l'adresse zero");
        uint256 serviceAmount;
        uint256 netAmount;
        (serviceAmount, netAmount) = calcFees(deTokenizationFee, _value);
        totalSupply = totalSupply.sub(netAmount);
        balances[_account] = balances[_account].sub(_value);
        balances[address(this)] = balances[address(this)].add(serviceAmount);
        emit Transfer(_account, address(0), netAmount);
        emit Transfer(_account, address(this), serviceAmount);
        emit Burn(_account, netAmount, totalSupply);        
        return true;
    }

    /**
     * @dev Définit le verrouillage du bloc. Jusqu'à ce que les transferts de ce bloc (exclusif) soient interdits.
     * @param _lockedUntilBlock - Numéro de bloc
     * @return True if success
     */
     
    function setBlockLock(uint256 _lockedUntilBlock)
        public
        boardOrAdmin
        returns (bool)
    {
        lockedUntilBlock = _lockedUntilBlock;
        emit BlockLockSet(_lockedUntilBlock);
        return true;
    }

    /**
     * @dev Remplacer l'administrateur actuel par un nouvel administrateur
     * @param _newAdmin Nouvel administrateur du token
     * @return True if success
     */
    function replaceAdmin(address _newAdmin)
        public
        boardOrAdmin
        returns (bool)
    {
        require(_newAdmin != address(0x0), "Addresse nulle");
        admin = _newAdmin;
        emit NewAdmin(_newAdmin);
        return true;
    }

    /**
    * @dev Change les valeurs des frais de ZFT.
    * @param _feeType quel frais est modifié. 1 = tokenizationFee, 2 = deTokenizationFee et 3 = transferFee
    * @param _newAmount nouvelle valeur des frais
    * @return processing status
    */
    function changeFee(uint8 _feeType, uint256 _newAmount) external boardOrAdmin returns (bool) {
        require(_newAmount<=2, "Definition du white paper invalide ou depassee");
        require(_feeType >0 && _feeType<=3, "Type de frais invalide");
        if (_feeType == 1) {
            tokenizationFee = _newAmount;
        } else if (_feeType == 2) {
            deTokenizationFee = _newAmount;
        } else if (_feeType == 3) {
            transferFee = _newAmount;
        }
        return true;
    }

    /**
     * @dev ERC20 balanceOf
     * @param _owner Owner address
     * @return True if success
     */
    function balanceOf(address _owner) public override view returns (uint256) {
        return balances[_owner];
    }

    /**
     * @dev ERC20 allowance
     * @param _owner Adresse du Owner
     * @param _spender Adresse autorisée à dépenser à partir du solde du Owner
     * @return uint256 allowance
     */
    function allowance(address _owner, address _spender)
        override
        external
        view
        returns (uint256)
    {
        return allowed[_owner][_spender];
    }

    /**
     * @dev Les transferts sont-ils actuellement refusés?
     * @return True si interdit
     */
    function isLocked() public view returns (bool) {
        return lockedUntilBlock > block.number;
    }

    /**
     * @dev Vérifier si les paramètres du transfert sont valides
     * @param _from Adresse source
     * @param _to Adresse de destination
     * @param _amount Montant à vérifier
     * @return True si valide
     */
    function isTransferValid(address _from, address _to, uint256 _amount)
        public
        view
        returns (bool)
    {
        if (_from == address(0)) {
            return false;
        }

        if (_to == address(0) || _to == admin) {
            return false;
        }

        bool fromOK = true;
        bool toOK = true;

        return
            balances[_from] >= _amount && // solde suffisant
            fromOK && // un détenteur vendeur dans la liste blanche
            toOK; // un titulaire acheteur dans la liste blanche
    }
        /**
    * @dev Calcule les frais de ZTrade sur les opérations de création, de destruction et de transfert.
    * @param _fee valeur des frais
    * @param _amount montant de la transaction
    * @return serviceAmount valeur à payer à Ztrade
    * @return netAmount montant après frais
    */
    function calcFees(uint256 _fee, uint256 _amount) public pure returns(uint256 serviceAmount, uint256 netAmount ) {
        serviceAmount = (_amount.mul(_fee)) / 100;
        netAmount = _amount.sub(serviceAmount);
        return (serviceAmount, netAmount);
    }
}

