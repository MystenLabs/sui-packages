module 0xe05e6327b1caca286f59d1de6e5f66925985e4e9a7694fc4d1501f4a92a21aac::tauros {
    struct TAUROS has drop {
        dummy_field: bool,
    }

    fun init(arg0: TAUROS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TAUROS>(arg0, 6, b"Tauros", b"TaurosOnSui", b"Pokemon Tauros On Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreignhu26jmzfzocejs72bfziuxbc4aq6gzbmape4mqsnaywvdbkb3q")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TAUROS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TAUROS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

