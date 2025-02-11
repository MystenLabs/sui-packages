module 0x5927111fa61d34c32395bddafadb83e669497b1075ae42cb24e74472d3724262::core {
    struct CORE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CORE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CORE>(arg0, 9, b"CORE", b"CORE", b"CORE on SUI chain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://arweave.net/DZaqvlQahOncXM4T3HE9cT00OaC8a5amhUW-iXuaD0E")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CORE>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CORE>>(v2, @0x27022d0740abf9177a8b8a80b34806f7e53be7b3354337f83561ca84fd568d5f);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CORE>>(v1);
    }

    // decompiled from Move bytecode v6
}

