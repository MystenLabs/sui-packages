module 0x4687c682c56e387e50f567b2b4ccd0a085258773e51915740557ff65b05dd16::shen {
    struct SHEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHEN>(arg0, 6, b"SHEN", b"Shen the Snake", x"486921204d79206e616d65206973205368656e2e2049276d206120736e616b6520626f726e20746f206265636f6d6520746865206d6173636f74206f662032303235206173206974206973207468652079656172206f662074686520736e616b652e2054616b6520676f6f642063617265206f66206d6520616e64207765276c6c20676f20666f722068656967687473206e657665722072656163686564206265666f7265206f6e20537569210a0a4861707079204e657720596561722120", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000256_15d7d98d8a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

