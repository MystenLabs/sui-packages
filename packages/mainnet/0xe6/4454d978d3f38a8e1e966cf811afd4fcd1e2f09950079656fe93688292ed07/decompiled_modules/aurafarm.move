module 0xe64454d978d3f38a8e1e966cf811afd4fcd1e2f09950079656fe93688292ed07::aurafarm {
    struct AURAFARM has drop {
        dummy_field: bool,
    }

    fun init(arg0: AURAFARM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AURAFARM>(arg0, 6, b"AURAFARM", b"Aura Farming", b"Aura farming is like the most used term with anime, sports and lot of other industries.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreieie4rjbniri44td2oszapnkr6lsdqqbnuugmyoqffyp35omk7lve")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AURAFARM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AURAFARM>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

