module 0x8a78819303d53599a31b8fe1516a6bad4f1aa68b630d5890047ab1b6a0f38b57::ldy {
    struct LDY has drop {
        dummy_field: bool,
    }

    fun init(arg0: LDY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LDY>(arg0, 9, b"LDY", b"LADY ORANG", b"LADYS BUTIY", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c5631e86-d8eb-456a-8d77-003e70ad01b9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LDY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LDY>>(v1);
    }

    // decompiled from Move bytecode v6
}

