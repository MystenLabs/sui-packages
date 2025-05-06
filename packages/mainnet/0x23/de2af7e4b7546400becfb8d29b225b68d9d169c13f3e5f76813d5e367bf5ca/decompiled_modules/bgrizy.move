module 0x23de2af7e4b7546400becfb8d29b225b68d9d169c13f3e5f76813d5e367bf5ca::bgrizy {
    struct BGRIZY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BGRIZY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BGRIZY>(arg0, 6, b"BGRIZY", b"Baby Grizzy", b"The Baby Grizzy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeiagxxmzuy4qq3t2yfsrvesk6vfubgjy2mhec7nm4d2ds65bjwkk6u")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BGRIZY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BGRIZY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

