module 0xaae5ac59f8c5212e83ed31e4cfc58fb5417c3b9232cbdd026f5d899e5c818518::fafu {
    struct FAFU has drop {
        dummy_field: bool,
    }

    fun init(arg0: FAFU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FAFU>(arg0, 9, b"FAFU", b"Fafafufu", b"www.fafu", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/61e36b10-fe5e-4c03-b02e-eb2087a10c74.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FAFU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FAFU>>(v1);
    }

    // decompiled from Move bytecode v6
}

