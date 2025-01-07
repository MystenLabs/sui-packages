module 0x5719f27d52c509da5a298fda6e7ffda1df9693eef0e05beed1e9bf700bbd9037::slimez {
    struct SLIMEZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLIMEZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLIMEZ>(arg0, 9, b"SLIMEZ", b"SLIME", b"SMILLE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/518db54f-61a2-405e-be40-4514e5118f4a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLIMEZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SLIMEZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

