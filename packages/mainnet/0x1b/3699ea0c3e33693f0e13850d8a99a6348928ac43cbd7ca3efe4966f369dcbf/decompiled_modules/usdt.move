module 0x1b3699ea0c3e33693f0e13850d8a99a6348928ac43cbd7ca3efe4966f369dcbf::usdt {
    struct USDT has drop {
        dummy_field: bool,
    }

    fun init(arg0: USDT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<USDT>(arg0, 9, b"USDT", b"USDT", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://arweave.net/S6Di6H8kNrHu8ifkN_zk5fRsHVCl38JEBlrEwK1jebM")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<USDT>(&mut v2, 900000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USDT>>(v2, @0xcec14f8c96a9a420f956761c22a608249778840bb859df3da3b277a9832a9665);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<USDT>>(v1);
    }

    // decompiled from Move bytecode v6
}

