module 0xa9c9a3b772af2b0b701fbc559201192c0a4ec4528987df35dac794a84a698110::safe {
    struct SAFE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAFE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAFE>(arg0, 9, b"SAFE", b"Safe", b"Safe and sound", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9f08a13c-0b87-42ba-beec-091476be0e76.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAFE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SAFE>>(v1);
    }

    // decompiled from Move bytecode v6
}

