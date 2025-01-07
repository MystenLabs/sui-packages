module 0x1e00e7c4125a158d630f74af5e6b5230b094d057af399606c9056168078510e1::notdog {
    struct NOTDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOTDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOTDOG>(arg0, 6, b"NOTDOG", b"NOTDOG ON SUI", b"NOTDOG ON SUI ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/107f_YZ_9o_400x400_77a719ebe1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOTDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NOTDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

