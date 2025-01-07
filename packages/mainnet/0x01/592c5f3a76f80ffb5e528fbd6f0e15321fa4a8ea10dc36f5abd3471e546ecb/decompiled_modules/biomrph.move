module 0x1592c5f3a76f80ffb5e528fbd6f0e15321fa4a8ea10dc36f5abd3471e546ecb::biomrph {
    struct BIOMRPH has drop {
        dummy_field: bool,
    }

    fun init(arg0: BIOMRPH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BIOMRPH>(arg0, 6, b"BIOMRPH", b"The Cult Of Order", b"Hidden in the curves of a shell lies infinite wisdom. Encoded in the branches of a tree lies perfect code. Welcome to The Biomorphic Order.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/45452345_f11a0c81f5.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BIOMRPH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BIOMRPH>>(v1);
    }

    // decompiled from Move bytecode v6
}

