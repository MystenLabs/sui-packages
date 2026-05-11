module 0x839da07271a40dcac01c91ded1caed550395afbc4456378ac34cb511ac5f232d::token {
    struct TOKEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOKEN>(arg0, 9, b"test", b"test", b"test", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dgn.fun")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TOKEN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOKEN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

