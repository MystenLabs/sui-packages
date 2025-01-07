module 0xca52c6e3af63aabd3a480b2f1565e33db952d34f5bb3aed3a39ab11968d025f5::sea {
    struct SEA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SEA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SEA>(arg0, 9, b"SEA", b"sea", x"4469766520696e746f207765616c7468207769746820536561436f696e3a20546865206f6365616e69632063727970746f63757272656e637920746861742773206d616b696e6720776176657320696e20746865206d61726b65742c2064656c69766572696e6720746964616c2070726f6669747320616e6420612074726561737572652074726f7665206f66206f70706f7274756e69746965732062656e656174682074686520737572666163652120f09f8c8a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/97a19936-b617-418d-99da-b8f551a807e0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SEA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SEA>>(v1);
    }

    // decompiled from Move bytecode v6
}

