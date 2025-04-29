module 0xb81b84d91ea2dd7ded2825c999e8ee6b8ead1b23cb6b9ea475cc6e405a68609f::bloop {
    struct BLOOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLOOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLOOP>(arg0, 6, b"BLOOP", b"Bloop On Sui", x"424c4f4f50206973206120637574652061717561746963206d656d6520637265617475726520726973696e672066726f6d2074686520646565702073656173206f66207468652053756920626c6f636b636861696e0a0a506f776572656420627920636f6d6d756e6974792076696265732c206e6f20726f61646d61702c20616e6420707572652066756e2c20424c4f4f50206973206865726520746f2073706c6173682c206d656d652c20616e64206d6f6f6e2e204469766520696e206561726c79206f72206d6973732074686520776176652e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeihqzagfmflao4wmm5pysjlek6kg5txwia36tah2nlqhvaizo4jla4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLOOP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BLOOP>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

