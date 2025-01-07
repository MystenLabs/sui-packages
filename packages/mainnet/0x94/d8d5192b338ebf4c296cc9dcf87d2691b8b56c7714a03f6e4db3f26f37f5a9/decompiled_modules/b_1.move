module 0x94d8d5192b338ebf4c296cc9dcf87d2691b8b56c7714a03f6e4db3f26f37f5a9::b_1 {
    struct B_1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_1>(arg0, 9, b"B_1", b"Ark", b"Say Hi the world ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7cce24e7-70c1-4c9b-ac62-849ffee9535c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_1>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<B_1>>(v1);
    }

    // decompiled from Move bytecode v6
}

