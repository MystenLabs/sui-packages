module 0x8780bbf2eedca0b9ea585614025b894525f7887f0831ca6bc4ba8aff39aa75cc::twl {
    struct TWL has drop {
        dummy_field: bool,
    }

    fun init(arg0: TWL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TWL>(arg0, 9, b"TWL", b"CityTowel", b"coin of the city towel", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8c1ba19e-28d4-4c0d-8d69-79e2170925df.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TWL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TWL>>(v1);
    }

    // decompiled from Move bytecode v6
}

