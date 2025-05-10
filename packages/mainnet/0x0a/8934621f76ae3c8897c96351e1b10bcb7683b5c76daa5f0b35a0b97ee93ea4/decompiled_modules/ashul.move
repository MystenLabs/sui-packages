module 0xa8934621f76ae3c8897c96351e1b10bcb7683b5c76daa5f0b35a0b97ee93ea4::ashul {
    struct ASHUL has drop {
        dummy_field: bool,
    }

    fun init(arg0: ASHUL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ASHUL>(arg0, 9, b"Ashul", b"Ai Shulee", b"Face of legends", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/034372754e38b75bebfb98f597ef9472blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ASHUL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ASHUL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

