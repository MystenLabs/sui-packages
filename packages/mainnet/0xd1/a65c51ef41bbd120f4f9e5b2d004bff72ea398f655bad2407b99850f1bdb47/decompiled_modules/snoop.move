module 0xd1a65c51ef41bbd120f4f9e5b2d004bff72ea398f655bad2407b99850f1bdb47::snoop {
    struct SNOOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNOOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNOOP>(arg0, 6, b"SNOOP", b"Snoop cats", b"SNOOPCAT has two goals in life: smoke with buddies and make cash. The most baked cat in crypto.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20241002_022334_24bbaef118.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNOOP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SNOOP>>(v1);
    }

    // decompiled from Move bytecode v6
}

