module 0x8038ae6a73c05ffbbc5e2a50aafdc729a395ccc311f4cba416b17a093d086e06::uni {
    struct UNI has drop {
        dummy_field: bool,
    }

    fun init(arg0: UNI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UNI>(arg0, 9, b"UNI", b"Universal", b"universal meme coin for everyone", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7c648c45-6198-48f6-b665-fa16943b0d55.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UNI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<UNI>>(v1);
    }

    // decompiled from Move bytecode v6
}

