module 0xa140287b185b8792c61b514f6b6d18202f43725149c9e6be4004597dc44fe4c9::bucki {
    struct BUCKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUCKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUCKI>(arg0, 6, b"BUCKI", b"Bucki on sui", x"244255434b492069732061206d656d65636f696e2077697468206e6f20696e7472696e7369632076616c7565206f720a6578706563746174696f6e206f662066696e616e6369616c2070726f6669742e205468657265206973206e6f20666f726d616c0a7465616d206f7220726f61646d61702e2054686520636f696e20697320636f6d706c6574656c79207573656c6573730a616e6420697320696e74656e64656420736f6c656c7920666f7220656e7465727461696e6d656e7420707572706f7365732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000118361_e45bb57aa3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUCKI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUCKI>>(v1);
    }

    // decompiled from Move bytecode v6
}

