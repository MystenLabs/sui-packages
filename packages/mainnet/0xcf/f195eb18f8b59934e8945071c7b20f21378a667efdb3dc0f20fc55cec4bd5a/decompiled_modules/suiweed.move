module 0xcff195eb18f8b59934e8945071c7b20f21378a667efdb3dc0f20fc55cec4bd5a::suiweed {
    struct SUIWEED has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIWEED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIWEED>(arg0, 6, b"suiweed", b"Suiweed", b"Suiweed Is The first sea plants on sui network !! Join community Telegram : t.me/Suiweed Twitter : x.com/SuiWeedCoin Website : https://suiweed.fun/", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIWEED>(&mut v2, 690420000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIWEED>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIWEED>>(v1);
    }

    // decompiled from Move bytecode v6
}

