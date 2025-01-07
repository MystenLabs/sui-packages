module 0x9abc52ce5eb3081aee26f8e52b35baa17895cf590962413ac6bfddb4d9178c30::tgranny {
    struct TGRANNY has drop {
        dummy_field: bool,
    }

    fun init(arg0: TGRANNY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TGRANNY>(arg0, 9, b"TGRANNY", b"Turbo Granny", b"DANDADAN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TGRANNY>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TGRANNY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TGRANNY>>(v1);
    }

    // decompiled from Move bytecode v6
}

