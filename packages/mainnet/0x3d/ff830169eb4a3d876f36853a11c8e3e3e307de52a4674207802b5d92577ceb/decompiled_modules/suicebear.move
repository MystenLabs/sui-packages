module 0x3dff830169eb4a3d876f36853a11c8e3e3e307de52a4674207802b5d92577ceb::suicebear {
    struct SUICEBEAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICEBEAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICEBEAR>(arg0, 6, b"SUICEBEAR", b"SuiceBear", b"Suicebear aims to help wild animals and endangered animals in the evolving and developing world, and we will transfer a portion of our profits to the rescue of these animals", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000038582_e95f5adbb5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICEBEAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUICEBEAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

