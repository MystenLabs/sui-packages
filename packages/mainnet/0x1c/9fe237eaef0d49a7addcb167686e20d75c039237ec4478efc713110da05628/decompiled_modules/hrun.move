module 0x1c9fe237eaef0d49a7addcb167686e20d75c039237ec4478efc713110da05628::hrun {
    struct HRUN has drop {
        dummy_field: bool,
    }

    fun init(arg0: HRUN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HRUN>(arg0, 6, b"Hrun", b"Hrun Family", b"Hrun Family ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000020205_63539fb0bc.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HRUN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HRUN>>(v1);
    }

    // decompiled from Move bytecode v6
}

