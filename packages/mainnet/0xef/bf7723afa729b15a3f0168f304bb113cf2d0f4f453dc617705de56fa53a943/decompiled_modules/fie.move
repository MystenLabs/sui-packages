module 0xefbf7723afa729b15a3f0168f304bb113cf2d0f4f453dc617705de56fa53a943::fie {
    struct FIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: FIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FIE>(arg0, 9, b"FIE", b"DDSAD", b"ASDASD", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d487faf4-8882-404b-a1ad-2353c7e731d0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FIE>>(v1);
    }

    // decompiled from Move bytecode v6
}

