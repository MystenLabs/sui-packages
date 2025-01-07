module 0xc2cb3bdc9e4ca0545241e42189039dbe2c57d61440e8fdc6a6f0c8ac962bdaf7::chillpowell {
    struct CHILLPOWELL has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHILLPOWELL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHILLPOWELL>(arg0, 6, b"CHILLPOWELL", b"Just a chill powell", b"Who did this?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/chillpowell_932987576a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHILLPOWELL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHILLPOWELL>>(v1);
    }

    // decompiled from Move bytecode v6
}

