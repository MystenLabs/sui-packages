module 0x5833ec9f4550c8cfb64914fb667185bfb4978b2dff000db011757f5699076577::usbn {
    struct USBN has drop {
        dummy_field: bool,
    }

    fun init(arg0: USBN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<USBN>(arg0, 9, b"USBN", b"USBN", b"Binance USD (BUSD) is a U.S. dollar-backed stabilized asset issued and hosted by Paxos Trust Company and regulated by the New York State Department of Financial Services.BUSD is sold directly on Paxos.com at a price of 1:1 and will be listed and traded on Binance.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://hk.tpstatic.net/token/tokenpocket-1617347664664.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<USBN>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USBN>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<USBN>>(v1);
    }

    // decompiled from Move bytecode v6
}

