module 0x6391d13f32951ed35750d59f703fbdaea53f0deb343feb3c50b59741b40495e9::bark {
    struct BARK has drop {
        dummy_field: bool,
    }

    fun init(arg0: BARK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BARK>(arg0, 6, b"Bark", b"bark", b"bark bark", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/111_a4c455d5c1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BARK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BARK>>(v1);
    }

    // decompiled from Move bytecode v6
}

