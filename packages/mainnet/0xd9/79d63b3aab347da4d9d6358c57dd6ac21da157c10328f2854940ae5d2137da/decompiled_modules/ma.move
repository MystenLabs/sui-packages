module 0xd979d63b3aab347da4d9d6358c57dd6ac21da157c10328f2854940ae5d2137da::ma {
    struct MA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MA>(arg0, 9, b"MA", b"MederAjij", b"meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7b0fc767-143d-4f70-ada8-2b2a15771c7c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MA>>(v1);
    }

    // decompiled from Move bytecode v6
}

