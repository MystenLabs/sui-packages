module 0xdf60726841ea124b76f417600ddbc373f9dfb17668eedcb3bcfc57dcc6ee6f3b::mycoin {
    struct MYCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MYCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<MYCOIN>(arg0, 9, b"MYCOIN3", b"My Coin3", b"something", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://orange-upper-booby-780.mypinata.cloud/ipfs/QmWnmvQQ9cfrXYErZngyC4tQBiJ1TPVFgTDpf3my3cAJRf"))), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<MYCOIN>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MYCOIN>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<MYCOIN>>(v3);
        0x2::transfer::public_freeze_object<0x2::coin::DenyCapV2<MYCOIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

