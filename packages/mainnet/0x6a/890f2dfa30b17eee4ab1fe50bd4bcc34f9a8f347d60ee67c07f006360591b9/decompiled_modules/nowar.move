module 0x6a890f2dfa30b17eee4ab1fe50bd4bcc34f9a8f347d60ee67c07f006360591b9::nowar {
    struct NOWAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOWAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOWAR>(arg0, 6, b"Nowar", b"Gaza25", b"A world full of pain, full of cruelty even for children... without water. without food.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1753789051915.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NOWAR>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOWAR>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

