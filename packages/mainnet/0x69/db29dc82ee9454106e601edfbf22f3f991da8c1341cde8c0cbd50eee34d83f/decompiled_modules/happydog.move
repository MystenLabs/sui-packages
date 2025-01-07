module 0x69db29dc82ee9454106e601edfbf22f3f991da8c1341cde8c0cbd50eee34d83f::happydog {
    struct HAPPYDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAPPYDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HAPPYDOG>(arg0, 6, b"HAPPYDOG", b"Happy Dog", b"The happiest dog ever is now on sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/happydog_logos_653e30e54b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HAPPYDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HAPPYDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

