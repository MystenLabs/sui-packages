module 0xa7bcead986f650524a06ed2cc99e1e0056bb8669644d1981bdcbdfa5c2421e8b::hypeeesui {
    struct HYPEEESUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: HYPEEESUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HYPEEESUI>(arg0, 6, b"HYPEEESUI", b"Piran Hypeee on SUI", x"4120467265616b696e67204e61756768747920506972616e686120696e2074686520537569204f6365616e2e2e2e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DBCS_9_HY_400x400_f6f60091ab.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HYPEEESUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HYPEEESUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

