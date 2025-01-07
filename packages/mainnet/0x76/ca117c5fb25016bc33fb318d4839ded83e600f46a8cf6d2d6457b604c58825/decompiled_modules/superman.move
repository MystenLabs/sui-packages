module 0x76ca117c5fb25016bc33fb318d4839ded83e600f46a8cf6d2d6457b604c58825::superman {
    struct SUPERMAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUPERMAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUPERMAN>(arg0, 6, b"Superman", b"Superman on sui", b"Superman coming on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1_4aade195e9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUPERMAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUPERMAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

