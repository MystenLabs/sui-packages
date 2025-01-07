module 0x571c7ef4fb4285b7df4533d293a307b62d579602abdc75e245adc6352cd2181b::thanos {
    struct THANOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: THANOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<THANOS>(arg0, 6, b"THANOS", b"THANOS ON SUI", b"THANOS RULING THE SUI CHAIN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_design_49_c1887045d7.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<THANOS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<THANOS>>(v1);
    }

    // decompiled from Move bytecode v6
}

