module 0x62d96c7c278bf47a4bcad52ac33ca8b4580519c1e456bd631dc5fed6724edf8::dsea {
    struct DSEA has drop {
        dummy_field: bool,
    }

    fun init(arg0: DSEA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DSEA>(arg0, 6, b"DSEA", b"Ducky on the SEA", b"Welcome to my boaat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_07_24_23_26_27_a433ca4ef0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DSEA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DSEA>>(v1);
    }

    // decompiled from Move bytecode v6
}

