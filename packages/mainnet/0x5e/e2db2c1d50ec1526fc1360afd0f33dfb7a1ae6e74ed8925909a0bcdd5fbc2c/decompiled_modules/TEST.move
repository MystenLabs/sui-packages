module 0x5ee2db2c1d50ec1526fc1360afd0f33dfb7a1ae6e74ed8925909a0bcdd5fbc2c::TEST {
    struct TEST has drop {
        dummy_field: bool,
    }

    fun create_coin(arg0: TEST, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<TEST> {
        let (v0, v1) = 0x2::coin::create_currency<TEST>(arg0, 9, b"TTTT", b"TestToken!", b"xxxx", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.gstatic.com/kpui/social/x_32x32.png")), arg2);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TEST>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<TEST>>(v2);
        0x2::coin::mint<TEST>(&mut v2, arg1, arg2)
    }

    fun init(arg0: TEST, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = create_coin(arg0, 1000000000000000000, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<TEST>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

