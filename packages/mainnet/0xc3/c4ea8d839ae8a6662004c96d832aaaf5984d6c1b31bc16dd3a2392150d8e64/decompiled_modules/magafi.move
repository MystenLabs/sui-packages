module 0xc3c4ea8d839ae8a6662004c96d832aaaf5984d6c1b31bc16dd3a2392150d8e64::magafi {
    struct MAGAFI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAGAFI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAGAFI>(arg0, 6, b"MAGAFI", b"MAGAfin", b"Vote TRUMP or MAGAfin will judge you.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/MAGAFIN_c3eb7b03e0.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAGAFI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MAGAFI>>(v1);
    }

    // decompiled from Move bytecode v6
}

