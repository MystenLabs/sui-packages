module 0xde7956c2c7b2eed95b1df7b3ed47c39a62a3fc4187fcc3223a9e9da21474aeae::redy {
    struct REDY has drop {
        dummy_field: bool,
    }

    fun init(arg0: REDY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<REDY>(arg0, 6, b"REDY", b"Sui Redy", b"Redy - Your sweet gateway to the crypto world", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/aa3_da7e3d5224.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<REDY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<REDY>>(v1);
    }

    // decompiled from Move bytecode v6
}

