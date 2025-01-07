module 0xaab8c0e558faa370bd737bafc6de303a679dc6841c2d79679a67150662ee6c25::ok {
    struct OK has drop {
        dummy_field: bool,
    }

    fun init(arg0: OK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OK>(arg0, 6, b"Ok", b"Pk", b"Oksks", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_8480_07acf659b1.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OK>>(v1);
    }

    // decompiled from Move bytecode v6
}

