module 0x20abbf71ef8dd235fc3d2c9943d2473205b95fff4233b8107420c5097899acd::suiwukong {
    struct SUIWUKONG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIWUKONG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIWUKONG>(arg0, 6, b"SUIWUKONG", b"Sui WuKong", b"Sui Wukong the king of apes, coming from China.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1500x500_0c38aeccec.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIWUKONG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIWUKONG>>(v1);
    }

    // decompiled from Move bytecode v6
}

