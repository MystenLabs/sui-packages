module 0xcde3742ecf16827607e89e5624e49cba1de41c16f5ab4028a035cfa51a476cb2::gri {
    struct GRI has drop {
        dummy_field: bool,
    }

    struct GriPegState has store {
        multisig_admin: address,
        btc_backing_sats: u64,
        total_minted: u64,
        total_burned: u64,
        gri_per_btc: u64,
    }

    struct GriAdminCap has store, key {
        id: 0x2::object::UID,
        treasury_cap: 0x2::coin::TreasuryCap<GRI>,
        peg_state: GriPegState,
    }

    struct MintEvent has copy, drop {
        recipient: address,
        amount: u64,
        new_total_supply: u64,
    }

    struct BurnEvent has copy, drop {
        owner: address,
        amount: u64,
        new_total_supply: u64,
    }

    public entry fun burn(arg0: &mut GriAdminCap, arg1: 0x2::coin::Coin<GRI>, arg2: &mut 0x2::tx_context::TxContext) {
        assert_multisig_only(arg0, arg2);
        let v0 = 0x2::coin::value<GRI>(&arg1);
        0x2::coin::burn<GRI>(&mut arg0.treasury_cap, arg1);
        arg0.peg_state.total_burned = arg0.peg_state.total_burned + v0;
        let v1 = BurnEvent{
            owner            : 0x2::tx_context::sender(arg2),
            amount           : v0,
            new_total_supply : circulating_supply(arg0),
        };
        0x2::event::emit<BurnEvent>(v1);
    }

    public entry fun join(arg0: &mut 0x2::coin::Coin<GRI>, arg1: 0x2::coin::Coin<GRI>) {
        0x2::coin::join<GRI>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut GriAdminCap, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert_multisig_only(arg0, arg3);
        let v0 = circulating_supply(arg0);
        assert!(v0 + arg1 <= max_allowed_supply(arg0), 2);
        arg0.peg_state.total_minted = arg0.peg_state.total_minted + arg1;
        0x2::transfer::public_transfer<0x2::coin::Coin<GRI>>(0x2::coin::mint<GRI>(&mut arg0.treasury_cap, arg1, arg3), arg2);
        let v1 = MintEvent{
            recipient        : arg2,
            amount           : arg1,
            new_total_supply : v0 + arg1,
        };
        0x2::event::emit<MintEvent>(v1);
    }

    public entry fun update_description(arg0: &GriAdminCap, arg1: &mut 0x2::coin::CoinMetadata<GRI>, arg2: vector<u8>, arg3: &0x2::tx_context::TxContext) {
        assert_multisig_only(arg0, arg3);
        0x2::coin::update_description<GRI>(&arg0.treasury_cap, arg1, 0x1::string::utf8(arg2));
    }

    public entry fun update_icon_url(arg0: &GriAdminCap, arg1: &mut 0x2::coin::CoinMetadata<GRI>, arg2: vector<u8>, arg3: &0x2::tx_context::TxContext) {
        assert_multisig_only(arg0, arg3);
        0x2::coin::update_icon_url<GRI>(&arg0.treasury_cap, arg1, 0x1::ascii::string(arg2));
    }

    public entry fun update_name(arg0: &GriAdminCap, arg1: &mut 0x2::coin::CoinMetadata<GRI>, arg2: vector<u8>, arg3: &0x2::tx_context::TxContext) {
        assert_multisig_only(arg0, arg3);
        0x2::coin::update_name<GRI>(&arg0.treasury_cap, arg1, 0x1::string::utf8(arg2));
    }

    fun assert_multisig_only(arg0: &GriAdminCap, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.peg_state.multisig_admin, 1);
    }

    public fun circulating_supply(arg0: &GriAdminCap) : u64 {
        arg0.peg_state.total_minted - arg0.peg_state.total_burned
    }

    fun init(arg0: GRI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GRI>(arg0, 6, b"GRI", b"GRI Stablecoin", b"BTC-pegged L2 payment token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://sct.grigolato.it/b2c/static/image/favicon-96x96.png")), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GRI>>(v1);
        let v2 = 0x2::tx_context::sender(arg1);
        let v3 = GriPegState{
            multisig_admin   : v2,
            btc_backing_sats : 0,
            total_minted     : 0,
            total_burned     : 0,
            gri_per_btc      : 100000,
        };
        let v4 = GriAdminCap{
            id           : 0x2::object::new(arg1),
            treasury_cap : v0,
            peg_state    : v3,
        };
        0x2::transfer::public_transfer<GriAdminCap>(v4, v2);
    }

    public fun max_allowed_supply(arg0: &GriAdminCap) : u64 {
        arg0.peg_state.btc_backing_sats / 100000000 * arg0.peg_state.gri_per_btc
    }

    public entry fun set_btc_backing_sats(arg0: &mut GriAdminCap, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert_multisig_only(arg0, arg2);
        arg0.peg_state.btc_backing_sats = arg1;
    }

    public entry fun split_and_transfer(arg0: &mut 0x2::coin::Coin<GRI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<GRI>>(0x2::coin::split<GRI>(arg0, arg1, arg3), arg2);
    }

    public entry fun transfer_admin(arg0: GriAdminCap, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert_multisig_only(&arg0, arg2);
        arg0.peg_state.multisig_admin = arg1;
        0x2::transfer::public_transfer<GriAdminCap>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

