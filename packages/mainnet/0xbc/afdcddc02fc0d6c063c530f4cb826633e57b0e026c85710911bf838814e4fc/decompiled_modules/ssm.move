module 0xbcafdcddc02fc0d6c063c530f4cb826633e57b0e026c85710911bf838814e4fc::ssm {
    struct SSM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SSM>(arg0, 6, b"SSM", b"Sui Sacabam", x"5361636162616d206973204f47206d656d6520234275696c644f6e5375690a24534342206973206e6174697665206d656d65636f696e206f6e20235375696e6574776f726b2024535549", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sacaba_146adb316d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SSM>>(v1);
    }

    // decompiled from Move bytecode v6
}

