module 0x7c78f8de38c59f37de98658fc16b3468881a9918f5c10f341984aec306f9e114::fncz {
    struct FNCZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: FNCZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FNCZ>(arg0, 9, b"FNCZ", b"KONGz", b"The king came to visit", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a9f23e1d-18d7-46a8-b112-92d455d4ad3d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FNCZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FNCZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

