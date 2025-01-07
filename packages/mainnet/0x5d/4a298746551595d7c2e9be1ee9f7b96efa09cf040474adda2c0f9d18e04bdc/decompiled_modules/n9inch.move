module 0x5d4a298746551595d7c2e9be1ee9f7b96efa09cf040474adda2c0f9d18e04bdc::n9inch {
    struct N9INCH has drop {
        dummy_field: bool,
    }

    fun init(arg0: N9INCH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<N9INCH>(arg0, 6, b"N9inch", b"9inch", b"The rock hard memecoin now in sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/dick2_4040fe789e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<N9INCH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<N9INCH>>(v1);
    }

    // decompiled from Move bytecode v6
}

