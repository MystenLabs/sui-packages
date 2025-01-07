module 0x8dd5d237092f91ed3a177f190f13281273e0c92517046e0a5692ce2a4b61a76e::cir {
    struct CIR has drop {
        dummy_field: bool,
    }

    fun init(arg0: CIR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CIR>(arg0, 9, b"CIR", b"carpet", b"Old and authentic", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4d1ae443-4342-42f0-82a4-d9478945f9b7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CIR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CIR>>(v1);
    }

    // decompiled from Move bytecode v6
}

