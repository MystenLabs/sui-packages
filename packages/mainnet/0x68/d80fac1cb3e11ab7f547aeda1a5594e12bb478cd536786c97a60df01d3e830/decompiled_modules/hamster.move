module 0x68d80fac1cb3e11ab7f547aeda1a5594e12bb478cd536786c97a60df01d3e830::hamster {
    struct HAMSTER has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAMSTER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HAMSTER>(arg0, 6, b"HAMSTER", b"Hamster On Sui", b"Hamsters eep-eep-eep on Sui!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sfun_Pf1_L_400x400_0baae0da68.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HAMSTER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HAMSTER>>(v1);
    }

    // decompiled from Move bytecode v6
}

