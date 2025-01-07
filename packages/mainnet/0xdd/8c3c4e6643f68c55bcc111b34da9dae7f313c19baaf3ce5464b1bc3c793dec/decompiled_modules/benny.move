module 0xdd8c3c4e6643f68c55bcc111b34da9dae7f313c19baaf3ce5464b1bc3c793dec::benny {
    struct BENNY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BENNY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BENNY>(arg0, 6, b"BENNY", b"Benny On SUI", x"0a42656e6e79204279204d617474204675726965", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Whats_App_Image_2024_07_08_at_19_49_08_a86946f54b.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BENNY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BENNY>>(v1);
    }

    // decompiled from Move bytecode v6
}

