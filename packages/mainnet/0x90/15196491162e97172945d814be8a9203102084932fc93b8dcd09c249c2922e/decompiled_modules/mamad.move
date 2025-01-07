module 0x9015196491162e97172945d814be8a9203102084932fc93b8dcd09c249c2922e::mamad {
    struct MAMAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAMAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAMAD>(arg0, 9, b"MAMAD", b"Mohmmadbig", b"Batman is here", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e41c2900-dd91-4fb2-b3b7-44a8490abe7b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAMAD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MAMAD>>(v1);
    }

    // decompiled from Move bytecode v6
}

