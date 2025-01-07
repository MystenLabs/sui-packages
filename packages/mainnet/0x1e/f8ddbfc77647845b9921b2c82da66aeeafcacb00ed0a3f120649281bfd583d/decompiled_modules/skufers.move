module 0x1ef8ddbfc77647845b9921b2c82da66aeeafcacb00ed0a3f120649281bfd583d::skufers {
    struct SKUFERS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SKUFERS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SKUFERS>(arg0, 6, b"SKUFERS", b"SUI SKUFERS", x"536b75667320617265206f6363757079696e6720746865204d656d656c616e6469612065636f73797374656d206f6e2053554921200a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/GSKN_Zg_WQAA_7wvz_4f309c178d.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SKUFERS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SKUFERS>>(v1);
    }

    // decompiled from Move bytecode v6
}

