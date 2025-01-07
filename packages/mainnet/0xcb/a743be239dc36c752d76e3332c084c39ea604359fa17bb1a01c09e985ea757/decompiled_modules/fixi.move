module 0xcba743be239dc36c752d76e3332c084c39ea604359fa17bb1a01c09e985ea757::fixi {
    struct FIXI has drop {
        dummy_field: bool,
    }

    fun init(arg0: FIXI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FIXI>(arg0, 6, b"Fixi", b"Foxui", b"Foxui - iceland", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/fefwefw_dbdf2f88fe.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FIXI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FIXI>>(v1);
    }

    // decompiled from Move bytecode v6
}

