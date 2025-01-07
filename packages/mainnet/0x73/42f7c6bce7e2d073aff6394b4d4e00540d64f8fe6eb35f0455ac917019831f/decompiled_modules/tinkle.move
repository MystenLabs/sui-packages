module 0x7342f7c6bce7e2d073aff6394b4d4e00540d64f8fe6eb35f0455ac917019831f::tinkle {
    struct TINKLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: TINKLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TINKLE>(arg0, 6, b"Tinkle", b"Tinkle on Sui", b"TNKL - The Sound of Water on Sui. Soon to be #1 Meme on Sui. Have a tinkle", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/aaa_8c9aaca105.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TINKLE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TINKLE>>(v1);
    }

    // decompiled from Move bytecode v6
}

