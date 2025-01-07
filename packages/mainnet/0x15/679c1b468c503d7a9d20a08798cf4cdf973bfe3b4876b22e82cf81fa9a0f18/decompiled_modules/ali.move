module 0x15679c1b468c503d7a9d20a08798cf4cdf973bfe3b4876b22e82cf81fa9a0f18::ali {
    struct ALI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ALI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ALI>(arg0, 9, b"ALI", b"Snow", b"King cats", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/76a953ed-b7c6-458d-a5af-8aa531017df8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ALI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ALI>>(v1);
    }

    // decompiled from Move bytecode v6
}

