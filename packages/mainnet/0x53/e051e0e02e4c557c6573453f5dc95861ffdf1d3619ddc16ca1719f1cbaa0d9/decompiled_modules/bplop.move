module 0x53e051e0e02e4c557c6573453f5dc95861ffdf1d3619ddc16ca1719f1cbaa0d9::bplop {
    struct BPLOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: BPLOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BPLOP>(arg0, 6, b"BPLOP", b"BabyPlop", b"A little plop of PLOP", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_01_02_48_38_f2f60de1f7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BPLOP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BPLOP>>(v1);
    }

    // decompiled from Move bytecode v6
}

