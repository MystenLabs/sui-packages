module 0xde5a7a67a297a9b2a1f309c65084c5c411eabeab8310fcf5eb8ac2666d4239db::pepon {
    struct PEPON has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPON>(arg0, 6, b"PEPON", b"Pepemon", x"504550454d4f4e2020426f726e20696e2074686520746f786963207377616d7073206f6620346368616e20616e6420726169736564206f6e20612064696574206f66204e465420616e642063727970746f20636f70652c207468652056696e7461676520506570656d6f6e206d656d6520697320612067726f74657371756520667573696f6e206f662050657065207468652046726f677320636f7270736520616e642074686520726f7474696e67206e6f7374616c676961206f662039307320506f6bc3a96d6f6e20626f6f746c6567732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeigcsd6s757lkr4is66wjyz5jujmlt5hzhfo2776bngjzx2yszfvxu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PEPON>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

