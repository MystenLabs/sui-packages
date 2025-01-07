module 0x9d65de40c86b316e2b99b0cb07fac243d368fa131ab506cf1f5c1a10a19d6554::sb_usdt {
    struct SB_USDT has drop {
        dummy_field: bool,
    }

    struct SbUsdtTreasury has key {
        id: 0x2::object::UID,
        treasury_cap: 0x2::coin::TreasuryCap<SB_USDT>,
        msg_author: 0x1::option::Option<address>,
        mint_record: 0x2::table::Table<address, u64>,
        mint_enabled: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    public fun disable_minting(arg0: &AdminCap, arg1: &mut SbUsdtTreasury) {
        arg1.mint_enabled = false;
    }

    public fun enable_minting(arg0: &AdminCap, arg1: &mut SbUsdtTreasury) {
        arg1.mint_enabled = true;
    }

    fun init(arg0: SB_USDT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SB_USDT>(arg0, 9, b"sbUSDT", b"Sui Beta USDT", b"Sui beta token for USDT.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://vrr7y7aent4hea3r444jrrsvgvgwsz6zi2r2vv2odhgfrgvvs6iq.arweave.net/rGP8fARs-HIDcec4mMZVNU1pZ9lGo6rXThnMWJq1l5E")), arg1);
        let v2 = SbUsdtTreasury{
            id           : 0x2::object::new(arg1),
            treasury_cap : v0,
            msg_author   : 0x1::option::none<address>(),
            mint_record  : 0x2::table::new<address, u64>(arg1),
            mint_enabled : true,
        };
        let v3 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::share_object<SbUsdtTreasury>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SB_USDT>>(v1);
        0x2::transfer::transfer<AdminCap>(v3, 0x2::tx_context::sender(arg1));
    }

    public fun mint_from_admin(arg0: &AdminCap, arg1: &mut SbUsdtTreasury, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<SB_USDT> {
        0x2::coin::mint<SB_USDT>(&mut arg1.treasury_cap, arg2, arg3)
    }

    public fun mint_with_signature(arg0: &mut SbUsdtTreasury, arg1: vector<u8>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<SB_USDT> {
        assert!(arg0.mint_enabled, 106);
        assert!(0x1::option::is_some<address>(&arg0.msg_author), 103);
        let v0 = 0x2::bcs::to_bytes<address>(0x1::option::borrow<address>(&arg0.msg_author));
        assert!(0x2::ed25519::ed25519_verify(&arg1, &v0, &arg2), 101);
        let v1 = 0x2::bcs::new(arg2);
        let v2 = 0x2::bcs::peel_u64(&mut v1);
        let v3 = 0x2::tx_context::sender(arg3);
        assert!(0x2::bcs::peel_address(&mut v1) == v3, 104);
        assert!(0x2::table::contains<address, u64>(&arg0.mint_record, v3) == false, 105);
        0x2::table::add<address, u64>(&mut arg0.mint_record, v3, v2);
        0x2::coin::mint<SB_USDT>(&mut arg0.treasury_cap, v2, arg3)
    }

    public fun set_admin_pubkey(arg0: &AdminCap, arg1: &mut SbUsdtTreasury, arg2: address) {
        0x1::option::fill<address>(&mut arg1.msg_author, arg2);
    }

    // decompiled from Move bytecode v6
}

