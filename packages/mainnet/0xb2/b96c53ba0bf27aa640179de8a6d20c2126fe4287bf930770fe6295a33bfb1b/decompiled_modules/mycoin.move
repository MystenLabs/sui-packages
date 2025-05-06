module 0xb2b96c53ba0bf27aa640179de8a6d20c2126fe4287bf930770fe6295a33bfb1b::mycoin {
    struct MYCOIN has drop {
        dummy_field: bool,
    }

    struct DenyCapStore has store, key {
        id: 0x2::object::UID,
    }

    fun init(arg0: MYCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<MYCOIN>(arg0, 9, b"MYCOIN4", b"My Coin4", b"something", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://orange-upper-booby-780.mypinata.cloud/ipfs/QmWnmvQQ9cfrXYErZngyC4tQBiJ1TPVFgTDpf3my3cAJRf"))), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<MYCOIN>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        let v4 = DenyCapStore{id: 0x2::object::new(arg1)};
        0x2::dynamic_object_field::add<vector<u8>, 0x2::coin::DenyCapV2<MYCOIN>>(&mut v4.id, b"deny_cap", v1);
        0x2::transfer::public_transfer<DenyCapStore>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MYCOIN>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<MYCOIN>>(v3);
    }

    // decompiled from Move bytecode v6
}

