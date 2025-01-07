module 0xd2e367b2cb3f2552aa20d1b2cc43d054d4b77cdae48d0203a82bd8d454948adb::goli {
    struct GOLI has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOLI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOLI>(arg0, 9, b"GOLI", b"Golnaz ", b"Golnaz", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/959a7296-7a21-40c0-8321-e7c6b47e1847.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOLI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GOLI>>(v1);
    }

    // decompiled from Move bytecode v6
}

