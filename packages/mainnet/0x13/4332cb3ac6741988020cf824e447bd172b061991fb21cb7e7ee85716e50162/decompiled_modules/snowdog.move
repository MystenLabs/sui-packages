module 0x134332cb3ac6741988020cf824e447bd172b061991fb21cb7e7ee85716e50162::snowdog {
    struct SNOWDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNOWDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNOWDOG>(arg0, 6, b"SNOWDOG", b"Snowdog", b"With a new model that the community will get to choose whether we go through with it or remain a community token!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000048842_ce34bf82b2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNOWDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SNOWDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

