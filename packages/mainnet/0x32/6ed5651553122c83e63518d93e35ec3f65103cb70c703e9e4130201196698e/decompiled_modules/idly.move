module 0x326ed5651553122c83e63518d93e35ec3f65103cb70c703e9e4130201196698e::idly {
    struct IDLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: IDLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IDLY>(arg0, 9, b"IDLY", b"IDLY FUND", b"Building an autonomous digital real estate portfolio.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7ed428c8-01a3-4ccc-b6a0-9f5d33b3c7ec.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IDLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<IDLY>>(v1);
    }

    // decompiled from Move bytecode v6
}

