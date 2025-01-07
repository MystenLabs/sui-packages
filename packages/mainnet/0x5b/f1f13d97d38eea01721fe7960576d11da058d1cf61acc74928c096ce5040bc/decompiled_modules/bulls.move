module 0x5bf1f13d97d38eea01721fe7960576d11da058d1cf61acc74928c096ce5040bc::bulls {
    struct BULLS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BULLS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BULLS>(arg0, 6, b"Bulls", b"Battle Bulls ", b"BATTLE BULLS is an exciting play-to-earn battle game! Play, win, and get rewards! https://battlebulls.com/en", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731232833496.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BULLS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BULLS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

