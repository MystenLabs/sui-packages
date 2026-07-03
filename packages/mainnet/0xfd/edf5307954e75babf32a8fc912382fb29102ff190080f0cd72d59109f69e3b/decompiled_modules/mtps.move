module 0xfdedf5307954e75babf32a8fc912382fb29102ff190080f0cd72d59109f69e3b::mtps {
    struct MTPS has drop {
        dummy_field: bool,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
        treasury_cap: 0x2::coin::TreasuryCap<MTPS>,
    }

    public fun burn(arg0: &mut AdminCap, arg1: 0x2::coin::Coin<MTPS>) {
        0x2::coin::burn<MTPS>(&mut arg0.treasury_cap, arg1);
    }

    public fun admin_mint(arg0: &mut AdminCap, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 <= 10000000000, 0);
        0x2::coin::mint_and_transfer<MTPS>(&mut arg0.treasury_cap, arg1, arg2, arg3);
    }

    public fun admin_mint_to_balance(arg0: &mut AdminCap, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 <= 10000000000, 0);
        0x2::coin::send_funds<MTPS>(0x2::coin::mint<MTPS>(&mut arg0.treasury_cap, arg1, arg3), arg2);
    }

    fun init(arg0: MTPS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<MTPS>(arg0, 0, 0x1::string::utf8(b"MTPS"), 0x1::string::utf8(b"MTPS"), 0x1::string::utf8(b"Lightning speed games and apps on Sui"), 0x1::string::utf8(b"https://dev.millionstps.io/favicons/favicon.svg"), arg1);
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<MTPS>>(0x2::coin_registry::finalize<MTPS>(v0, arg1), 0x2::tx_context::sender(arg1));
        let v2 = AdminCap{
            id           : 0x2::object::new(arg1),
            treasury_cap : v1,
        };
        0x2::transfer::transfer<AdminCap>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

