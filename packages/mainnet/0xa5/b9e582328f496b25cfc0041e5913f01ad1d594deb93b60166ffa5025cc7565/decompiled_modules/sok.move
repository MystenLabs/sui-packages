module 0xa5b9e582328f496b25cfc0041e5913f01ad1d594deb93b60166ffa5025cc7565::sok {
    struct SOK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOK>(arg0, 8, b"SOK", b"SuiOk", b"Its's not scam", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS0UR0RTKiJEU145CRmxSA06vsKsJu_NiGtDA&usqp=CAU")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SOK>(&mut v2, 6000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOK>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SOK>>(v1);
    }

    // decompiled from Move bytecode v6
}

