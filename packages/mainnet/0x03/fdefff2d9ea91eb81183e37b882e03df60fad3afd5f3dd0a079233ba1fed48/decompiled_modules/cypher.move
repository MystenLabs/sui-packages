module 0x3fdefff2d9ea91eb81183e37b882e03df60fad3afd5f3dd0a079233ba1fed48::cypher {
    struct CYPHER has drop {
        dummy_field: bool,
    }

    fun init(arg0: CYPHER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CYPHER>(arg0, 6, b"Cypher", b"Cypherheart", b"Cypher heart The owner of sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1gi8_Fq_Wz_400x400_a0bd895b7b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CYPHER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CYPHER>>(v1);
    }

    // decompiled from Move bytecode v6
}

