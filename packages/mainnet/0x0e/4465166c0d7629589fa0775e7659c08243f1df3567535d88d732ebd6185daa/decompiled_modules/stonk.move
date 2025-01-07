module 0xe4465166c0d7629589fa0775e7659c08243f1df3567535d88d732ebd6185daa::stonk {
    struct STONK has drop {
        dummy_field: bool,
    }

    fun init(arg0: STONK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STONK>(arg0, 9, b"STONK", b"STONKS DAO", b"buy STONK$$$$$$$$", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://s2.coinmarketcap.com/static/img/coins/64x64/24651.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<STONK>(&mut v2, 9999999999000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STONK>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STONK>>(v1);
    }

    // decompiled from Move bytecode v6
}

