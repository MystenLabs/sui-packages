module 0x4c72c155fcc91d61db5ea109566999b16369a3fe891a906dab70658b12bd757c::rep_usd {
    struct REP_USD has drop {
        dummy_field: bool,
    }

    fun init(arg0: REP_USD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<REP_USD>(arg0, 6, b"repUSD", b"GiveRep USD", b"GiveRep's Stable USD token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://giverep.com/images/coins/repUSD.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<REP_USD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<REP_USD>>(v1);
    }

    // decompiled from Move bytecode v6
}

