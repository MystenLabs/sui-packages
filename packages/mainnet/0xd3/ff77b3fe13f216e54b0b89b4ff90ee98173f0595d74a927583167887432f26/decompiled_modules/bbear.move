module 0xd3ff77b3fe13f216e54b0b89b4ff90ee98173f0595d74a927583167887432f26::bbear {
    struct BBEAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: BBEAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BBEAR>(arg0, 9, b"BBEAR", b"blue bear", b"blue bear token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/32f188a7-e81d-43ec-a285-51ea1dc9323c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BBEAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BBEAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

