module 0xfd5481d755d82c6a730f4150a95f948b8a10afb5aad00c1072e6a1295c6cf100::dcm {
    struct DCM has drop {
        dummy_field: bool,
    }

    fun init(arg0: DCM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DCM>(arg0, 9, b"DCM", b"Doggy Coin", b"1u soon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/793e4997-d8b2-4865-81ca-b276b259eae9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DCM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DCM>>(v1);
    }

    // decompiled from Move bytecode v6
}

