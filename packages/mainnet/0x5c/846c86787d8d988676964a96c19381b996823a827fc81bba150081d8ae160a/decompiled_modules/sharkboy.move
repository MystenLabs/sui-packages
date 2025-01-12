module 0x5c846c86787d8d988676964a96c19381b996823a827fc81bba150081d8ae160a::sharkboy {
    struct SHARKBOY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHARKBOY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHARKBOY>(arg0, 6, b"SHARKBOY", b"SHARK BOY ON SUI", b"Dream, dream, dream, dream, dream, dream...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SHARK_BOY_0ee894c461.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHARKBOY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHARKBOY>>(v1);
    }

    // decompiled from Move bytecode v6
}

