module 0x2e753cebf980fa67c7329d5ecd8e29b24989b4fbd0de9c49167d8beb0d74683b::pepish {
    struct PEPISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPISH>(arg0, 6, b"PEPISH", b"Pepish The Fish", b"The native fish of Sui. If other chains have the frog, we have the fish.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_6330055077703827211_y_4c42f93a71.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPISH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEPISH>>(v1);
    }

    // decompiled from Move bytecode v6
}

