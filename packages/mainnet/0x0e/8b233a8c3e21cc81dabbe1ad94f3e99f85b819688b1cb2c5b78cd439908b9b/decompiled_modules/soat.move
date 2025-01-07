module 0xe8b233a8c3e21cc81dabbe1ad94f3e99f85b819688b1cb2c5b78cd439908b9b::soat {
    struct SOAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOAT>(arg0, 6, b"SOAT", b"STRONGEST OF ALL TIME", x"5374726f6e6765737420746f6b656e206f6e207375692021200a0a54616b6520612062616720616e64206265207374726f6e672e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Design_sans_titre_2024_10_11_T201928_613_154d984291.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SOAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

