module 0xc7e98a8457e61aed66108657e5e374cbc4bf9caff5b44b62c01dbb2cc0a64db0::bond {
    struct BOND has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Coleccion has key {
        id: 0x2::object::UID,
        creador: address,
        validador: address,
        precio: u64,
        acunadas: u64,
        tope: u64,
        abierta: bool,
    }

    struct Nugget has store, key {
        id: 0x2::object::UID,
        numero: u64,
        stake: 0x3::staking_pool::StakedSui,
        validador: address,
        principal_display: u64,
    }

    struct Acunada has copy, drop {
        pepita: 0x2::object::ID,
        numero: u64,
        principal: u64,
        validador: address,
        activacion: u64,
        minero: address,
    }

    struct Fundida has copy, drop {
        pepita: 0x2::object::ID,
        numero: u64,
        principal: u64,
        rescatado: u64,
        portador: address,
    }

    public fun activacion(arg0: &Nugget) : u64 {
        0x3::staking_pool::stake_activation_epoch(&arg0.stake)
    }

    public fun acunadas(arg0: &Coleccion) : u64 {
        arg0.acunadas
    }

    public fun acunar(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : Nugget {
        let v0 = 0x3::sui_system::request_add_stake_non_entry(arg0, arg1, arg2, arg4);
        let v1 = 0x2::object::new(arg4);
        let v2 = Acunada{
            pepita     : 0x2::object::uid_to_inner(&v1),
            numero     : arg3,
            principal  : 0x3::staking_pool::staked_sui_amount(&v0),
            validador  : arg2,
            activacion : 0x3::staking_pool::stake_activation_epoch(&v0),
            minero     : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<Acunada>(v2);
        Nugget{
            id                : v1,
            numero            : arg3,
            stake             : v0,
            validador         : arg2,
            principal_display : 0x3::staking_pool::staked_sui_amount(&v0),
        }
    }

    public fun cerrar(arg0: &AdminCap, arg1: &mut Coleccion) {
        arg1.abierta = false;
    }

    public fun crear_coleccion(arg0: &AdminCap, arg1: address, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = Coleccion{
            id        : 0x2::object::new(arg4),
            creador   : 0x2::tx_context::sender(arg4),
            validador : arg1,
            precio    : arg2,
            acunadas  : 0,
            tope      : arg3,
            abierta   : true,
        };
        0x2::transfer::share_object<Coleccion>(v0);
    }

    public fun fundir(arg0: Nugget, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let Nugget {
            id                : v0,
            numero            : v1,
            stake             : v2,
            validador         : _,
            principal_display : _,
        } = arg0;
        let v5 = v2;
        let v6 = v0;
        0x2::object::delete(v6);
        let v7 = 0x3::sui_system::request_withdraw_stake_non_entry(arg1, v5, arg2);
        let v8 = Fundida{
            pepita    : 0x2::object::uid_to_inner(&v6),
            numero    : v1,
            principal : 0x3::staking_pool::staked_sui_amount(&v5),
            rescatado : 0x2::balance::value<0x2::sui::SUI>(&v7),
            portador  : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<Fundida>(v8);
        0x2::coin::from_balance<0x2::sui::SUI>(v7, arg2)
    }

    entry fun fundir_a(arg0: Nugget, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(fundir(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: BOND, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<BOND>(arg0, arg1);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"principal"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"validador"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"project_url"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"Gold Nugget #{numero}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"Pepita con oro de verdad dentro: una posicion de staking nativo de Sui. Quien posea la pepita puede fundirla y rescatar el principal mas los premios acumulados. El contenido es verificable en cadena por cualquiera."));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://goldnuggetsales.com/images/11-25-25%20TM%20RB%20M%20T%20California%20Natural%20Gold%20Nugget--45.jpg"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{principal_display}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{validador}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://docs.sui.io/concepts/tokenomics/staking-unstaking"));
        let v5 = 0x2::display::new_with_fields<Nugget>(&v0, v1, v3, arg1);
        0x2::display::update_version<Nugget>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Nugget>>(v5, 0x2::tx_context::sender(arg1));
        let v6 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v6, 0x2::tx_context::sender(arg1));
    }

    entry fun mint(arg0: &mut Coleccion, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x2::kiosk::KioskOwnerCap, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.abierta, 3);
        assert!(arg0.acunadas < arg0.tope, 2);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) == arg0.precio, 1);
        arg0.acunadas = arg0.acunadas + 1;
        0x2::kiosk::place<Nugget>(arg3, arg4, acunar(arg1, arg2, arg0.validador, arg0.acunadas, arg5));
    }

    public fun numero(arg0: &Nugget) : u64 {
        arg0.numero
    }

    public fun partir(arg0: &mut Nugget, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : Nugget {
        let v0 = 0x3::staking_pool::split(&mut arg0.stake, arg1, arg2);
        arg0.principal_display = 0x3::staking_pool::staked_sui_amount(&arg0.stake);
        Nugget{
            id                : 0x2::object::new(arg2),
            numero            : arg0.numero,
            stake             : v0,
            validador         : arg0.validador,
            principal_display : 0x3::staking_pool::staked_sui_amount(&v0),
        }
    }

    public fun pool(arg0: &Nugget) : 0x2::object::ID {
        0x3::staking_pool::pool_id(&arg0.stake)
    }

    public fun precio(arg0: &Coleccion) : u64 {
        arg0.precio
    }

    public fun principal(arg0: &Nugget) : u64 {
        0x3::staking_pool::staked_sui_amount(&arg0.stake)
    }

    public fun tope(arg0: &Coleccion) : u64 {
        arg0.tope
    }

    public fun validador(arg0: &Nugget) : address {
        arg0.validador
    }

    // decompiled from Move bytecode v7
}

