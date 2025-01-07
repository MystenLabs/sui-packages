module 0xf3c576062a0c833ab907166052c87ca12bf165778ac33f18b06a11f815efe377::trex {
    struct TREX has drop {
        dummy_field: bool,
    }

    fun init(arg0: TREX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TREX>(arg0, 6, b"TREX", b"SUIDINO", b"eating all the fish from the pond of SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/9363ebc5e8fad43049a09b57b77022fe_d642824d1d.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TREX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TREX>>(v1);
    }

    // decompiled from Move bytecode v6
}

