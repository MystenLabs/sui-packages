module 0x1dd657e22df0cd2accbac4252d1347c7ad61de6429316ebbf924be9a3cb21201::labusui {
    struct LABUSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: LABUSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LABUSUI>(arg0, 6, b"LabuSUI", b"Sui Labubu", b"go", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeibrtrj4fbehrio6fcwywsdcay5xb2vvza7lx5kzyobs456vqqniam")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LABUSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<LABUSUI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

