module 0x494a62fc4033293cbb004be613b6df446bfbccf6587680db2ddf104a95b8a887::TempleOrangeEars {
    struct TEMPLEORANGEEARS has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEMPLEORANGEEARS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEMPLEORANGEEARS>(arg0, 0, b"COS", b"Temple Orange Ears", b"Awash... in the terror of what should never be...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Ears_Temple_Orange_Ears.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TEMPLEORANGEEARS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEMPLEORANGEEARS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

