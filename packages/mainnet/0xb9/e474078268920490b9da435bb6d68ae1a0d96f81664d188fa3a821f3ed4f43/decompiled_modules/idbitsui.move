module 0xb9e474078268920490b9da435bb6d68ae1a0d96f81664d188fa3a821f3ed4f43::idbitsui {
    struct IDBITSUI has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
        paused_mint: bool,
    }

    struct MinterCap has store, key {
        id: 0x2::object::UID,
    }

    struct BridgeCap has store, key {
        id: 0x2::object::UID,
    }

    struct Version has key {
        id: 0x2::object::UID,
        major: u64,
        minor: u64,
        patch: u64,
    }

    struct Config has key {
        id: 0x2::object::UID,
        bridge_operator: address,
    }

    struct Minted has copy, drop {
        to: address,
        amount: u64,
        by_bridge: bool,
    }

    struct Burned has copy, drop {
        from: address,
        amount: u64,
        by_bridge: bool,
    }

    struct PausedMint has copy, drop {
        paused: bool,
    }

    struct Upgraded has copy, drop {
        major: u64,
        minor: u64,
        patch: u64,
    }

    public fun admin_burn(arg0: &mut 0x2::coin::TreasuryCap<IDBITSUI>, arg1: 0x2::coin::Coin<IDBITSUI>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::burn<IDBITSUI>(arg0, arg1);
        let v0 = Burned{
            from      : 0x2::tx_context::sender(arg2),
            amount    : 0x2::coin::value<IDBITSUI>(&arg1),
            by_bridge : false,
        };
        0x2::event::emit<Burned>(v0);
    }

    public fun bridge_burn(arg0: &mut 0x2::coin::TreasuryCap<IDBITSUI>, arg1: &BridgeCap, arg2: &Config, arg3: 0x2::coin::Coin<IDBITSUI>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg2.bridge_operator, 1002);
        0x2::coin::burn<IDBITSUI>(arg0, arg3);
        let v0 = Burned{
            from      : 0x2::tx_context::sender(arg4),
            amount    : 0x2::coin::value<IDBITSUI>(&arg3),
            by_bridge : true,
        };
        0x2::event::emit<Burned>(v0);
    }

    public fun bridge_mint_to(arg0: &AdminCap, arg1: &mut 0x2::coin::TreasuryCap<IDBITSUI>, arg2: &BridgeCap, arg3: &Config, arg4: address, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused_mint, 2);
        assert!(0x2::tx_context::sender(arg6) == arg3.bridge_operator, 1001);
        0x2::coin::mint_and_transfer<IDBITSUI>(arg1, arg5, arg4, arg6);
        let v0 = Minted{
            to        : arg4,
            amount    : arg5,
            by_bridge : true,
        };
        0x2::event::emit<Minted>(v0);
    }

    public fun grant_bridge(arg0: &AdminCap, arg1: BridgeCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<BridgeCap>(arg1, arg2);
    }

    public fun grant_minter(arg0: &AdminCap, arg1: MinterCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<MinterCap>(arg1, arg2);
    }

    fun init(arg0: IDBITSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IDBITSUI>(arg0, 9, b"IDT", b"IDBit", b"IDBit Utility Token on Sui", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<IDBITSUI>>(v1);
        let v2 = AdminCap{
            id          : 0x2::object::new(arg1),
            paused_mint : false,
        };
        let v3 = MinterCap{id: 0x2::object::new(arg1)};
        let v4 = BridgeCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<MinterCap>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<BridgeCap>(v4, 0x2::tx_context::sender(arg1));
        let v5 = Version{
            id    : 0x2::object::new(arg1),
            major : 1,
            minor : 0,
            patch : 0,
        };
        0x2::transfer::share_object<Version>(v5);
        let v6 = Config{
            id              : 0x2::object::new(arg1),
            bridge_operator : 0x2::tx_context::sender(arg1),
        };
        0x2::transfer::share_object<Config>(v6);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IDBITSUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint_to(arg0: &AdminCap, arg1: &mut 0x2::coin::TreasuryCap<IDBITSUI>, arg2: &MinterCap, arg3: address, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused_mint, 1);
        0x2::coin::mint_and_transfer<IDBITSUI>(arg1, arg4, arg3, arg5);
        let v0 = Minted{
            to        : arg3,
            amount    : arg4,
            by_bridge : false,
        };
        0x2::event::emit<Minted>(v0);
    }

    public fun register_for(arg0: address, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<IDBITSUI>>(0x2::coin::zero<IDBITSUI>(arg1), arg0);
    }

    public fun set_bridge_operator(arg0: &AdminCap, arg1: &mut Config, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.bridge_operator = arg2;
    }

    public fun set_pause_mint(arg0: &mut AdminCap, arg1: bool, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.paused_mint = arg1;
        let v0 = PausedMint{paused: arg1};
        0x2::event::emit<PausedMint>(v0);
    }

    public fun set_version(arg0: &AdminCap, arg1: &mut Version, arg2: u64, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        arg1.major = arg2;
        arg1.minor = arg3;
        arg1.patch = arg4;
        let v0 = Upgraded{
            major : arg2,
            minor : arg3,
            patch : arg4,
        };
        0x2::event::emit<Upgraded>(v0);
    }

    // decompiled from Move bytecode v6
}

