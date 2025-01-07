module 0x70f61797221ac3eecc3cfeafb59905ce9e5373615b25351a28ed10bb7fdffa9c::windut {
    struct WINDUT has drop {
        dummy_field: bool,
    }

    fun init(arg0: WINDUT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WINDUT>(arg0, 9, b"WINDUT", b"Windah", b"Windah Basudara", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d9a6e04c-ec4f-48e2-9afb-ffb044c83b0c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WINDUT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WINDUT>>(v1);
    }

    // decompiled from Move bytecode v6
}

