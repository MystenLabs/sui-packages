module 0xf6f023c735a85ac58ca613d150c58d2016436d77e5ffef459f6fa82705187dfe::trixie {
    struct TRIXIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRIXIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRIXIE>(arg0, 9, b"TRIXIE", b"VOI", b"This a token layer 3 on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d562ae17-33aa-4339-bd98-2b66a25c1d0c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRIXIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRIXIE>>(v1);
    }

    // decompiled from Move bytecode v6
}

