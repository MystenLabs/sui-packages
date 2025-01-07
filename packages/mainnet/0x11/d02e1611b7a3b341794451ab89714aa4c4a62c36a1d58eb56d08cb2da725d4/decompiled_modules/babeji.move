module 0x11d02e1611b7a3b341794451ab89714aa4c4a62c36a1d58eb56d08cb2da725d4::babeji {
    struct BABEJI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABEJI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABEJI>(arg0, 9, b"BABEJI", b"Babe", b"Crypto ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/cd4b5209-8c61-4679-844b-abd0313ffd2d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABEJI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BABEJI>>(v1);
    }

    // decompiled from Move bytecode v6
}

