module 0x849648c36ce3061d1e483d0cc39f9b9a7406e6732a7966e368abf4f4801c41ce::geng {
    struct GENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: GENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GENG>(arg0, 6, b"Geng", b"GengarSui", x"47656e67617220537569202847454e47292c2061206861756e74696e676c7920636861726d696e67206d656d6520746f6b656e20697373756564206f6e207468652053756920626c6f636b636861696e2120496e737069726564206279207468652063756e6e696e6720616e64206d7973746572696f75732047686f73742d7479706520506f6bc3a96d6f6e2047656e6761722066726f6d20506f6bc3a96d6f6e2c2047454e4720636f6d62696e65732068756d6f722c20616e6420636f6d6d756e6974792d64726976656e207370697269742c2061696d696e6720746f206265636f6d6520612067686f73746c792070726573656e636520696e20746865206d656d6520636f696e20776f726c6421", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeibxjekiz7tnj6ejdmlfkqkpljsmif3qqtiiowkliqekyqrej3a3qy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GENG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<GENG>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

