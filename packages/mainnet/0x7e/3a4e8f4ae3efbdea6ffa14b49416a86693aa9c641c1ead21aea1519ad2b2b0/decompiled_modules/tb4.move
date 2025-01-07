module 0x7e3a4e8f4ae3efbdea6ffa14b49416a86693aa9c641c1ead21aea1519ad2b2b0::tb4 {
    struct TB4 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TB4, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TB4>(arg0, 6, b"TB4", b"Thunderbird4", b"Thunderbird three of four | Get 'm all", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/TB_4_068173e5ab.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TB4>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TB4>>(v1);
    }

    // decompiled from Move bytecode v6
}

