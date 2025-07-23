module 0x8c184f0373fbcc867d673448e8575ea5c4c03ab084475891c08fa1f51e87c24f::clb {
    struct CLB has drop {
        dummy_field: bool,
    }

    fun init(arg0: CLB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CLB>(arg0, 6, b"CLB", b"CELEBI ON SUI", x"43656c656269206f6e205375692e20546865206f6e6c79204c6567656e6461727920506f6bc3a96d6f6e2063617061626c65206f66206861726e657373696e672074686520706f776572206f662074686520626c6f636b636861696e2e204861726420746f2063617463682069742e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeiciigf5rhah6e2lyp7izrnpoglq5za7ya6s54kv62a3y6blbsny7a")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CLB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CLB>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

