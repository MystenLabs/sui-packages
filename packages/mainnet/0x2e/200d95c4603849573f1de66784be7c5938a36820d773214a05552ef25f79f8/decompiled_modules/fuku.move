module 0x2e200d95c4603849573f1de66784be7c5938a36820d773214a05552ef25f79f8::fuku {
    struct FUKU has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUKU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUKU>(arg0, 6, b"FUKU", b"FUKU", b"FUKU pair launch", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT1EA2MTyQPIYai3iBSj68Tdw-98iriYeaQHQ&s")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<FUKU>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUKU>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FUKU>>(v1);
    }

    // decompiled from Move bytecode v6
}

