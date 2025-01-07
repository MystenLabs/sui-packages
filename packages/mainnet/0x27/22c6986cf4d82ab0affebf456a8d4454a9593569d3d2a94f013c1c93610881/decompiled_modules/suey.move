module 0x2722c6986cf4d82ab0affebf456a8d4454a9593569d3d2a94f013c1c93610881::suey {
    struct SUEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUEY>(arg0, 6, b"SUEY", b"Suel The Seal", b"Suey the seal was an iconic childrens toy created in 2009, Sueys passions include hunting suilamis, having fun and causing havoc to the typical dog, cat and frog coin. There are 30 different species of seals but Suey is the coldest one of them all.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2024_10_03_11_25_49_c3dcb9c657.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUEY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUEY>>(v1);
    }

    // decompiled from Move bytecode v6
}

