module 0xd1cdc29cbb30f7a6478de476689262d93fc9c8c5d0bb28cc2ee8927b2341198c::waas {
    struct WAAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAAS>(arg0, 6, b"WAAS", b"waas", b"we are all Satoshi", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/WX_20241008_024607_2x_c00b5929ef.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAAS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WAAS>>(v1);
    }

    // decompiled from Move bytecode v6
}

