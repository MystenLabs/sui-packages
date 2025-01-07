module 0x71894fa4db0fc8f508e8a16dc7f6812650153d4d10867ba2314ed07a030c5336::coronas {
    struct CORONAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CORONAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CORONAS>(arg0, 9, b"CORONAS", b"WAWE", b"Sui inspires to go further, develop, catch the waves.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/231e98e0-fc26-4c02-9862-17156abe8b2c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CORONAS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CORONAS>>(v1);
    }

    // decompiled from Move bytecode v6
}

