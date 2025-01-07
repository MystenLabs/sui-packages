module 0x76d1e3c4153e375e8f6ddf2847e67565fd95019ea8eb3624103165dca0982452::bbird {
    struct BBIRD has drop {
        dummy_field: bool,
    }

    fun init(arg0: BBIRD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BBIRD>(arg0, 6, b"BBIRD", b"BlueBird On Sui", b"A blue bird with strong wings, ready to fly high to ward off storms and lightning", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000002055_b836f7e1be.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BBIRD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BBIRD>>(v1);
    }

    // decompiled from Move bytecode v6
}

