module 0x4f27dc58a00a416917186f65919d135827367442d62793b06539cf5b30e8b211::biga {
    struct BIGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BIGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BIGA>(arg0, 9, b"BIGA", b"Bigbang", b"bin bang", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdnb.artstation.com/p/assets/images/images/017/787/279/medium/annika-soljander-icons1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BIGA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BIGA>>(v1);
    }

    // decompiled from Move bytecode v7
}

