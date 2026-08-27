module 0xb219fbdc681e8e39405b809baa7ec36009329ed88871aab2fc9c62b13eefa10b::registrar_v1 {
    struct Registrar has key {
        id: 0x2::object::UID,
        version: u64,
        fee_usd_micros: u64,
        paused: bool,
        treasury: 0x2::balance::Balance<0x2::sui::SUI>,
        sales: u64,
        gross_mist: u64,
    }

    struct RegistrarCap has store, key {
        id: 0x2::object::UID,
        registrar: 0x2::object::ID,
    }

    struct NameSold has copy, drop {
        registrar: 0x2::object::ID,
        buyer: address,
        domain: 0x1::string::String,
        years: u8,
        base_amount_mist: u64,
        fee_usd_micros: u64,
        fee_mist: u64,
        sold_at_ms: u64,
    }

    struct FeeChanged has copy, drop {
        registrar: 0x2::object::ID,
        from_usd_micros: u64,
        to_usd_micros: u64,
    }

    struct PausedChanged has copy, drop {
        registrar: 0x2::object::ID,
        paused: bool,
    }

    struct Withdrawn has copy, drop {
        registrar: 0x2::object::ID,
        amount_mist: u64,
        to: address,
    }

    fun assert_cap(arg0: &Registrar, arg1: &RegistrarCap) {
        assert!(arg1.registrar == 0x2::object::uid_to_inner(&arg0.id), 4);
    }

    public fun collect_fee(arg0: &mut Registrar, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: u64, arg4: 0x1::string::String, arg5: u8, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(arg0.version == 1, 0);
        assert!(!arg0.paused, 1);
        assert!(0x1::string::length(&arg4) > 0, 5);
        assert!(arg5 > 0, 6);
        let v0 = if (arg0.fee_usd_micros == 0) {
            0
        } else {
            arg2
        };
        if (v0 > 0) {
            assert!(v0 >= arg0.fee_usd_micros * 10, 8);
            assert!(v0 <= arg0.fee_usd_micros * 10000, 8);
        };
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) >= v0, 2);
        if (v0 > 0) {
            0x2::balance::join<0x2::sui::SUI>(&mut arg0.treasury, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut arg1, v0, arg7)));
        };
        arg0.sales = arg0.sales + 1;
        arg0.gross_mist = arg0.gross_mist + v0;
        let v1 = NameSold{
            registrar        : 0x2::object::uid_to_inner(&arg0.id),
            buyer            : 0x2::tx_context::sender(arg7),
            domain           : arg4,
            years            : arg5,
            base_amount_mist : arg3,
            fee_usd_micros   : arg0.fee_usd_micros,
            fee_mist         : v0,
            sold_at_ms       : 0x2::clock::timestamp_ms(arg6),
        };
        0x2::event::emit<NameSold>(v1);
        arg1
    }

    public fun fee_usd_micros(arg0: &Registrar) : u64 {
        arg0.fee_usd_micros
    }

    public fun gross_mist(arg0: &Registrar) : u64 {
        arg0.gross_mist
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Registrar{
            id             : 0x2::object::new(arg0),
            version        : 1,
            fee_usd_micros : 0,
            paused         : true,
            treasury       : 0x2::balance::zero<0x2::sui::SUI>(),
            sales          : 0,
            gross_mist     : 0,
        };
        let v1 = RegistrarCap{
            id        : 0x2::object::new(arg0),
            registrar : 0x2::object::uid_to_inner(&v0.id),
        };
        0x2::transfer::transfer<RegistrarCap>(v1, 0x2::tx_context::sender(arg0));
        0x2::transfer::share_object<Registrar>(v0);
    }

    public fun max_fee_usd_micros() : u64 {
        100000000
    }

    public fun max_mist_per_usd_micro() : u64 {
        10000
    }

    public fun migrate(arg0: &mut Registrar, arg1: &RegistrarCap) {
        assert_cap(arg0, arg1);
        assert!(arg0.version < 1, 0);
        arg0.version = 1;
    }

    public fun min_mist_per_usd_micro() : u64 {
        10
    }

    public fun paused(arg0: &Registrar) : bool {
        arg0.paused
    }

    public fun sales(arg0: &Registrar) : u64 {
        arg0.sales
    }

    public fun set_fee_usd(arg0: &mut Registrar, arg1: &RegistrarCap, arg2: u64) {
        assert_cap(arg0, arg1);
        assert!(arg0.version == 1, 0);
        assert!(arg2 <= 100000000, 3);
        let v0 = FeeChanged{
            registrar       : 0x2::object::uid_to_inner(&arg0.id),
            from_usd_micros : arg0.fee_usd_micros,
            to_usd_micros   : arg2,
        };
        0x2::event::emit<FeeChanged>(v0);
        arg0.fee_usd_micros = arg2;
    }

    public fun set_paused(arg0: &mut Registrar, arg1: &RegistrarCap, arg2: bool) {
        assert_cap(arg0, arg1);
        assert!(arg0.version == 1, 0);
        arg0.paused = arg2;
        let v0 = PausedChanged{
            registrar : 0x2::object::uid_to_inner(&arg0.id),
            paused    : arg2,
        };
        0x2::event::emit<PausedChanged>(v0);
    }

    public fun treasury_mist(arg0: &Registrar) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.treasury)
    }

    public fun version(arg0: &Registrar) : u64 {
        arg0.version
    }

    public fun withdraw(arg0: &mut Registrar, arg1: &RegistrarCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert_cap(arg0, arg1);
        assert!(arg0.version == 1, 0);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.treasury) >= arg2, 7);
        let v0 = Withdrawn{
            registrar   : 0x2::object::uid_to_inner(&arg0.id),
            amount_mist : arg2,
            to          : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<Withdrawn>(v0);
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.treasury, arg2), arg3)
    }

    // decompiled from Move bytecode v7
}

