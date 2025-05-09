module 0xf65e48e5e884c163384691c6600275ad8caca506fcffb3aa6fa605ec21269a1::milky {
    struct MILKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: MILKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MILKY>(arg0, 6, b"MILKY", b"Milky On Sui", x"4d65657420244d494c4b590a4d6f6f206d6f6f6f206d6f6f206d6f6f6f206d6f6f6f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000067906_07a4a60db0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MILKY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MILKY>>(v1);
    }

    // decompiled from Move bytecode v6
}

