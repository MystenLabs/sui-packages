module 0x8a5551639ce2e03ac2beb5c3cf60ee965c6f86eacd44f4b5ea30c49fd52f140e::Minnions {
    struct MINNIONS has drop {
        dummy_field: bool,
    }

    fun init(arg0: MINNIONS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MINNIONS>(arg0, 9, b"MNZ", b"Minnions", b"Yellow chaos. Banana energy. Pure MNOON", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://patara.app/images/meme-coin-icon.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MINNIONS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MINNIONS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

