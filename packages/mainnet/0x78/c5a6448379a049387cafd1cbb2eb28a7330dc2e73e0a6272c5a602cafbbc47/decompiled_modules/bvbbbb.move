module 0x78c5a6448379a049387cafd1cbb2eb28a7330dc2e73e0a6272c5a602cafbbc47::bvbbbb {
    struct BVBBBB has drop {
        dummy_field: bool,
    }

    fun init(arg0: BVBBBB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BVBBBB>(arg0, 6, b"Bvbbbb", b"aaaa", b"Bbbbb", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_9157_d6bdcaf675.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BVBBBB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BVBBBB>>(v1);
    }

    // decompiled from Move bytecode v6
}

