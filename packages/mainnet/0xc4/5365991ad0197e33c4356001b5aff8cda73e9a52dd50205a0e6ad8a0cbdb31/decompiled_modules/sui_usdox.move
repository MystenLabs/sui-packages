module 0xc45365991ad0197e33c4356001b5aff8cda73e9a52dd50205a0e6ad8a0cbdb31::sui_usdox {
    struct SUI_USDOX has drop {
        dummy_field: bool,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct TokenConfig has key {
        id: 0x2::object::UID,
        paused: bool,
        total_minted: u64,
        total_burned: u64,
        admin_address: address,
        max_supply: u64,
    }

    struct TokenCreated has copy, drop {
        initial_supply: u64,
        max_supply: u64,
        creator: address,
        timestamp: u64,
    }

    struct MintEvent has copy, drop {
        amount: u64,
        recipient: address,
        total_supply: u64,
        minter: address,
    }

    struct BurnEvent has copy, drop {
        amount: u64,
        burner: address,
        total_supply: u64,
    }

    struct PauseEvent has copy, drop {
        paused: bool,
        admin: address,
    }

    struct AdminTransferred has copy, drop {
        old_admin: address,
        new_admin: address,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SUI_USDOX>, arg1: &mut TokenConfig, arg2: 0x2::coin::Coin<SUI_USDOX>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg1.paused, 3);
        let v0 = 0x2::coin::value<SUI_USDOX>(&arg2);
        0x2::coin::burn<SUI_USDOX>(arg0, arg2);
        arg1.total_burned = arg1.total_burned + v0;
        let v1 = BurnEvent{
            amount       : v0,
            burner       : 0x2::tx_context::sender(arg3),
            total_supply : 0x2::coin::total_supply<SUI_USDOX>(arg0),
        };
        0x2::event::emit<BurnEvent>(v1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUI_USDOX>, arg1: &mut TokenConfig, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!arg1.paused, 3);
        assert!(arg2 > 0, 4);
        assert!(0x2::coin::total_supply<SUI_USDOX>(arg0) + arg2 <= arg1.max_supply, 2);
        arg1.total_minted = arg1.total_minted + arg2;
        let v0 = MintEvent{
            amount       : arg2,
            recipient    : arg3,
            total_supply : 0x2::coin::total_supply<SUI_USDOX>(arg0),
            minter       : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<MintEvent>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<SUI_USDOX>>(0x2::coin::mint<SUI_USDOX>(arg0, arg2, arg4), arg3);
    }

    public fun admin_address(arg0: &TokenConfig) : address {
        arg0.admin_address
    }

    public fun circulating_supply(arg0: &TokenConfig) : u64 {
        arg0.total_minted - arg0.total_burned
    }

    public fun coin_value(arg0: &0x2::coin::Coin<SUI_USDOX>) : u64 {
        0x2::coin::value<SUI_USDOX>(arg0)
    }

    public entry fun emergency_mint(arg0: &AdminCap, arg1: &mut 0x2::coin::TreasuryCap<SUI_USDOX>, arg2: &mut TokenConfig, arg3: u64, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg3 > 0, 4);
        assert!(0x2::coin::total_supply<SUI_USDOX>(arg1) + arg3 <= arg2.max_supply, 2);
        arg2.total_minted = arg2.total_minted + arg3;
        let v0 = MintEvent{
            amount       : arg3,
            recipient    : arg4,
            total_supply : 0x2::coin::total_supply<SUI_USDOX>(arg1),
            minter       : 0x2::tx_context::sender(arg5),
        };
        0x2::event::emit<MintEvent>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<SUI_USDOX>>(0x2::coin::mint<SUI_USDOX>(arg1, arg3, arg5), arg4);
    }

    public fun get_token_info() : (vector<u8>, vector<u8>, u8, u64) {
        (b"USD0X", b"Sui USD0X", 6, 1000000000000)
    }

    fun init(arg0: SUI_USDOX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUI_USDOX>(arg0, 6, b"USD0X", b"Sui USD0X", b"Sui USD0X - Advanced stablecoin for DeFi ecosystem on Sui blockchain with enhanced stability features", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://sui-usdox.com/logo.png")), arg1);
        let v2 = v0;
        let v3 = 1000000000000;
        let v4 = 100000000000000;
        let v5 = AdminCap{id: 0x2::object::new(arg1)};
        let v6 = TokenConfig{
            id            : 0x2::object::new(arg1),
            paused        : false,
            total_minted  : v3,
            total_burned  : 0,
            admin_address : 0x2::tx_context::sender(arg1),
            max_supply    : v4,
        };
        let v7 = TokenCreated{
            initial_supply : v3,
            max_supply     : v4,
            creator        : 0x2::tx_context::sender(arg1),
            timestamp      : 0x2::tx_context::epoch_timestamp_ms(arg1),
        };
        0x2::event::emit<TokenCreated>(v7);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUI_USDOX>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<SUI_USDOX>>(0x2::coin::mint<SUI_USDOX>(&mut v2, v3, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::transfer<AdminCap>(v5, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUI_USDOX>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::share_object<TokenConfig>(v6);
    }

    public fun is_paused(arg0: &TokenConfig) : bool {
        arg0.paused
    }

    public fun join_coins(arg0: &mut 0x2::coin::Coin<SUI_USDOX>, arg1: 0x2::coin::Coin<SUI_USDOX>) {
        0x2::coin::join<SUI_USDOX>(arg0, arg1);
    }

    public fun max_supply(arg0: &TokenConfig) : u64 {
        arg0.max_supply
    }

    public entry fun set_pause(arg0: &AdminCap, arg1: &mut TokenConfig, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.paused = arg2;
        let v0 = PauseEvent{
            paused : arg2,
            admin  : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<PauseEvent>(v0);
    }

    public fun split_coin(arg0: &mut 0x2::coin::Coin<SUI_USDOX>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<SUI_USDOX> {
        0x2::coin::split<SUI_USDOX>(arg0, arg1, arg2)
    }

    public fun total_burned(arg0: &TokenConfig) : u64 {
        arg0.total_burned
    }

    public fun total_minted(arg0: &TokenConfig) : u64 {
        arg0.total_minted
    }

    public entry fun transfer_admin(arg0: AdminCap, arg1: &mut TokenConfig, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.admin_address = arg2;
        let v0 = AdminTransferred{
            old_admin : arg1.admin_address,
            new_admin : arg2,
        };
        0x2::event::emit<AdminTransferred>(v0);
        0x2::transfer::transfer<AdminCap>(arg0, arg2);
    }

    // decompiled from Move bytecode v6
}

