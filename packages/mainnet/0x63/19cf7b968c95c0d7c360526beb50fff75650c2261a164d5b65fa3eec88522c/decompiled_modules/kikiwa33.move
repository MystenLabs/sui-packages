module 0x6319cf7b968c95c0d7c360526beb50fff75650c2261a164d5b65fa3eec88522c::kikiwa33 {
    struct KIKIWA33 has drop {
        dummy_field: bool,
    }

    fun init(arg0: KIKIWA33, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KIKIWA33>(arg0, 9, b"KIKIWA33", b"kikiwa", x"63686f206b696b697761206cc3a02063686f206dc3aa656d65", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/40b60f83-5a3d-4140-a993-9e475904b001.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KIKIWA33>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KIKIWA33>>(v1);
    }

    // decompiled from Move bytecode v6
}

