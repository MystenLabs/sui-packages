module 0x7aadd0f03867a877378b77ca23bb8e5dc67840031655db6d70ed31cb8c93c823::derv {
    struct DERV has drop {
        dummy_field: bool,
    }

    fun init(arg0: DERV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DERV>(arg0, 6, b"DERV", b"Derv", b"#1 retard on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731013275755.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DERV>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DERV>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

