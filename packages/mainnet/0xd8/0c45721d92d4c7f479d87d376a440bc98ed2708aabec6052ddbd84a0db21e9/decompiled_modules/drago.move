module 0xd80c45721d92d4c7f479d87d376a440bc98ed2708aabec6052ddbd84a0db21e9::drago {
    struct DRAGO has drop {
        dummy_field: bool,
    }

    fun init(arg0: DRAGO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DRAGO>(arg0, 9, b"DRAGO", b"DRAGO", b"DRAGO 123", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdns-images.dzcdn.net/images/talk/7269c30dd78d2c65d6bf7086b584d4ee/0x1900-000000-80-0-0.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DRAGO>(&mut v2, 1000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DRAGO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DRAGO>>(v1);
    }

    // decompiled from Move bytecode v6
}

