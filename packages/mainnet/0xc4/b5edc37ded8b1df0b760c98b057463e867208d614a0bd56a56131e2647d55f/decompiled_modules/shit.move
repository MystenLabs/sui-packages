module 0xc4b5edc37ded8b1df0b760c98b057463e867208d614a0bd56a56131e2647d55f::shit {
    struct SHIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHIT>(arg0, 9, b"SHIT", b"Shit Wave", b"Wave of shit. Ride it to the top.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1ecaa6ac-d9e4-4069-9969-4f9e9d22ab04.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHIT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHIT>>(v1);
    }

    // decompiled from Move bytecode v6
}

