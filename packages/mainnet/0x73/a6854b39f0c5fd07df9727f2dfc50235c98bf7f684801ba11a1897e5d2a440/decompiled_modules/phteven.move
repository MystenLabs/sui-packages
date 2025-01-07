module 0x73a6854b39f0c5fd07df9727f2dfc50235c98bf7f684801ba11a1897e5d2a440::phteven {
    struct PHTEVEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: PHTEVEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PHTEVEN>(arg0, 6, b"Phteven", b"Boss Phteven", b"Don't mess about Phteven", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/phteven_cd2ead330e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PHTEVEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PHTEVEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

