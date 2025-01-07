module 0xa45f7f86ae5083778c9b6a96b907c0254ed2580304c2c3e71e337b7ffb0ddae0::mcbrett {
    struct MCBRETT has drop {
        dummy_field: bool,
    }

    fun init(arg0: MCBRETT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MCBRETT>(arg0, 6, b"MCBRETT", b"McBrett", b"McBrett lost all his life savings and ended up at McSui!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/aa_6f0f04abe2.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MCBRETT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MCBRETT>>(v1);
    }

    // decompiled from Move bytecode v6
}

