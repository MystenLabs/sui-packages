module 0x86e63ddff733953b2759ed5471726ff238fdc28db8ff9f877d729fa685120b1c::spotai {
    struct SPOTAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPOTAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPOTAI>(arg0, 6, b"SPOTAI", b"SUI SPOT-AI", x"5468652047656e65736973206f662053504f542041490a0a2253706f742041492220656d626f64696573207468652069646561206f662061207368617270206f627365727665722c20616c7761797320726561647920746f206964656e7469667920616e642073706f746c6967687420746865206d6f73742070726f6d6973696e6720746f6b656e7320696e20746865206d61726b6574205355492e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20250110_173823_403_c7fec8072c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPOTAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPOTAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

