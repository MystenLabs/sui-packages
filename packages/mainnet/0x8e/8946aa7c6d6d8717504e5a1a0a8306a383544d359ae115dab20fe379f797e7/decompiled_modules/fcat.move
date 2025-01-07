module 0x8e8946aa7c6d6d8717504e5a1a0a8306a383544d359ae115dab20fe379f797e7::fcat {
    struct FCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: FCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FCAT>(arg0, 6, b"FCat", b"FishCat", b"Fish Cat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731000796137.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FCAT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FCAT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

