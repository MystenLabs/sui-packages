module 0xbd7c4aece2b2b1484f9fe10c061214c7efbbc11b55dc9d64f74513250e20348b::aflp2 {
    struct AFLP2 has drop {
        dummy_field: bool,
    }

    fun init(arg0: AFLP2, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AFLP2>(arg0, 6, b"AFLP2", b"AFLP v2 test", b"st1 managed AFLP test vault LP (AFX-481)", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aftermath.finance/coins/perpetuals/default.svg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AFLP2>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AFLP2>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

