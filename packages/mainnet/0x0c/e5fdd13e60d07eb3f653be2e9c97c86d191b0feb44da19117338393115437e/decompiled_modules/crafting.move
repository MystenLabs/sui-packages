module 0xce5fdd13e60d07eb3f653be2e9c97c86d191b0feb44da19117338393115437e::crafting {
    struct CRAFTING has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRAFTING, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CRAFTING>(arg0, 6, b"CRAFTING", b"Crafting on SUI", x"556e6c6561736820796f757220696e6e6572206d696e65722077697468202443524146542c2074686520537569206d656d65636f696e20696e7370697265642062792074686520706978656c61746564206d61676963206f66204d696e656372616674212047657420696e206f6e2074686520616374696f6e2077697468206120636f696e2074686174277320616c6c2061626f757420637265617469766974792c20636f6d6d756e6974792c20616e642063727970746f2066756e2e0a0a5965732c2074686572652077696c6c2062652061204d43207365727665722e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241209_115558_321_79586f1b13.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRAFTING>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CRAFTING>>(v1);
    }

    // decompiled from Move bytecode v6
}

