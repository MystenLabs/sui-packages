module 0xb1f7e58c08e8dfae499466486394b98965b9378030f8124c9dfdcea774c949b3::bln {
    struct BLN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLN>(arg0, 6, b"BLN", b"BALON", b"KAPADOKYA BALON", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/istockphoto_1297349747_612x612_1c3f5cc230.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLN>>(v1);
    }

    // decompiled from Move bytecode v6
}

