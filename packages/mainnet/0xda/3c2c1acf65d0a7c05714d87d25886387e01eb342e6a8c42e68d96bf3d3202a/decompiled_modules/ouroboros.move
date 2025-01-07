module 0xda3c2c1acf65d0a7c05714d87d25886387e01eb342e6a8c42e68d96bf3d3202a::ouroboros {
    struct OUROBOROS has drop {
        dummy_field: bool,
    }

    fun init(arg0: OUROBOROS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OUROBOROS>(arg0, 6, b"OUROBOROS", b"Ouroboros", x"496e2074686520656d6272616365206f66204f75726f626f726f732c207468657265206c69657320612070726f666f756e6420776973646f6d2e0a54686572652063616e206265206e6f206c69666520776974686f75742064656174682c20616e64206e6f206d696e7420776974686f7574206275726e2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Whats_App_Image_2024_10_16_at_17_09_08_43a99b6e8d.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OUROBOROS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OUROBOROS>>(v1);
    }

    // decompiled from Move bytecode v6
}

