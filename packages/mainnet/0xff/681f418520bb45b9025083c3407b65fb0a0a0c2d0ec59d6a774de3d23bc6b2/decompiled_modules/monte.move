module 0xff681f418520bb45b9025083c3407b65fb0a0a0c2d0ec59d6a774de3d23bc6b2::monte {
    struct MONTE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MONTE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MONTE>(arg0, 6, b"Monte", b"MontanaBlack88", b"MontanaBlack88 Meme Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/6f36c08a_6f7d_40f1_a9e8_12eee2ff0f93_profile_image_70x70_0d0e3c0ff2.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MONTE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MONTE>>(v1);
    }

    // decompiled from Move bytecode v6
}

