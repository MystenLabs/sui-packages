module 0xc93d4da83ac84eb3165358b3fa062bcfa69999128e58714c00d4c431d469dc0f::shit {
    struct SHIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHIT>(arg0, 9, b"SHIT", b"Shit", x"534849542069732074686520746f6b656e20796f75206469646ee2809974206b6e6f7720796f75206e65656465642e204275696c74206f6e207468652053554920626c6f636b636861696e2c205348495420656d627261636573206974732069726f6e6963206964656e746974792061732074686520776f726c642773206d6f737420756e6e65636573736172792079657420697272657369737469626c652063727970746f63757272656e6379", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c136fe75-f19a-4857-abcd-f9adf255f53d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHIT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHIT>>(v1);
    }

    // decompiled from Move bytecode v6
}

