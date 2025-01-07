module 0x49add11259b6a1254836a5d55bc331186469a90c65c6d5f7f717c37e3f75715e::buckz {
    struct BUCKZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUCKZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUCKZ>(arg0, 8, b"BUCKZ", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BUCKZ>(&mut v2, 1000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BUCKZ>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUCKZ>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

