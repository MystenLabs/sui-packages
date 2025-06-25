module 0x82c73bf95c511eff6f6249f72fca9016238ea53c47511a2102f843f01f80959a::bblofita {
    struct BBLOFITA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BBLOFITA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BBLOFITA>(arg0, 6, b"BBLOFITA", b"Baby Lofita", b"Straight from the union between Lofi and Lofita, the most promising baby of the Sui chain is born: Baby Lofita", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreif3yoonn3szrtuitcaocxlyc5grtuz4jiivhgttuwhr7kk5cnxpk4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BBLOFITA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BBLOFITA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

