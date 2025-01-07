module 0x83ff86dec10b3c89f28047c02a9173848c187ed4795b448f6e7d7f947801bdb5::soos {
    struct SOOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOOS>(arg0, 6, b"SOOS", b"Heysoos Borracho on SUI", x"6e6574652061206c61207265766f6c7563696e2c2068696a6f7320646520707574610a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/B9p_Eei_E6_400x400_7eae2ea08b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOOS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SOOS>>(v1);
    }

    // decompiled from Move bytecode v6
}

