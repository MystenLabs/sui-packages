module 0xa448008ef157a6725ef7ad5b624cde474bb871504b9c207c769a084b11f441b9::fstr {
    struct FSTR has drop {
        dummy_field: bool,
    }

    fun init(arg0: FSTR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FSTR>(arg0, 6, b"FSTR", b"Faster", b"In the world of crypto, everybody wants to go....faster.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000142_df3a1fe9e0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FSTR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FSTR>>(v1);
    }

    // decompiled from Move bytecode v6
}

