module 0xdf5e5ccb50b0e6884d7753ec5348497deb48189bb9785de50e31f70154fe8175::freddy {
    struct FREDDY has drop {
        dummy_field: bool,
    }

    fun init(arg0: FREDDY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FREDDY>(arg0, 9, b"FREDDY", b"FREDDYMERCURY", b"FREDDYMERCURY", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://upload.wikimedia.org/wikipedia/commons/thumb/e/ef/Freddie_Mercury_performing_in_New_Haven%2C_CT%2C_November_1977.jpg/1024px-Freddie_Mercury_performing_in_New_Haven%2C_CT%2C_November_1977.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<FREDDY>(&mut v2, 500000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FREDDY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FREDDY>>(v1);
    }

    // decompiled from Move bytecode v6
}

