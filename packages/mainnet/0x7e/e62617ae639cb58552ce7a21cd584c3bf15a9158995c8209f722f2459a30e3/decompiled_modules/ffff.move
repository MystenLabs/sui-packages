module 0x7ee62617ae639cb58552ce7a21cd584c3bf15a9158995c8209f722f2459a30e3::ffff {
    struct FFFF has drop {
        dummy_field: bool,
    }

    fun init(arg0: FFFF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FFFF>(arg0, 6, b"FFFF", b"FuckVirtuoso", x"56697274756f736f206a757374206c61756e63686564206120636f696e20616e64206661726d65642075732061742034306b206d636361700a4c657427732070756d7020746869732073686974206d6f7265207468616e207468652056697274756f736f204661726d6572", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/5154600293466483791_8c393a9577.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FFFF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FFFF>>(v1);
    }

    // decompiled from Move bytecode v6
}

