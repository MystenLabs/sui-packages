module 0x169d662e2a70cafd68c5026a701c5d55db268adb7ca633f9ef700fc7c9ea1d82::god {
    struct GOD has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOD>(arg0, 9, b"GOD", b"CATGOD", x"e2809c5768656e20796f75207072617920666f72207765616c74682c20616e64207468652043617420476f64206f66204d6f6e657920626c657373657320796f75207769746820656e646c6573732074726561747320616e64207472656173757265732ee2809d", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7d0d68be-7917-45b0-832b-a7b858799ce7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GOD>>(v1);
    }

    // decompiled from Move bytecode v6
}

