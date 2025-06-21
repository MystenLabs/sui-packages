module 0xc147af1402291881ea8d2dabfa93d45fe4460718c1fda41712e42dffd99bb42e::mask {
    struct MASK has drop {
        dummy_field: bool,
    }

    fun init(arg0: MASK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MASK>(arg0, 6, b"MASK", b"Catwifmask On Sui", b"The original Catwifmask memecoin, taking over Sui one mask at a time.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreicsdztbvg5ehhduwww2cea6dyc7hcd3gsgri6cofrmnmvstyjgz7u")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MASK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MASK>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

