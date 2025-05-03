module 0xd6045a17c905263d4f24ae8b686cbbffa9527516d3e68ee6e6ba6a006086da36::cartl {
    struct CARTL has drop {
        dummy_field: bool,
    }

    fun init(arg0: CARTL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CARTL>(arg0, 6, b"CARTL", b"Cartel", b"Introducing sui $Cartel, Coming in full gangster force to take over the sui memecoin ranks", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeieq5j6cm42usqdwoxempmgwbeknk2a7kolitsgtvjcjt4jfls2zai")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CARTL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CARTL>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

