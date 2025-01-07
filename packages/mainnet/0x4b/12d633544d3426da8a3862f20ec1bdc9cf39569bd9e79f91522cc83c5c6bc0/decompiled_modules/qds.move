module 0x4b12d633544d3426da8a3862f20ec1bdc9cf39569bd9e79f91522cc83c5c6bc0::qds {
    struct QDS has drop {
        dummy_field: bool,
    }

    fun init(arg0: QDS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<QDS>(arg0, 9, b"QDS", b"QUADROBICS", b"We dont care about all sorts of dogs, cats, toads and so on. We are the number one MEME token. We don't have any social networks, drops Only to the moon!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/647b4d5d-2375-439d-a84d-f07599b93a73-8F1DF397-8414-4BAF-B30B-D5AB0A4AF850.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<QDS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<QDS>>(v1);
    }

    // decompiled from Move bytecode v6
}

