module 0x7c235fa46af6b2808e9034e627da5e02e344d5fb16ed69916f5b7b954fddf5a9::jmbt {
    struct JMBT has drop {
        dummy_field: bool,
    }

    fun init(arg0: JMBT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JMBT>(arg0, 9, b"JMBT", b"JEMBUT", b"JEMBUT TOKEN IS NGGRIWUK", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/96619de3-2575-4dba-a953-aed611fd45a3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JMBT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JMBT>>(v1);
    }

    // decompiled from Move bytecode v6
}

