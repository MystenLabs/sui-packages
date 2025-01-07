module 0x1077c9a80ff41210358f7016d11eb3010c5e52f8db4abdfc5aee4e9f45401f8e::jewdio {
    struct JEWDIO has drop {
        dummy_field: bool,
    }

    fun init(arg0: JEWDIO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JEWDIO>(arg0, 6, b"JEWDIO", b"JEWTARDIO", b"Jewtardio World ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Tyt1_X_Ik_J_400x400_63aff2695a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JEWDIO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JEWDIO>>(v1);
    }

    // decompiled from Move bytecode v6
}

