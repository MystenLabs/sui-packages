module 0x7eb699b346f752cf50a348b015fcaafa00224f88b8c2391a7cba1153ccdb91f9::scallop_lofi {
    struct SCALLOP_LOFI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCALLOP_LOFI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCALLOP_LOFI>(arg0, 9, b"sLOFI", b"sLOFI", b"Scallop interest-bearing token for LOFI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ufybsrfhxmvv7za3hoi6or4mxe5skp2de42y5gd3qtaopwu6xwya.arweave.net/oXAZRKe7K1_kGzuR50eMuTslP0MnNY6Ye4TA59qevbA")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SCALLOP_LOFI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCALLOP_LOFI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

