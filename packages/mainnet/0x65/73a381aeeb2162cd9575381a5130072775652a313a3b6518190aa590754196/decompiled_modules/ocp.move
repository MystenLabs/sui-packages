module 0x6573a381aeeb2162cd9575381a5130072775652a313a3b6518190aa590754196::ocp {
    struct OCP has drop {
        dummy_field: bool,
    }

    fun init(arg0: OCP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OCP>(arg0, 6, b"OCP", b"Onchain Pixel", b"New name same mission empowering pixel art NFTs on chain official token Onchainpixel Lets build", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreif4w2ymucftuwkmw36qxahzy4aambrqwjv4r67d2djngtugckgo7a")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OCP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<OCP>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

