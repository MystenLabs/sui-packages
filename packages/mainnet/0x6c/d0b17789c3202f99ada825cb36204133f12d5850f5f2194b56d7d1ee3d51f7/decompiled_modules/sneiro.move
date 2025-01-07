module 0x6cd0b17789c3202f99ada825cb36204133f12d5850f5f2194b56d7d1ee3d51f7::sneiro {
    struct SNEIRO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNEIRO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNEIRO>(arg0, 6, b"SNEIRO", b"SuiNeiro", b"SuiNeiro is a fun and community-driven memecoin launched on the Sui Blockchain. Our mission is simple: to bring fun and creativity to the crypto space. With SuiNeiro, you get fast transactions, low fees, and a whole lot of memes. Join us as we shake up the crypto world with humor and innovation!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/e1_Nvtik7_400x400_8eee6c033e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNEIRO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SNEIRO>>(v1);
    }

    // decompiled from Move bytecode v6
}

