module 0x2424ad003c43dc3de6caee5ff1ab5d11d89de96e8396e13b73a24dc98c305163::smika {
    struct SMIKA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMIKA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMIKA>(arg0, 6, b"SMIKA", b"SMIKASUI", b"Don't take life too seriously, because you'll never get out alive!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Smika_b63819f1c3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMIKA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SMIKA>>(v1);
    }

    // decompiled from Move bytecode v6
}

