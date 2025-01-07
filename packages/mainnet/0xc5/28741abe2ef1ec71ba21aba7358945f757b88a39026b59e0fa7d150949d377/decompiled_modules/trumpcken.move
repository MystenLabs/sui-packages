module 0xc528741abe2ef1ec71ba21aba7358945f757b88a39026b59e0fa7d150949d377::trumpcken {
    struct TRUMPCKEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMPCKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMPCKEN>(arg0, 6, b"Trumpcken", b"Chicken Trump", b"Chicken man", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/240912_trump_simpsonbs_tease2_apncnt_c3085f36b8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMPCKEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRUMPCKEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

