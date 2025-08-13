module 0x153fb3234809434d458470d8c05a6b34135355f8daec5e9d057285611ac3aa75::b_susd {
    struct B_SUSD has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_SUSD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_SUSD>(arg0, 9, b"bSUSD", b"bToken SUSD", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_SUSD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_SUSD>>(v1);
    }

    // decompiled from Move bytecode v6
}

