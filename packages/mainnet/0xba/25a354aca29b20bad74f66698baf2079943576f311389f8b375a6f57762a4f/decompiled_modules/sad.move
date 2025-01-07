module 0xba25a354aca29b20bad74f66698baf2079943576f311389f8b375a6f57762a4f::sad {
    struct SAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAD>(arg0, 6, b"SAD", b"SUIDNESS", x"4a6f696e2024535549444e455353206f6e207468652053554920626c6f636b636861696e20616e6420646973636f766572207468652068696464656e20706f74656e7469616c20696e2074686f7365206d656c616e63686f6c6963206d6f6d656e7473210a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_09_27_00_08_10_33968d5649.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SAD>>(v1);
    }

    // decompiled from Move bytecode v6
}

