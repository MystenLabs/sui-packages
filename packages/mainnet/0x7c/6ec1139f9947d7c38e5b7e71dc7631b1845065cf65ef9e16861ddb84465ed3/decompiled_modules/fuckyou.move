module 0x7c6ec1139f9947d7c38e5b7e71dc7631b1845065cf65ef9e16861ddb84465ed3::fuckyou {
    struct FUCKYOU has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUCKYOU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUCKYOU>(arg0, 6, b"FUCKYOU", b"FUCK-YOU", b"FUCK", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/rocket_launch_696x392_d09c120286.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUCKYOU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FUCKYOU>>(v1);
    }

    // decompiled from Move bytecode v6
}

