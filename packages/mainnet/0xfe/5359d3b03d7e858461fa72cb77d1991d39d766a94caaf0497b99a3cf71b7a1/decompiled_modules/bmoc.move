module 0xfe5359d3b03d7e858461fa72cb77d1991d39d766a94caaf0497b99a3cf71b7a1::bmoc {
    struct BMOC has drop {
        dummy_field: bool,
    }

    fun init(arg0: BMOC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BMOC>(arg0, 6, b"BMOC", b"COWINANCE", x"4d656d6520746f6b656e207769746820636f77732066696e616e6365206f7220627573696e6573732e546f206c61756e6368206973206f776e206465782c206c61756e63687061642c7374616b696e672c77616c6c657420696e2066757475726520616e6420424d4f4320697320746865206e617469766520636f696e2e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000297996_c11d9a361a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BMOC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BMOC>>(v1);
    }

    // decompiled from Move bytecode v6
}

