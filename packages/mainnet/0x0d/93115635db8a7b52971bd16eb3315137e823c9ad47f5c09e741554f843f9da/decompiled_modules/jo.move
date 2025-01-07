module 0xd93115635db8a7b52971bd16eb3315137e823c9ad47f5c09e741554f843f9da::jo {
    struct JO has drop {
        dummy_field: bool,
    }

    fun init(arg0: JO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JO>(arg0, 9, b"jo", b"LV", b"jks", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<JO>(&mut v2, 789000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JO>>(v1);
    }

    // decompiled from Move bytecode v6
}

