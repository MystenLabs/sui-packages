module 0x3841e5d6e7274e8c0643853097d013f0320143eaff8c2642dc065b4391441e1c::ppf {
    struct PPF has drop {
        dummy_field: bool,
    }

    fun init(arg0: PPF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PPF>(arg0, 6, b"PPF", b"PaperFwag", b"Hello, im PaperFwag. Welcome to my paper world", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_8755_e4ed239887.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PPF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PPF>>(v1);
    }

    // decompiled from Move bytecode v6
}

