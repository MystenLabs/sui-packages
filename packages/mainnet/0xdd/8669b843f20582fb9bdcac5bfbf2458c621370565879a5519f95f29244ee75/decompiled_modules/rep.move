module 0xdd8669b843f20582fb9bdcac5bfbf2458c621370565879a5519f95f29244ee75::rep {
    struct REP has drop {
        dummy_field: bool,
    }

    fun init(arg0: REP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<REP>(arg0, 6, b"REP", b"GiveRep", b"WE HAVE SUCCESSFULLY FRONTRUNNED THE $REP TOKEN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Ls0j_TR_Pk_400x400_3a53b213ed.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<REP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<REP>>(v1);
    }

    // decompiled from Move bytecode v6
}

