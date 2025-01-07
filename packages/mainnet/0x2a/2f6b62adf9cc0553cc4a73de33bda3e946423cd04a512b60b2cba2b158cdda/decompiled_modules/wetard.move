module 0x2a2f6b62adf9cc0553cc4a73de33bda3e946423cd04a512b60b2cba2b158cdda::wetard {
    struct WETARD has drop {
        dummy_field: bool,
    }

    fun init(arg0: WETARD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WETARD>(arg0, 9, b"WETARD", b"ProfWetard", x"4c6574206d6520696e74726f6475636520612050726f66657373696f6e616c205745544152442e20546861742077696c6c2070756d70206869732064756d7020737472616967687420746f20746865204d4f4f4e2e20536f206c65742773206a6f696e20666f7263657320616e642050554d5020746869732064756d70206173206974206973206f6e6c792061206d657265203337382e3030302053554920617761792066726f6d20706c616e65742045617274682e204571756174696f6e2069732073696d706c65205820f09f92af20544f2054484520f09f8c9b20e29bbd207468697320f09f92a9", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c8c6f67f-24ba-4adc-a68d-be8c76f9b66b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WETARD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WETARD>>(v1);
    }

    // decompiled from Move bytecode v6
}

