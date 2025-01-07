module 0x10a7c604108852383662b3f694b167b0f2e48d4343fe4556d2a42d5586a4abc1::kc {
    struct KC has drop {
        dummy_field: bool,
    }

    fun init(arg0: KC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KC>(arg0, 9, b"KC", b"KC", b"KC COIN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<KC>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KC>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KC>>(v1);
    }

    // decompiled from Move bytecode v6
}

