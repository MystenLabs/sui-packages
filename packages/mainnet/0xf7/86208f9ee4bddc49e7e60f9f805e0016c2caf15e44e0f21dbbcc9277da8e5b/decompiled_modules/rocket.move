module 0xf786208f9ee4bddc49e7e60f9f805e0016c2caf15e44e0f21dbbcc9277da8e5b::rocket {
    struct ROCKET has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROCKET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROCKET>(arg0, 9, b"ROCKET", b"Rocket", b"Moon Rocket", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c9f8b562-86f3-4fed-bc84-537cb4d6c5f6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROCKET>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ROCKET>>(v1);
    }

    // decompiled from Move bytecode v6
}

