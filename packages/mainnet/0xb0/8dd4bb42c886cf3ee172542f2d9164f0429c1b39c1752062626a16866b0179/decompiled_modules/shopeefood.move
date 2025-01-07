module 0xb08dd4bb42c886cf3ee172542f2d9164f0429c1b39c1752062626a16866b0179::shopeefood {
    struct SHOPEEFOOD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHOPEEFOOD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHOPEEFOOD>(arg0, 9, b"SHOPEEFOOD", b"Wldn24", b"Send foods into customer", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/22699aa3-ce8d-4b37-853c-141008e624bc.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHOPEEFOOD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHOPEEFOOD>>(v1);
    }

    // decompiled from Move bytecode v6
}

