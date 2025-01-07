module 0xb3a1146f8dba4f5940480764f204047d8ce0794286c8e5bdc1c111ca2a2ea8ae::bullshark {
    struct BULLSHARK has drop {
        dummy_field: bool,
    }

    fun init(arg0: BULLSHARK, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::epoch(arg1) == 615 || 0x2::tx_context::epoch(arg1) == 616, 1);
        let (v0, v1) = 0x2::coin::create_currency<BULLSHARK>(arg0, 9, b"BSHARK", b"BULLSHARK", b"Bullshark is a meme + utility project inspired by the most famous Sui Fren created by Mysten Labs.  #SniperBot #AI #NFTs", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://bafkreihbeqqcphnt5356uh43becdgr556lspaahyoo4mxshtzxe7ih4qde.ipfs.w3s.link/"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BULLSHARK>(&mut v2, 1000000000000000000, @0xd9a143461af061e784e22e070802a625bdd913119e72aee999aa8d4bab302363, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BULLSHARK>>(v2, @0xd9a143461af061e784e22e070802a625bdd913119e72aee999aa8d4bab302363);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BULLSHARK>>(v1);
    }

    // decompiled from Move bytecode v6
}

