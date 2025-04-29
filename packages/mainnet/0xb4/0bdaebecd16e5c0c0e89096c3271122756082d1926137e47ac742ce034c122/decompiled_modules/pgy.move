module 0xb40bdaebecd16e5c0c0e89096c3271122756082d1926137e47ac742ce034c122::pgy {
    struct PGY has drop {
        dummy_field: bool,
    }

    fun init(arg0: PGY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PGY>(arg0, 6, b"PGY", b"PUGGYDOG", b"PUGGYDOG Official Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreieeran6vnq2udksqbji4z6iykkryfr77vk4topv6je2b4o3ctlsua")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PGY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PGY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

