module 0x45bfe740f635326abc460e0a0fc0e7f39d9b680d75848fe7685a6462f41be658::suid {
    struct SUID has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUID, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUID>(arg0, 6, b"SUID", b"SuiBoom Doge", x"4a6f696e20537569426f6f6d20446f67652c2069676e6974652074686520636f6d6d756e69747920776176652c20616e642063726561746520612070726f737065726f75732066757475726520746f676574686572210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/33baa9c5_3a13_4276_b70a_3f504e10cb06_0011694c77.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUID>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUID>>(v1);
    }

    // decompiled from Move bytecode v6
}

