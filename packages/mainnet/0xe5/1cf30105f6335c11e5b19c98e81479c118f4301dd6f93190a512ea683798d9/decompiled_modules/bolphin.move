module 0xe51cf30105f6335c11e5b19c98e81479c118f4301dd6f93190a512ea683798d9::bolphin {
    struct BOLPHIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOLPHIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOLPHIN>(arg0, 6, b"BOLPHIN", b"Bread Dolphin", b"The dolphin is made of bread.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/bread_dolph_5d75b4c811.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOLPHIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOLPHIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

