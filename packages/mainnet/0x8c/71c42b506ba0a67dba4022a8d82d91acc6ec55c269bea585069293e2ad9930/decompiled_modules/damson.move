module 0x8c71c42b506ba0a67dba4022a8d82d91acc6ec55c269bea585069293e2ad9930::damson {
    struct DAMSON has drop {
        dummy_field: bool,
    }

    fun init(arg0: DAMSON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DAMSON>(arg0, 6, b"DamSon", b"Dam Son", b"iykyk", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Dam_Son_329310896c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DAMSON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DAMSON>>(v1);
    }

    // decompiled from Move bytecode v6
}

