module 0xfb81dac47fb9aac987355eedd91aef88ebbe2d029a3e4a3e588001cc6d1b2ec7::kingmove {
    struct KINGMOVE has drop {
        dummy_field: bool,
    }

    fun init(arg0: KINGMOVE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KINGMOVE>(arg0, 6, b"KINGMOVE", b"King Movepump", b"Kingmove have a mission to land on the moon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000078082_a3816a09d3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KINGMOVE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KINGMOVE>>(v1);
    }

    // decompiled from Move bytecode v6
}

