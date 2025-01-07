module 0x5f3ef2984c81419b942a8ce84c9124b96e84f58dfa7fd8c04bf15c84819856af::a09 {
    struct A09 has drop {
        dummy_field: bool,
    }

    fun init(arg0: A09, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<A09>(arg0, 9, b"A09", b"Sumbal Asg", b"This is good coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e6b94675-cde6-465c-b6a9-d190013fe684.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<A09>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<A09>>(v1);
    }

    // decompiled from Move bytecode v6
}

