module 0x32d2a01bcb6c608de3d9ceee275d6bbeecf7c0d154da13ed626472896e7386f3::ofertas {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Config has key {
        id: 0x2::object::UID,
        fee_bps: u64,
        destino: address,
    }

    struct Oferta<phantom T0> has key {
        id: 0x2::object::UID,
        comprador: address,
        precio: u64,
        fee: u64,
        nft: 0x1::option::Option<0x2::object::ID>,
        fondos: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct Entrega<T0: store + key> {
        item: T0,
        comprador: address,
    }

    struct OfertaCreada<phantom T0> has copy, drop {
        oferta: 0x2::object::ID,
        comprador: address,
        precio: u64,
        fee: u64,
        nft: 0x1::option::Option<0x2::object::ID>,
    }

    struct OfertaCancelada<phantom T0> has copy, drop {
        oferta: 0x2::object::ID,
        comprador: address,
    }

    struct OfertaAceptada<phantom T0> has copy, drop {
        oferta: 0x2::object::ID,
        vendedor: address,
        comprador: address,
        precio: u64,
        nft: 0x2::object::ID,
    }

    public fun aceptar<T0: store + key>(arg0: Oferta<T0>, arg1: &Config, arg2: &mut 0x2::kiosk::Kiosk, arg3: 0x2::object::ID, arg4: &mut 0x2::tx_context::TxContext) : (Entrega<T0>, 0x2::transfer_policy::TransferRequest<T0>) {
        if (0x1::option::is_some<0x2::object::ID>(&arg0.nft)) {
            assert!(*0x1::option::borrow<0x2::object::ID>(&arg0.nft) == arg3, 4);
        };
        let Oferta {
            id        : v0,
            comprador : v1,
            precio    : v2,
            fee       : v3,
            nft       : _,
            fondos    : v5,
        } = arg0;
        let v6 = v5;
        let v7 = v0;
        if (v3 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut v6, v3, arg4), arg1.destino);
        };
        let (v8, v9) = 0x2::kiosk::purchase<T0>(arg2, arg3, 0x2::coin::from_balance<0x2::sui::SUI>(v6, arg4));
        let v10 = OfertaAceptada<T0>{
            oferta    : 0x2::object::uid_to_inner(&v7),
            vendedor  : 0x2::kiosk::owner(arg2),
            comprador : v1,
            precio    : v2,
            nft       : arg3,
        };
        0x2::event::emit<OfertaAceptada<T0>>(v10);
        0x2::object::delete(v7);
        let v11 = Entrega<T0>{
            item      : v8,
            comprador : v1,
        };
        (v11, v9)
    }

    public fun cancelar<T0: store + key>(arg0: Oferta<T0>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(arg0.comprador == 0x2::tx_context::sender(arg1), 3);
        let Oferta {
            id        : v0,
            comprador : v1,
            precio    : _,
            fee       : _,
            nft       : _,
            fondos    : v5,
        } = arg0;
        let v6 = v0;
        let v7 = OfertaCancelada<T0>{
            oferta    : 0x2::object::uid_to_inner(&v6),
            comprador : v1,
        };
        0x2::event::emit<OfertaCancelada<T0>>(v7);
        0x2::object::delete(v6);
        0x2::coin::from_balance<0x2::sui::SUI>(v5, arg1)
    }

    public fun comision(arg0: &Config, arg1: u64) : u64 {
        (((arg1 as u128) * (arg0.fee_bps as u128) / 10000) as u64)
    }

    public fun comprador<T0>(arg0: &Oferta<T0>) : address {
        arg0.comprador
    }

    public fun entregar<T0: store + key>(arg0: Entrega<T0>, arg1: &0x2::transfer_policy::TransferPolicy<T0>, arg2: 0x2::transfer_policy::TransferRequest<T0>) {
        let (_, _, _) = 0x2::transfer_policy::confirm_request<T0>(arg1, arg2);
        let Entrega {
            item      : v3,
            comprador : v4,
        } = arg0;
        0x2::transfer::public_transfer<T0>(v3, v4);
    }

    public fun fijar(arg0: &AdminCap, arg1: &mut Config, arg2: u64, arg3: address) {
        assert!(arg2 <= 1000, 5);
        arg1.fee_bps = arg2;
        arg1.destino = arg3;
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = Config{
            id      : 0x2::object::new(arg0),
            fee_bps : 100,
            destino : 0x2::tx_context::sender(arg0),
        };
        0x2::transfer::share_object<Config>(v1);
    }

    public fun nft<T0>(arg0: &Oferta<T0>) : 0x1::option::Option<0x2::object::ID> {
        arg0.nft
    }

    public fun ofertar<T0: store + key>(arg0: &Config, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: 0x1::option::Option<0x2::object::ID>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 > 0, 1);
        let v0 = comision(arg0, arg2);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) == arg2 + v0, 2);
        let v1 = Oferta<T0>{
            id        : 0x2::object::new(arg4),
            comprador : 0x2::tx_context::sender(arg4),
            precio    : arg2,
            fee       : v0,
            nft       : arg3,
            fondos    : 0x2::coin::into_balance<0x2::sui::SUI>(arg1),
        };
        let v2 = OfertaCreada<T0>{
            oferta    : 0x2::object::id<Oferta<T0>>(&v1),
            comprador : v1.comprador,
            precio    : arg2,
            fee       : v0,
            nft       : arg3,
        };
        0x2::event::emit<OfertaCreada<T0>>(v2);
        0x2::transfer::share_object<Oferta<T0>>(v1);
    }

    public fun precio<T0>(arg0: &Oferta<T0>) : u64 {
        arg0.precio
    }

    // decompiled from Move bytecode v7
}

