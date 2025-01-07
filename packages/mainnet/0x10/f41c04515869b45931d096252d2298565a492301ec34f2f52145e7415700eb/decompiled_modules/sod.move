module 0x10f41c04515869b45931d096252d2298565a492301ec34f2f52145e7415700eb::sod {
    struct SOD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOD>(arg0, 6, b"SOD", b"Son of Doge", b"No socials. Just the son of Doge.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sod_f37fe56d74.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SOD>>(v1);
    }

    // decompiled from Move bytecode v6
}

