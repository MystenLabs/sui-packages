module 0x48f56caa0f6ba96d07cd5d353a623dcfec8b291f45b971ccc7bef4f2f2688f6c::suiky {
    struct SUIKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIKY>(arg0, 6, b"SUIKY", b"SUIKY QUACK", b"Cute & quacky, i'm Suiky", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/QUACK_9210a972d5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIKY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIKY>>(v1);
    }

    // decompiled from Move bytecode v6
}

