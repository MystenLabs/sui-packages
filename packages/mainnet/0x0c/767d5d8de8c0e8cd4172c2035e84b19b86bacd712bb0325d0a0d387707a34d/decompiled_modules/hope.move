module 0xc767d5d8de8c0e8cd4172c2035e84b19b86bacd712bb0325d0a0d387707a34d::hope {
    struct HOPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOPE>(arg0, 9, b"HOPE", b"HOPE OF LIFE", b"HOPE the best part of our life", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.pinimg.com/originals/7f/ea/79/7fea79facd81d3b0cbefdfaf36dd1f38.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<HOPE>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOPE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HOPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

