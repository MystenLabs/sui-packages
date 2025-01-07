module 0xb261399263755c0493c792d1d56238ee7bd0932680452a153df082fb2be78ff3::cpca {
    struct CPCA has drop {
        dummy_field: bool,
    }

    fun init(arg0: CPCA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CPCA>(arg0, 6, b"CPCA", b"Captain America", b"#1 FIRST Captain America on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/captainamerica_ad2ad1a336.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CPCA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CPCA>>(v1);
    }

    // decompiled from Move bytecode v6
}

