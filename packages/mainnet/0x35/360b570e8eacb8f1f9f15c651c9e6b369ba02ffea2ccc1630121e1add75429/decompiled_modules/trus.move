module 0x35360b570e8eacb8f1f9f15c651c9e6b369ba02ffea2ccc1630121e1add75429::trus {
    struct TRUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUS>(arg0, 9, b"TRUS", b"Trump_SUI", b"The first Trump coin on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c442898d-a25e-45ab-a9e7-826bd1e31404.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

