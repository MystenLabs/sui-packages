module 0xec190cc1815823e0955ffd1d43ed42cc46c577ed4788e33a99806a08ff49099e::db {
    struct DB has drop {
        dummy_field: bool,
    }

    fun init(arg0: DB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DB>(arg0, 9, b"DB", b"Don't Buy ", b"If you buy, i Will donate ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/12abb0a1-10b9-4f54-bce1-9762abc5f297.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DB>>(v1);
    }

    // decompiled from Move bytecode v6
}

