module 0x7452027b18e4853ea3bab129b9dd431a3c3485e337c97ac60ac87acf10b5421e::joycat {
    struct JOYCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: JOYCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JOYCAT>(arg0, 6, b"JOYCAT", b"SUI JOYCAT", b"JOYCAT is more than just a pet; is the embodiment of the spirit of $MOG and the playful spirit of internet meme culture. Representing decentralized creativity and community power, JOYCAT brings together the whimsical side of SUI with the unstoppable drive toward success. As a guardian of cosmic domination, JOYCAT unites the SUI community, turning internet culture into a force shaping the crypto landscape.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2024_10_15_02_52_03_32439ff36e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JOYCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JOYCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

