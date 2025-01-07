module 0xf339163580af157ccc4d15efbb319060db45b0ec12a26bdcde60264ed455b1ca::bumpy {
    struct BUMPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUMPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUMPY>(arg0, 6, b"BUMPY", b"BUMPY ON SUI", b"Our mascot is none other than the iconic Bumpy Dog, forever frozen mid-speed bump.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Fuj_U5_O2_Z_400x400_d028c95e8e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUMPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUMPY>>(v1);
    }

    // decompiled from Move bytecode v6
}

