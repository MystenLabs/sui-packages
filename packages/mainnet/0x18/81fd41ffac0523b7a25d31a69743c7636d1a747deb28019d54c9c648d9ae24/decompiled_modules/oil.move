module 0x1881fd41ffac0523b7a25d31a69743c7636d1a747deb28019d54c9c648d9ae24::oil {
    struct OIL has drop {
        dummy_field: bool,
    }

    fun init(arg0: OIL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OIL>(arg0, 6, b"Oil", b"Crude oil", b"The crypto for oil lovers. Oil goes up and you win!!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1774468512991.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OIL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OIL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

