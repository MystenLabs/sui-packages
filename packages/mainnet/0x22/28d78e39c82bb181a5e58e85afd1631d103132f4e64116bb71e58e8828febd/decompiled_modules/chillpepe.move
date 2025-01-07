module 0x2228d78e39c82bb181a5e58e85afd1631d103132f4e64116bb71e58e8828febd::chillpepe {
    struct CHILLPEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHILLPEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHILLPEPE>(arg0, 6, b"ChillPEPE", b"Just a Chill PEPE", x"0a4a7573742061206368696c6c696e2c204e6f7468696e6720656c73652e204974206665656c7320676f6f642c206d616e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_11_23_18_53_18_ef7d79a177.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHILLPEPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHILLPEPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

