module 0x467ad3a1551cefa534038805fb43fe0cc4a6d5cd87d410cd3759a608b0ca555a::stiger {
    struct STIGER has drop {
        dummy_field: bool,
    }

    fun init(arg0: STIGER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STIGER>(arg0, 6, b"STIGER", b"TIGER SUI", b"King of the jungle ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1702403546831_6493a0bbd5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STIGER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STIGER>>(v1);
    }

    // decompiled from Move bytecode v6
}

