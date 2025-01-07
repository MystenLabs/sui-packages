module 0x2bd7b783e2ca6aef61bd142622172a88312fe90b36fd1fe99baf59db3f8b0fa3::suigga {
    struct SUIGGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIGGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIGGA>(arg0, 6, b"Suigga", b"suigga", b"The Coldest Nigga on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/asdfasdasf_df321d8705.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIGGA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIGGA>>(v1);
    }

    // decompiled from Move bytecode v6
}

