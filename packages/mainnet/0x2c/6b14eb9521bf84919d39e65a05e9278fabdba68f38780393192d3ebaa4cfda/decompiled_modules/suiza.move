module 0x2c6b14eb9521bf84919d39e65a05e9278fabdba68f38780393192d3ebaa4cfda::suiza {
    struct SUIZA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIZA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIZA>(arg0, 6, b"SUIZA", b"Suiza", b"SUIZA is an advanced AI agent built to provide real-time data analysis of the $SUI network. It specializes in tracking price, TVL, and ecosystem trends, offering deep insights into $SUIs DeFi protocols. First Citizen of $ATL", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SUIZA_c56e1dffc5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIZA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIZA>>(v1);
    }

    // decompiled from Move bytecode v6
}

