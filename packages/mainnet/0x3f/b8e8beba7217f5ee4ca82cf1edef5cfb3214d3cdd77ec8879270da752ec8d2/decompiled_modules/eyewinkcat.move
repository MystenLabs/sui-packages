module 0x3fb8e8beba7217f5ee4ca82cf1edef5cfb3214d3cdd77ec8879270da752ec8d2::eyewinkcat {
    struct EYEWINKCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: EYEWINKCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EYEWINKCAT>(arg0, 6, b"EYEWINKCAT", b"Eyewinkcat", b"The wink that makes you fly; the wink that makes jeeters cry.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000024500_5ef0d50327.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EYEWINKCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EYEWINKCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

