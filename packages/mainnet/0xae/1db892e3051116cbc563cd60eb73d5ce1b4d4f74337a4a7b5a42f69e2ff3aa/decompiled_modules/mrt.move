module 0xae1db892e3051116cbc563cd60eb73d5ce1b4d4f74337a4a7b5a42f69e2ff3aa::mrt {
    struct MRT has drop {
        dummy_field: bool,
    }

    fun init(arg0: MRT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MRT>(arg0, 9, b"MRT", b"Meerkat", x"4d656574204d6565726b617420436f696e2c2074686520636865656b792c20636f6d6d756e6974792d64726976656e206d656d6520636f696e2074686174e280997320616c77617973206f6e20746865206c6f6f6b6f757420666f7220746865206e65787420626967206d6f6f6e73686f742120", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/cfcbbd3e-9cb8-4e47-a46a-e9c5b57d12ef.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MRT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MRT>>(v1);
    }

    // decompiled from Move bytecode v6
}

