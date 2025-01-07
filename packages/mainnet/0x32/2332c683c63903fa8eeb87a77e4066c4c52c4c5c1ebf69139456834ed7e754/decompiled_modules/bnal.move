module 0x322332c683c63903fa8eeb87a77e4066c4c52c4c5c1ebf69139456834ed7e754::bnal {
    struct BNAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: BNAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BNAL>(arg0, 9, b"BNAL", b"Billiznall", b"BNAl on Sui Ecosystem ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ee51cd79-48cf-4465-98e8-7f906edb69ee.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BNAL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BNAL>>(v1);
    }

    // decompiled from Move bytecode v6
}

