module 0x25ce1d0ee46cf6d49cfe1fc1b3e551500b52d1389a4f3d1715a29876b0179295::sbee {
    struct SBEE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SBEE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SBEE>(arg0, 6, b"SBee", b"SuiYa Bee", b"SBee meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/16d0c57f_3863_422a_bcc5_0a27b0d2b0e1_61959ca6d3.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SBEE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SBEE>>(v1);
    }

    // decompiled from Move bytecode v6
}

