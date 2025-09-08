module 0xebd5d3164e4a2caa2eb604b2ae81af98b5bbcb189352fb836475d90d9cb137c7::tstr {
    struct TSTR has drop {
        dummy_field: bool,
    }

    fun init(arg0: TSTR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TSTR>(arg0, 9, b"TSTR", b"Token Tester", b"test purpose", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://assets.kraken.com/marketing/web/icons-uni-webp/s_inj.webp")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TSTR>(&mut v2, 21000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TSTR>>(v2, @0xa4dee7e7d6686865508d157f233d3203232efb9744843743704564b718f0dcf4);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TSTR>>(v1);
    }

    // decompiled from Move bytecode v6
}

