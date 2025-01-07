module 0x843a9f6ca1d0ee25bd21f2eb1cd7ef2d8864a84232c57b7cfbea824c2a99e325::hope {
    struct HOPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOPE>(arg0, 9, b"HOPE", b"HOPE OF DAY", b"HOPE the best part", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdn-user30887.skyeng.ru/uploads/668f639e9e468257825315.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<HOPE>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOPE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HOPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

