module 0xa8b53dc598969a4b808894da4853674704e9478618bf5a09283550293e0cef50::fckbots {
    struct FCKBOTS has drop {
        dummy_field: bool,
    }

    fun init(arg0: FCKBOTS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FCKBOTS>(arg0, 6, b"FCKBOTS", b"Fuck Bots", b"Dont let bots suin!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/3e64acbae62c12d389aff7d91a667dd9_2_901f041a9a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FCKBOTS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FCKBOTS>>(v1);
    }

    // decompiled from Move bytecode v6
}

