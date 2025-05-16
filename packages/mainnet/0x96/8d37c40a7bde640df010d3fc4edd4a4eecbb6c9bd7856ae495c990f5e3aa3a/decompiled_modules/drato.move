module 0x968d37c40a7bde640df010d3fc4edd4a4eecbb6c9bd7856ae495c990f5e3aa3a::drato {
    struct DRATO has drop {
        dummy_field: bool,
    }

    fun init(arg0: DRATO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DRATO>(arg0, 6, b"DRATO", b"DRATO SUI", b"DRATO live now", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreieyuo3p3msbat35g35qu5xivzpcanxoqa56xbpeq4jnbnmbwgns6y")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DRATO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DRATO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

