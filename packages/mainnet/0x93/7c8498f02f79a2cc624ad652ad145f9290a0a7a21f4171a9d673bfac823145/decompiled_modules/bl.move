module 0x937c8498f02f79a2cc624ad652ad145f9290a0a7a21f4171a9d673bfac823145::bl {
    struct BL has drop {
        dummy_field: bool,
    }

    fun init(arg0: BL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BL>(arg0, 9, b"BL", b"Bao Long", b"Le Long", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3e90ab87-d758-4c4b-b230-4890eb044a00.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BL>>(v1);
    }

    // decompiled from Move bytecode v6
}

