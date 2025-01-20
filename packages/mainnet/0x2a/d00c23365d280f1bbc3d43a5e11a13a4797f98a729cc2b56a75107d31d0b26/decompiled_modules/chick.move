module 0x2ad00c23365d280f1bbc3d43a5e11a13a4797f98a729cc2b56a75107d31d0b26::chick {
    struct CHICK has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHICK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHICK>(arg0, 6, b"CHICK", b"John Chick", b"John Chick is the John Wick of Sui and also the SUIftest hitman on the chain. Join the $CHICK flock.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Image_c8d546bc66.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHICK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHICK>>(v1);
    }

    // decompiled from Move bytecode v6
}

