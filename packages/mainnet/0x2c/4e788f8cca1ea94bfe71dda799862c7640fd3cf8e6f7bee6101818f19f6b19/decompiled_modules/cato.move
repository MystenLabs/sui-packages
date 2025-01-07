module 0x2c4e788f8cca1ea94bfe71dda799862c7640fd3cf8e6f7bee6101818f19f6b19::cato {
    struct CATO has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATO>(arg0, 6, b"CATO", b"CATO THE CAT", b"$CATO is here to print your bag ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/CATO_496bd4b988.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CATO>>(v1);
    }

    // decompiled from Move bytecode v6
}

