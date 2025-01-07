module 0x4283b21929804889215f8aac5b165af90fdd46cb0b8eaef4a48adc91c21e9088::millionaire {
    struct MILLIONAIRE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MILLIONAIRE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MILLIONAIRE>(arg0, 9, b"MILLIONAIRE", b"MILLIONAIRE", b"Official token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.tbstat.com/wp/uploads/2023/10/sui_asset.jpeg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MILLIONAIRE>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MILLIONAIRE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MILLIONAIRE>>(v1);
    }

    // decompiled from Move bytecode v6
}

