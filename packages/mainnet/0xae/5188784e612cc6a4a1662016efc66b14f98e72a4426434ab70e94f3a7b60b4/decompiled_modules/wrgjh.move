module 0xae5188784e612cc6a4a1662016efc66b14f98e72a4426434ab70e94f3a7b60b4::wrgjh {
    struct WRGJH has drop {
        dummy_field: bool,
    }

    fun init(arg0: WRGJH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WRGJH>(arg0, 6, b"wrgjh", b"ertgrbnuo", b"erd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<WRGJH>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WRGJH>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WRGJH>>(v1);
    }

    // decompiled from Move bytecode v6
}

