module 0xd0ff7240d8df13eab5b3a8852b1ee34f4d081790f79b23c79ed6d2ab78a287f6::sln {
    struct SLN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLN>(arg0, 9, b"SLN", b"Smart lion", x"f09f9191", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/386c5947-5138-4d32-a81c-b4ac41e30f01.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SLN>>(v1);
    }

    // decompiled from Move bytecode v6
}

