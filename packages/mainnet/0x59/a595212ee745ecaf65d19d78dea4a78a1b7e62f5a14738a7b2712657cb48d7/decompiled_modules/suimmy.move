module 0x59a595212ee745ecaf65d19d78dea4a78a1b7e62f5a14738a7b2712657cb48d7::suimmy {
    struct SUIMMY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMMY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMMY>(arg0, 6, b"SUIMMY", b"Suimmy", b"Suimmy dive deep into the sui, where every swim unveils a new heights!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/instant_26_7402c1f06e.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMMY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIMMY>>(v1);
    }

    // decompiled from Move bytecode v6
}

