module 0xb3ef15ea58762218966677df1004c0180b67cbfbb166faacfeb01214f0a1391d::tett {
    struct TETT has drop {
        dummy_field: bool,
    }

    fun init(arg0: TETT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TETT>(arg0, 6, b"TETT", b"Test token", b"Test token!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://public-cdn.daossui.io/assets/tokens/e638ec40-d961-11ef-a74b-b3b817eed47e")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TETT>>(v1);
        0x2::coin::mint_and_transfer<TETT>(&mut v2, 1100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TETT>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

