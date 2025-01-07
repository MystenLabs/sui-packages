module 0x9495521e8d1b0f39c640fc0a861c5702df99174f198a2f282e09e53de0ca13fc::gam {
    struct GAM has drop {
        dummy_field: bool,
    }

    fun init(arg0: GAM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GAM>(arg0, 9, b"GAM", b"Gundam", b"Gundamu", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9620715d-7597-406c-9e93-5b8c861be94f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GAM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GAM>>(v1);
    }

    // decompiled from Move bytecode v6
}

