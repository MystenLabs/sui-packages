module 0x766da843b298dbeeb751c51f346c24b8be81ed08ad3b12406a7ddcd17cd9dec8::ape {
    struct APE has drop {
        dummy_field: bool,
    }

    fun init(arg0: APE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<APE>(arg0, 6, b"APE", b"SuiApe", x"57686174e2809973206120636861696e20776974686f757420697473206f776e206170653f205765e280997265206865726520746f2066697820746861742e0a5468652061706520697320636f6d696e6720736f6f6e20746f20746865202453554920626c6f636b636861696e2e0a24535549415045", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731696060318.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<APE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<APE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

