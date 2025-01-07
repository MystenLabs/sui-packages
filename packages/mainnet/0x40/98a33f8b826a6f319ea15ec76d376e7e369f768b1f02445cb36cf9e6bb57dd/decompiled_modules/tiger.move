module 0x4098a33f8b826a6f319ea15ec76d376e7e369f768b1f02445cb36cf9e6bb57dd::tiger {
    struct TIGER has drop {
        dummy_field: bool,
    }

    fun init(arg0: TIGER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TIGER>(arg0, 9, b"TIGER", b"We tiger", b"Tiger is the king of animal who stand alone in the jungle", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ff054a3e-6f4b-4f43-8702-eddf23970f27.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TIGER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TIGER>>(v1);
    }

    // decompiled from Move bytecode v6
}

