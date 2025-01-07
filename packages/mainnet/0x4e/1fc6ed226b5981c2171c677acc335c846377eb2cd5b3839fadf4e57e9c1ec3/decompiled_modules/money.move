module 0x4e1fc6ed226b5981c2171c677acc335c846377eb2cd5b3839fadf4e57e9c1ec3::money {
    struct MONEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: MONEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MONEY>(arg0, 9, b"MONEY", b"MONEY", b"MONEY Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MONEY>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MONEY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MONEY>>(v1);
    }

    // decompiled from Move bytecode v6
}

