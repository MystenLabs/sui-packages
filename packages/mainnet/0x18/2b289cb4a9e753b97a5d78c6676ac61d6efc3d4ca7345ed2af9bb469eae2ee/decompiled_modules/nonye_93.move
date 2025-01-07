module 0x182b289cb4a9e753b97a5d78c6676ac61d6efc3d4ca7345ed2af9bb469eae2ee::nonye_93 {
    struct NONYE_93 has drop {
        dummy_field: bool,
    }

    fun init(arg0: NONYE_93, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NONYE_93>(arg0, 9, b"NONYE_93", b"Chyogums ", b"For Good", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b6f7eeda-a88c-48c5-8ee2-3973324c43d2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NONYE_93>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NONYE_93>>(v1);
    }

    // decompiled from Move bytecode v6
}

