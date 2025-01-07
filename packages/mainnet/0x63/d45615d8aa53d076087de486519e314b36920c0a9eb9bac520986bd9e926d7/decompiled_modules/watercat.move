module 0x63d45615d8aa53d076087de486519e314b36920c0a9eb9bac520986bd9e926d7::watercat {
    struct WATERCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: WATERCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WATERCAT>(arg0, 6, b"WATERCAT", b"Watercat", x"4469766520696e746f20746865207075727266656374206d656d6520746f6b656e210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730744167301.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WATERCAT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WATERCAT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

