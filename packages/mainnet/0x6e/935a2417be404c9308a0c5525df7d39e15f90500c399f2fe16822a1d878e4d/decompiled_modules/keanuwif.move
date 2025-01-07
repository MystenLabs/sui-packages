module 0x6e935a2417be404c9308a0c5525df7d39e15f90500c399f2fe16822a1d878e4d::keanuwif {
    struct KEANUWIF has drop {
        dummy_field: bool,
    }

    fun init(arg0: KEANUWIF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KEANUWIF>(arg0, 9, b"KEANUWIF", b"KEANU WIF", b"TRUST ME BRO, IS KEANU WIF", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/b3afd31806611cc1f2cdf117099b6636blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KEANUWIF>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KEANUWIF>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

