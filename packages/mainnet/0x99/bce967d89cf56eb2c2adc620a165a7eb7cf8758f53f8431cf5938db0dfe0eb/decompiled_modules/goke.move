module 0x99bce967d89cf56eb2c2adc620a165a7eb7cf8758f53f8431cf5938db0dfe0eb::goke {
    struct GOKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOKE>(arg0, 6, b"GOKE", b"GoKe", b"Community owned 100%. No team wallets. CTO", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a_ae_ae_a_20240914000137_d3e0da15e0.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOKE>>(v1);
    }

    // decompiled from Move bytecode v6
}

