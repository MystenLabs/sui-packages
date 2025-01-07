module 0xdcd30cd26ff7d74d82922a6160792d7a627c421e655fd572f271b2b95181f562::adfdg {
    struct ADFDG has drop {
        dummy_field: bool,
    }

    fun init(arg0: ADFDG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ADFDG>(arg0, 9, b"ADFDG", b"rgrg", b"dfgdfg", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8ea7a2a5-efb2-4b05-8343-3c5d00cb416a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ADFDG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ADFDG>>(v1);
    }

    // decompiled from Move bytecode v6
}

