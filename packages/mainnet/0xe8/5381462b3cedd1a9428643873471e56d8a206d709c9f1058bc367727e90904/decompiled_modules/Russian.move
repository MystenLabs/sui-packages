module 0xe85381462b3cedd1a9428643873471e56d8a206d709c9f1058bc367727e90904::Russian {
    struct RUSSIAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: RUSSIAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RUSSIAN>(arg0, 9, b"RUSSIAN", b"Russian", b"with love", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/media/Gz3mTZkW4AAYqPC?format=jpg&name=small")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RUSSIAN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RUSSIAN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

