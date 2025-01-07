module 0xdb7754262a684c6ada712f1fe302f7b830243a112fed8a8ce951e81c6fa1cbd8::sumi {
    struct SUMI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUMI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUMI>(arg0, 6, b"SUMI", b"SUIMURAI", x"4e4f2044455620414c4c4f434154494f4e532031303025204641495220444953545249425554494f4e200a0a5375696d7572616920285469636b65723a2053554d49290a0a5375696d75726169202853554d49292069732061206d656d6520636f696e206f6e207468652053756920626c6f636b636861696e2c206272696e67696e672074686520666561726c65737320737069726974206f66207468652053616d7572616920746f2074686520776f726c64206f662063727970746f206d656d657321205375696d7572616920646f65736ee28099742070726f6d697365206d6f6f6e206c616e64696e677320", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730958315465.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUMI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUMI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

