module 0x11fbbd36b41c411e3426b5a0a11272dcbe2ec38297029e3dac982272a61cddfc::grabby {
    struct GRABBY has drop {
        dummy_field: bool,
    }

    fun init(arg0: GRABBY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GRABBY>(arg0, 6, b"GRABBY", b"Sui Fortune Frog", b"For this fortunate frog, we are all the same! No supply manipulation here! Enjoy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/6_B725_F28_D3_F6_4_DB_3_BCA_9_957_A3_EF_17_B26_03a9c2943b.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GRABBY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GRABBY>>(v1);
    }

    // decompiled from Move bytecode v6
}

