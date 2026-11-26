module 0x5bc5e37a3cf6f4a4372a5d7e60588d5c3dc397421a943b59dd1fe7e8b05a00d9::fags {
    struct FAGS has drop {
        dummy_field: bool,
    }

    fun init(arg0: FAGS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FAGS>(arg0, 9, b"FAGS", b"Mysten Fags", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://viper-terminal.app/api/coin-icon/8a361ddc90f0fce35c361e505a092e1dcb8bdda95f65da9acec0298c3b3651a9.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<FAGS>>(0x2::coin::mint<FAGS>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FAGS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FAGS>>(v2, 0x2::address::from_u256(0));
    }

    // decompiled from Move bytecode v7
}

