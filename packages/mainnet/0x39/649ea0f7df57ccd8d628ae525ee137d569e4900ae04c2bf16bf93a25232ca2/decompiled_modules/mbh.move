module 0x39649ea0f7df57ccd8d628ae525ee137d569e4900ae04c2bf16bf93a25232ca2::mbh {
    struct MBH has drop {
        dummy_field: bool,
    }

    fun init(arg0: MBH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MBH>(arg0, 9, b"MBH", b"Mbash", b"Mbash token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8eb467c7-b909-4493-991a-7e5a57cad5c9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MBH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MBH>>(v1);
    }

    // decompiled from Move bytecode v6
}

