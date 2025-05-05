module 0x7082bf696873ea0b37bda0f83323ed86f6e7f4ce796e083a87d0d97a7fde6c38::smalldick {
    struct SMALLDICK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMALLDICK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMALLDICK>(arg0, 6, b"SmallDick", b"Dev Has 3CM Penis", b"Dev Has 3CM Penis help him cut that shit", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibzev5qwbrijfahhchffhepqidn4pxyn3z7hbyoa3v3y5jdcx7ytq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMALLDICK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SMALLDICK>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

