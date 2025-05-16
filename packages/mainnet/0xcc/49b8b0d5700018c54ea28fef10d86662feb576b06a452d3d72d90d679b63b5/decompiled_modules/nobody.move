module 0xcc49b8b0d5700018c54ea28fef10d86662feb576b06a452d3d72d90d679b63b5::nobody {
    struct NOBODY has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOBODY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOBODY>(arg0, 6, b"NOBODY", b"Nobody Sausage", b"Anybody can be a Nobody", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreic6ej4t7nt7pi6doodgsplibgzat5c6sb7xax3ql6mb2j2jqlf5iq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOBODY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<NOBODY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

