module 0x129bb4663fc31a4c31a9164e1183a2c3f8d13922110d49c4dbe044a0dcf4c461::stats {
    struct STATS has drop {
        dummy_field: bool,
    }

    fun init(arg0: STATS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STATS>(arg0, 6, b"Stats", b"Punk", b"Building charts and data that make NFTs a bit easier to understand.  ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/K5ik_WE_9_400x400_86e9e76f10.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STATS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STATS>>(v1);
    }

    // decompiled from Move bytecode v6
}

