module 0x66ff4b8c9a6c09e50778756c59c8c547b6d9bc954a7b97386ddab3c8f6f4dbb6::bloop {
    struct BLOOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLOOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLOOP>(arg0, 6, b"BLOOP", b"BELUGA BLOOP", x"426c6f6f7020656d65726765732061732061202273757065722d42454c554741207768616c652c22206c617267657220616e64207374726f6e676572207468616e20746865207768616c657320696e207468652063727970746f20776f726c642e2057697468207369676e69666963616e7420706f77657220616e6420696e666c75656e63652c20426c6f6f70206973206120746f6b656e207468617420636170746976617465732074686520636f6d6d756e6974792e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_4074_65eabea273.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLOOP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLOOP>>(v1);
    }

    // decompiled from Move bytecode v6
}

