module 0x48d4d76def2b9ec4298098dd1fa643d3b467c23e1908dcf54d78d7b35c928467::bvr {
    struct BVR has drop {
        dummy_field: bool,
    }

    fun init(arg0: BVR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BVR>(arg0, 6, b"BVR", b"BeaverSUI BVR", x"0a244256522020546865207368617270657374206d6172696e6520617263686974656374732c2074686520426561766572732c206e6f7720746872697665206f6e20746865206d6f737420656666696369656e7420626c6f636b636861696e3a205355492e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a_407bddfa38.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BVR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BVR>>(v1);
    }

    // decompiled from Move bytecode v6
}

