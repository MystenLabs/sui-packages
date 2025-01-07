module 0xf82e27f4d8ae26ceeedc6626389b7c359d5a17a52bf5955f26287378f920b1e4::suidoshi {
    struct SUIDOSHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIDOSHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIDOSHI>(arg0, 6, b"SUIDOSHI", b"DOSHI ON SUI", x"444f5348492069732061206d656d65636f696e206f6e2074686520537569206e6574776f726b207468617420636f6d62696e6573207468652068756d6f726f757320656c656d656e7473206f6620446f6765636f696e20616e6420536869626120496e752e2057697468206120666f637573206f6e20636f6d6d756e6974792c20444f534849206f6666657273207374616b696e672c204e4654732c20616e642066756e206576656e747320746f20656e68616e636520656e676167656d656e7420616e642070726f766964652061646465642076616c756520666f722069747320686f6c646572732e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3542_6e53ed3943.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIDOSHI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIDOSHI>>(v1);
    }

    // decompiled from Move bytecode v6
}

