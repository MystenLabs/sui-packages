module 0xa164c06bd99d552bd7bfbf7eb321210dbf276b4ad8bbde472ddacc68f2aa1445::pinko {
    struct PINKO has drop {
        dummy_field: bool,
    }

    fun init(arg0: PINKO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PINKO>(arg0, 6, b"PINKO", b"PINKO SUI", b"Everyone loves Pinko.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241201_105603_323_354e4a6003.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PINKO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PINKO>>(v1);
    }

    // decompiled from Move bytecode v6
}

