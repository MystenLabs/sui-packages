module 0x7ce01c22160f9f78f7171ef52dd6c903b6977deac5d60d602cb3d2d3eb8a4045::aaaaaa {
    struct AAAAAA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAAAAA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAAAAA>(arg0, 6, b"AAAAAA", b"aaaBeaver", x"49742773206161614265766165722c20626561766572206973206b6e6f776e206d656d652e2041414141414141414141414141414141414141414141414141414141410a0a0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Logo_7abe9db602_f383ce6a17.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAAAAA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AAAAAA>>(v1);
    }

    // decompiled from Move bytecode v6
}

