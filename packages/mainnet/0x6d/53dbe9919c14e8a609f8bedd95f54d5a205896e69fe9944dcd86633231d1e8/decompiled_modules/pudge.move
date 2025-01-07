module 0x6d53dbe9919c14e8a609f8bedd95f54d5a205896e69fe9944dcd86633231d1e8::pudge {
    struct PUDGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUDGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUDGE>(arg0, 6, b"PUDGE", b"SUIPUDGE", b"Iconic vacation pug of PugLife", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/vx_ci_X_Gq_400x400_2b831004f7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUDGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUDGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

