module 0x8d46e6bb7808b3c382ffc8bf4077a59f2d206f35780b86bd01e9c22985ec8e1f::og {
    struct OG has drop {
        dummy_field: bool,
    }

    fun init(arg0: OG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OG>(arg0, 6, b"OG", b"FartOG", b"The SUI meme coin that smells like success", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiaqs6x3ynnles4ey3j2jwwlob6fgzypuimccjrkld4q2jeogb34dm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<OG>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

