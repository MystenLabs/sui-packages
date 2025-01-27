module 0x44ea51f4738242392c4475db5ca09078d927da89e5516b62fadd070d1b644db0::obama {
    struct OBAMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: OBAMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OBAMA>(arg0, 9, b"OBAMA", b"Malik Obama", b"The brother of Barack Obama ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmPSSvES7eVh14PZQ149FxtfAubgCTW4uWBBKh6n6DswbJ")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<OBAMA>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OBAMA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OBAMA>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

