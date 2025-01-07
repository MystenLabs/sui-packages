module 0x2157bafa64bd622f2cf03fa93f16c3f1c43e4df1c0efa4e1827219dc1ac6a838::suiri {
    struct SUIRI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIRI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIRI>(arg0, 6, b"SUIRI", b"Suiriname", b"Suiriname is Sui's homeland. Let's restore Suiriname's glory.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Suiriname_Logo_7099da2342.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIRI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIRI>>(v1);
    }

    // decompiled from Move bytecode v6
}

