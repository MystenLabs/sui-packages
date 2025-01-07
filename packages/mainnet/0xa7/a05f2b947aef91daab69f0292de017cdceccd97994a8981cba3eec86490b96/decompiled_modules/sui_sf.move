module 0xa7a05f2b947aef91daab69f0292de017cdceccd97994a8981cba3eec86490b96::sui_sf {
    struct SUI_SF has drop {
        dummy_field: bool,
    }

    struct BridgeData has store, key {
        id: 0x2::object::UID,
        tokens_escrow: 0x2::table_vec::TableVec<0x442b388c0c755e97ea001df0aa0d1f12e13d97c07e4d575c2cb3fac3a058693b::bluemove_launchpad::SUIS>,
        fee_rate: u64,
        treasury_cap: 0x2::coin::TreasuryCap<SUI_SF>,
    }

    struct BridgeTokenToCoinEvent has copy, drop {
        from_tokens: vector<0x2::object::ID>,
        to_amount: u64,
        recipent: address,
    }

    struct BridgeCoinToTokenEvent has copy, drop {
        from_amount: u64,
        to_tokens: vector<0x2::object::ID>,
        recipent: address,
    }

    public entry fun bridge_coins_to_token(arg0: &mut BridgeData, arg1: 0x2::coin::Coin<SUI_SF>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = 1000 * 0x2::math::pow(10, 9);
        let v2 = 0x2::coin::value<SUI_SF>(&arg1);
        assert!(v2 >= v1, 1);
        let v3 = v2 / v1;
        let v4 = v3 * v1;
        if (0x2::coin::value<SUI_SF>(&arg1) != 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<SUI_SF>>(arg1, v0);
        } else {
            0x2::coin::destroy_zero<SUI_SF>(arg1);
        };
        0x2::coin::burn<SUI_SF>(&mut arg0.treasury_cap, 0x2::coin::split<SUI_SF>(&mut arg1, v4, arg2));
        let v5 = 0;
        let v6 = 0x1::vector::empty<0x2::object::ID>();
        while (v5 < v3) {
            let v7 = 0x2::table_vec::pop_back<0x442b388c0c755e97ea001df0aa0d1f12e13d97c07e4d575c2cb3fac3a058693b::bluemove_launchpad::SUIS>(&mut arg0.tokens_escrow);
            0x1::vector::push_back<0x2::object::ID>(&mut v6, 0x2::object::id<0x442b388c0c755e97ea001df0aa0d1f12e13d97c07e4d575c2cb3fac3a058693b::bluemove_launchpad::SUIS>(&v7));
            0x2::transfer::public_transfer<0x442b388c0c755e97ea001df0aa0d1f12e13d97c07e4d575c2cb3fac3a058693b::bluemove_launchpad::SUIS>(v7, v0);
            v5 = v5 + 1;
        };
        let v8 = BridgeCoinToTokenEvent{
            from_amount : v4,
            to_tokens   : v6,
            recipent    : v0,
        };
        0x2::event::emit<BridgeCoinToTokenEvent>(v8);
    }

    public entry fun bridge_tokens_to_coin(arg0: &mut BridgeData, arg1: vector<0x442b388c0c755e97ea001df0aa0d1f12e13d97c07e4d575c2cb3fac3a058693b::bluemove_launchpad::SUIS>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = 0x1::vector::length<0x442b388c0c755e97ea001df0aa0d1f12e13d97c07e4d575c2cb3fac3a058693b::bluemove_launchpad::SUIS>(&arg1);
        let v2 = 0;
        let v3 = 0x1::vector::empty<0x2::object::ID>();
        while (v2 < v1) {
            let v4 = 0x1::vector::pop_back<0x442b388c0c755e97ea001df0aa0d1f12e13d97c07e4d575c2cb3fac3a058693b::bluemove_launchpad::SUIS>(&mut arg1);
            0x1::vector::push_back<0x2::object::ID>(&mut v3, 0x2::object::id<0x442b388c0c755e97ea001df0aa0d1f12e13d97c07e4d575c2cb3fac3a058693b::bluemove_launchpad::SUIS>(&v4));
            0x2::table_vec::push_back<0x442b388c0c755e97ea001df0aa0d1f12e13d97c07e4d575c2cb3fac3a058693b::bluemove_launchpad::SUIS>(&mut arg0.tokens_escrow, v4);
            v2 = v2 + 1;
        };
        let v5 = if (v0 == @0x47558e307257aaa27510eda258e582e22b596fc0d1db08ed5923b3e807616a32 || v0 == @0x49cc391ab4d3503e03dbb24c4f9e28f3cdd2ddf8a459e0d43012c3868ffefa1) {
            0
        } else {
            arg0.fee_rate
        };
        let v6 = v1 * 1000 * 0x2::math::pow(10, 9);
        let v7 = v6 * v5 / 10000;
        0x2::transfer::public_transfer<0x2::coin::Coin<SUI_SF>>(0x2::coin::mint<SUI_SF>(&mut arg0.treasury_cap, v6 - v7, arg2), v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<SUI_SF>>(0x2::coin::mint<SUI_SF>(&mut arg0.treasury_cap, v7, arg2), @0x44);
        0x1::vector::destroy_empty<0x442b388c0c755e97ea001df0aa0d1f12e13d97c07e4d575c2cb3fac3a058693b::bluemove_launchpad::SUIS>(arg1);
        let v8 = BridgeTokenToCoinEvent{
            from_tokens : v3,
            to_amount   : v6,
            recipent    : v0,
        };
        0x2::event::emit<BridgeTokenToCoinEvent>(v8);
    }

    public fun get_tokens_escrow(arg0: &BridgeData) : u64 {
        0x2::table_vec::length<0x442b388c0c755e97ea001df0aa0d1f12e13d97c07e4d575c2cb3fac3a058693b::bluemove_launchpad::SUIS>(&arg0.tokens_escrow)
    }

    fun init(arg0: SUI_SF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUI_SF>(arg0, 9, b"SUISF", b"suisF", b"suisF coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.bluemove.net/uploads2/suis/logo.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUI_SF>>(v1);
        let v2 = BridgeData{
            id            : 0x2::object::new(arg1),
            tokens_escrow : 0x2::table_vec::empty<0x442b388c0c755e97ea001df0aa0d1f12e13d97c07e4d575c2cb3fac3a058693b::bluemove_launchpad::SUIS>(arg1),
            fee_rate      : 30,
            treasury_cap  : v0,
        };
        0x2::transfer::public_share_object<BridgeData>(v2);
    }

    public entry fun set_fee_rate(arg0: &mut BridgeData, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == @0x49cc391ab4d3503e03dbb24c4f9e28f3cdd2ddf8a459e0d43012c3868ffefa1, 2);
        arg0.fee_rate = arg1;
    }

    // decompiled from Move bytecode v6
}

