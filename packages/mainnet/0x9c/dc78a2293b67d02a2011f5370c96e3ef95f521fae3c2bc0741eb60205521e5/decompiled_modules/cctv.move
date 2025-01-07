module 0x9cdc78a2293b67d02a2011f5370c96e3ef95f521fae3c2bc0741eb60205521e5::cctv {
    struct CCTV has drop {
        dummy_field: bool,
    }

    fun init(arg0: CCTV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CCTV>(arg0, 6, b"CCTV", b"CowChickenTurtleVicuna", x"436f77436869636b656e547572746c65566963756e610a0a4d6f6f6f6f6f6f6f6f6f6f6f6f6f6f6f6b756b756b756b756b756b696b696b696b69696b696b69726f6e6b726f6e6b726f6e6b726f6e6b626c6161616161616161616161616174", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000030449_e31e236dbe.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CCTV>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CCTV>>(v1);
    }

    // decompiled from Move bytecode v6
}

