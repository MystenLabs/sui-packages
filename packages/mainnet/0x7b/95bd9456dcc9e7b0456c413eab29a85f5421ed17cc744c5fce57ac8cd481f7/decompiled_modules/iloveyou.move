module 0x7b95bd9456dcc9e7b0456c413eab29a85f5421ed17cc744c5fce57ac8cd481f7::iloveyou {
    struct ILOVEYOU has drop {
        dummy_field: bool,
    }

    fun init(arg0: ILOVEYOU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ILOVEYOU>(arg0, 9, b"ILOVEYOU", x"e29da4efb88f2049204c4f564520594f55", b"Official token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdn.vectorstock.com/i/preview-1x/96/91/i-love-you-red-paper-inscription-vector-7209691.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ILOVEYOU>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ILOVEYOU>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ILOVEYOU>>(v1);
    }

    // decompiled from Move bytecode v6
}

