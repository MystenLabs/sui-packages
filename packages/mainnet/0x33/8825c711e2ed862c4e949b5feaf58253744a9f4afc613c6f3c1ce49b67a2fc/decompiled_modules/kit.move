module 0x338825c711e2ed862c4e949b5feaf58253744a9f4afc613c6f3c1ce49b67a2fc::kit {
    struct KIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: KIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KIT>(arg0, 8, b"KIT", b"Kitsune", b"Kitsune is a symbol of knowledge and enlightenment.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://m4fizwlrlvm4eqrlkxdq34ge2syxguudywgmnskwaikrryddzk3q.arweave.net/ZwqM2XFdWcJCK1XHDfDE1LFzUoPFjMbJVgIVGOBjyrc")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<KIT>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KIT>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KIT>>(v1);
    }

    // decompiled from Move bytecode v6
}

