module 0x243f6785cb083ffff2104d2d9808864926246ae196202dfc738a2958859df839::muppy {
    struct MUPPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: MUPPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MUPPY>(arg0, 6, b"MUPPY", b"Muppy On Sui", b"Meet Muppy the CUTEST amphibian to leap into the crypto swamp! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000028614_f7a8368cd6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MUPPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MUPPY>>(v1);
    }

    // decompiled from Move bytecode v6
}

