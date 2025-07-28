module 0x19f2dd2b61235687b0ca09ed0280f212f94dc3a947d85d2e29c9179351641bc5::debtcoin {
    struct DEBTCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEBTCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEBTCOIN>(arg0, 9, b"DEBT", b"DebtCoin", b"Helping chip away at the US national debt. Built on community, driven by purpose. $DEBT | Website: https://debtcoin.cash/ | Twitter: https://x.com/DebtCoinBonk | Created on: https://bonk.fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihcmho3e7yxzehcfa4onpjccnrny3tneujkehelihgzghxnbobnr4")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DEBTCOIN>(&mut v2, 1000000000000000000, @0xfa3e6c5e61bf55f576b6500503c1a4d8f64756c44acc510e42e86ad1d1bcc406, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEBTCOIN>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DEBTCOIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

