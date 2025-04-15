module 0xd621d9133a2717a7e30bcd3f5989da6c288cfec7b7f2b2bdd0ebd130a70b3081::mbr {
    struct MBR has drop {
        dummy_field: bool,
    }

    fun init(arg0: MBR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MBR>(arg0, 6, b"MBR", b"Moonbarak", x"4d6f6f6e626172616b202d2074686520626c696e6765642d6f7574206b696e67206f6e205355492c20726f6c6c696e6720696e746f20537569204261736563616d70203230323520776974682061207472656173757265206368657374206f662053554921205765277265207468652074726f6c6c69657374206d656d65636f696e2c206d6978696e67204475626169277320676f6c64656e207669626573207769746820626c6f636b636861696e206368616f732e204a6f696e20746865206b696e67646f6d2c20686f646c2074696768742c20616e64207761746368204d6f6f6e626172616b20726569676e2073757072656d65202d2066726f6d207468652064657365727420746f20746865206d6f6f6e2c2068616269626921f09f9191f09f8c99", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://beige-abstract-pig-256.mypinata.cloud/ipfs/bafybeic7sbtwtsrxnollinuvftlxdwgkm6ois334jowtxdygl33rk22dga")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MBR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MBR>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

