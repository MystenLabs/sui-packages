module 0xe35bfaca1fc61f9d47d90772ef5ef8f619124993226328f83769535d334e66a9::tate {
    struct TATE has drop {
        dummy_field: bool,
    }

    fun init(arg0: TATE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TATE>(arg0, 6, b"TATE", b"Tate on SUI", b"Top G is here ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_10_01_at_9_20_23a_AM_ee1cd3bd90.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TATE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TATE>>(v1);
    }

    // decompiled from Move bytecode v6
}

