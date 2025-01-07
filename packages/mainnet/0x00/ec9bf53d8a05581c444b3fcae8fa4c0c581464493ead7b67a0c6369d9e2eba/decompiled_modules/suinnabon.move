module 0xec9bf53d8a05581c444b3fcae8fa4c0c581464493ead7b67a0c6369d9e2eba::suinnabon {
    struct SUINNABON has drop {
        dummy_field: bool,
    }

    struct TokenConfig has store, key {
        id: 0x2::object::UID,
        treasury_cap: 0x2::coin::TreasuryCap<SUINNABON>,
        owner: address,
        trading_enabled: bool,
        total_supply: u64,
    }

    struct ExtendedMetadata has store, key {
        id: 0x2::object::UID,
        twitter: 0x1::string::String,
        telegram: 0x1::string::String,
        discord: 0x1::string::String,
    }

    struct DeploymentEvent has copy, drop {
        total_supply: u64,
        timestamp: u64,
    }

    struct TransferCap has store, key {
        id: 0x2::object::UID,
    }

    public entry fun transfer(arg0: &mut TokenConfig, arg1: &TransferCap, arg2: 0x2::coin::Coin<SUINNABON>, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert_transfer_cap(arg1);
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(arg0.trading_enabled || v0 == arg0.owner, 2);
        if (v0 != arg0.owner) {
            assert!(0x2::coin::value<SUINNABON>(&arg2) <= arg0.total_supply * 100 / 10000, 3);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<SUINNABON>>(arg2, arg3);
    }

    public fun assert_transfer_cap(arg0: &TransferCap) {
    }

    public entry fun emergency_pause_trading(arg0: &mut TokenConfig, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 1);
        arg0.trading_enabled = false;
    }

    public entry fun emergency_resume_trading(arg0: &mut TokenConfig, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 1);
        arg0.trading_enabled = true;
    }

    public entry fun enable_trading(arg0: &mut TokenConfig, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 1);
        arg0.trading_enabled = true;
    }

    public fun get_discord(arg0: &ExtendedMetadata) : 0x1::string::String {
        arg0.discord
    }

    public fun get_telegram(arg0: &ExtendedMetadata) : 0x1::string::String {
        arg0.telegram
    }

    public fun get_total_supply(arg0: &TokenConfig) : u64 {
        arg0.total_supply
    }

    public fun get_twitter(arg0: &ExtendedMetadata) : 0x1::string::String {
        arg0.twitter
    }

    fun init(arg0: SUINNABON, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SUINNABON>(arg0, 6, b"SUINNABON", b"SUInnabon", x"5355496e6e61626f6e20697320612073776565742c2063696e6e616d6f6e20726f6c6c2d7468656d6564206d656d6520636f696e2062616b6564206672657368206f6e205355492e205361746973667920796f75722063727970746f2063726176696e67732c2073686172652074686520646f7567687920676f6f646e6573732c20616e6420656e6a6f79206120737769726c206f6620636f6d6d756e6974792d64726976656e2066756ee280946e6f206f76656e206d6974747320726571756972656421", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://indigo-major-wasp-611.mypinata.cloud/ipfs/bafybeic2ncbpv47t4svpr5xydjfvejjgrxh7m7vmpzgionoqbk5ysncy7u")), arg1);
        let v3 = TokenConfig{
            id              : 0x2::object::new(arg1),
            treasury_cap    : v1,
            owner           : v0,
            trading_enabled : false,
            total_supply    : 10000000000000000,
        };
        let v4 = TransferCap{id: 0x2::object::new(arg1)};
        let v5 = ExtendedMetadata{
            id       : 0x2::object::new(arg1),
            twitter  : 0x1::string::utf8(b"https://x.com/SUInnabon"),
            telegram : 0x1::string::utf8(b"https://t.me/suinnabon"),
            discord  : 0x1::string::utf8(b"https://discord.gg/d8KpPXtf"),
        };
        let v6 = DeploymentEvent{
            total_supply : 10000000000000000,
            timestamp    : 0x2::tx_context::epoch_timestamp_ms(arg1),
        };
        0x2::event::emit<DeploymentEvent>(v6);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUINNABON>>(v2);
        0x2::transfer::public_share_object<ExtendedMetadata>(v5);
        0x2::transfer::public_share_object<TransferCap>(v4);
        0x2::transfer::public_share_object<TokenConfig>(v3);
        0x2::transfer::public_transfer<0x2::coin::Coin<SUINNABON>>(0x2::coin::mint<SUINNABON>(&mut v3.treasury_cap, 10000000000000000, arg1), v0);
    }

    public fun is_trading_enabled(arg0: &TokenConfig) : bool {
        arg0.trading_enabled
    }

    // decompiled from Move bytecode v6
}

