module 0x9e658fa64fcea69998b1d8a0df4e20e74cf397cbc588f9b802eda3e4e721689b::olo {
    struct OLO has drop {
        dummy_field: bool,
    }

    fun init(arg0: OLO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OLO>(arg0, 9, b"OLO", b"OLO", b"OLO", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<OLO>(&mut v2, 6666666000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OLO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OLO>>(v1);
    }

    // decompiled from Move bytecode v6
}

