module 0xa6c69b7312c44baf71e79e04aebcbba19c7c070870c3ba8a0de32d1ca46196f::suichu {
    struct SUICHU has drop {
        dummy_field: bool,
    }

    fun create_currency<T0: drop>(arg0: T0, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::TreasuryCap<T0> {
        let (v0, v1) = 0x2::coin::create_currency<T0>(arg0, 6, b"SUIChu", b"SUIChu", b"SUIT Token showcases", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.ibb.co/gR5ydV3/Screenshot-2024-09-15-172204.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<T0>>(v1);
        v0
    }

    fun init(arg0: SUICHU, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = create_currency<SUICHU>(arg0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICHU>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUICHU>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SUICHU>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

