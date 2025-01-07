module 0xbad7c6a5b3c31e882c03caedc9d0adf4e73bf2656f74436501da06eaf1e209a1::moppy {
    struct MOPPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOPPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOPPY>(arg0, 6, b"MOPPY", b"Moppy", b"Cleaning SUI's floor", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Fighting_29_284b43c20e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOPPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOPPY>>(v1);
    }

    // decompiled from Move bytecode v6
}

