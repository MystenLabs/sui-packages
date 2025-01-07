module 0x4854b73fb174a73af016c923ca2f656968f138b09bc46bd0bcb38745c2da301a::hojg {
    struct HOJG has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOJG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOJG>(arg0, 9, b"HOJG", b"Hohi", b"Memecoin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/49fe0bcb-444a-490e-afbe-d993fe1d7268.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOJG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HOJG>>(v1);
    }

    // decompiled from Move bytecode v6
}

