module 0xa455afda57a6949224fb8e1f7a0e6dab6ba76cec5517596eb45ed3a45333ec9b::monkey {
    struct MONKEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: MONKEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MONKEY>(arg0, 6, b"MONKEY", b"DANCE MONKEY SUI", x"4a7573742061206d6f6e6b65792064616e63696e67206f6e20746865206d6f6f6e2e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/k_NDL_6xe_IUU_3i_S9_SO_84c9c9b9ac.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MONKEY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MONKEY>>(v1);
    }

    // decompiled from Move bytecode v6
}

