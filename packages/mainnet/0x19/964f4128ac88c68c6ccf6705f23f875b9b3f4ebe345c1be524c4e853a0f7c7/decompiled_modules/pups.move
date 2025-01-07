module 0x19964f4128ac88c68c6ccf6705f23f875b9b3f4ebe345c1be524c4e853a0f7c7::pups {
    struct PUPS has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUPS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUPS>(arg0, 6, b"PUPS", b"PUPSUI", x"2450555053206973207468652066697273742063756c7475726520636f696e206f6e205355492e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/n_Wldt1_Qq_400x400_f426498abb.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUPS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUPS>>(v1);
    }

    // decompiled from Move bytecode v6
}

