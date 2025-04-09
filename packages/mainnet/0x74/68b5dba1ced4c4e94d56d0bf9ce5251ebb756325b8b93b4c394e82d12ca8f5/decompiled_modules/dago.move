module 0x7468b5dba1ced4c4e94d56d0bf9ce5251ebb756325b8b93b4c394e82d12ca8f5::dago {
    struct DAGO has drop {
        dummy_field: bool,
    }

    fun init(arg0: DAGO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DAGO>(arg0, 6, b"DAGO", b"Dago", b"Dago is a fat and smart dog, a little fierce but actually has a good heart", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000055752_bf67c6baff.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DAGO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DAGO>>(v1);
    }

    // decompiled from Move bytecode v6
}

