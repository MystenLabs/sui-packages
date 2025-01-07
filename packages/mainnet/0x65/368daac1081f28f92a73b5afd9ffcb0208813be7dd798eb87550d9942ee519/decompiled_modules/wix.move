module 0x65368daac1081f28f92a73b5afd9ffcb0208813be7dd798eb87550d9942ee519::wix {
    struct WIX has drop {
        dummy_field: bool,
    }

    fun init(arg0: WIX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WIX>(arg0, 6, b"WIX", b"WATER INTOXICATION", b"Let it SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_4639_249ba7e6ec.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WIX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WIX>>(v1);
    }

    // decompiled from Move bytecode v6
}

