module 0xc1483c07b9d9e0d4cedfa057745f43ddd982a5b5f8da883085d9ec7fef5d9c0f::aseew {
    struct ASEEW has drop {
        dummy_field: bool,
    }

    fun init(arg0: ASEEW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ASEEW>(arg0, 6, b"ASEEW", b"asd", b"qwerqw", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeidtckui6srwm6v3nbdksb32uryesdg53vajvabscybmyeeteh2a74")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ASEEW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ASEEW>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

