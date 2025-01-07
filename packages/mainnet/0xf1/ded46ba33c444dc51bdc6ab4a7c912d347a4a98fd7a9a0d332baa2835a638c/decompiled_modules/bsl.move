module 0xf1ded46ba33c444dc51bdc6ab4a7c912d347a4a98fd7a9a0d332baa2835a638c::bsl {
    struct BSL has drop {
        dummy_field: bool,
    }

    fun init(arg0: BSL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BSL>(arg0, 9, b"BSL", x"42c3b9692053656120", x"42c3b969207175e1baa76e202078e1bb8b70", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/085f4b42-9ff6-4a24-800d-4ea1c0e1e710.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BSL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BSL>>(v1);
    }

    // decompiled from Move bytecode v6
}

