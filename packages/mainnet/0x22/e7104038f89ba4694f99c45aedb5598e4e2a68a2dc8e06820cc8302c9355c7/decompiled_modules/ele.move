module 0x22e7104038f89ba4694f99c45aedb5598e4e2a68a2dc8e06820cc8302c9355c7::ele {
    struct ELE has drop {
        dummy_field: bool,
    }

    fun init(arg0: ELE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ELE>(arg0, 9, b"ELE", b"Elephant", x"5374616d7065646520696e746f2073756363657373207769746820456c657068616e74436f696e3a20546865206d69676874792063727970746f63757272656e637920746861742773206173207374726f6e6720617320616e20656c657068616e742c2064656c69766572696e67207472756e6b2d6c6f616473206f662070726f6669747320616e64206d617373697665206f70706f7274756e697469657320696e207468652063727970746f20736176616e6e616820f09f9098", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/130bed77-11e0-4ca4-a074-d8f7b8f8281d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ELE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ELE>>(v1);
    }

    // decompiled from Move bytecode v6
}

