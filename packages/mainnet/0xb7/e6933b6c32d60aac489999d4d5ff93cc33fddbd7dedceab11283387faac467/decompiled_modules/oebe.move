module 0xb7e6933b6c32d60aac489999d4d5ff93cc33fddbd7dedceab11283387faac467::oebe {
    struct OEBE has drop {
        dummy_field: bool,
    }

    fun init(arg0: OEBE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OEBE>(arg0, 9, b"OEBE", b"hdbd", b"jdnd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/110ec374-cf4b-42ca-a429-f7a9422cdfe0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OEBE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OEBE>>(v1);
    }

    // decompiled from Move bytecode v6
}

