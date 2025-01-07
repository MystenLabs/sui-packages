module 0x7661ea875f3110ece3f195077ea6f3ccd9aa15c3f7fde0a5844c8239b83520da::haha {
    struct HAHA has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAHA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HAHA>(arg0, 9, b"HAHA", b"HA HA ", b"H", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d662ca37-d8f9-47fe-96ae-ca7aeffb3c46.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HAHA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HAHA>>(v1);
    }

    // decompiled from Move bytecode v6
}

