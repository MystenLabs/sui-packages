module 0x6645e32ea8033c697f4642cda6755e72ec761fbaa936ad0bc16e258ff17dee7b::navanh {
    struct NAVANH has drop {
        dummy_field: bool,
    }

    fun init(arg0: NAVANH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NAVANH>(arg0, 9, b"NAVANH", b"DAN", b"My baby", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9bce35c3-8f6a-4b5b-a6ba-86f08f245856.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NAVANH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NAVANH>>(v1);
    }

    // decompiled from Move bytecode v6
}

