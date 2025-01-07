module 0x1e6362d4d1f6fc0cd8dfc3dbf6fc56176567f1eaffe85f1a8664c3ac0fa31ab3::trump {
    struct TRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMP>(arg0, 9, b"TRUMP", b"MAGA", b"MAKE AMERICA GREAT AGAIN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://assets.zyrosite.com/cdn-cgi/image/format=auto,w=134,fit=crop,q=95/A85wke81QwsjLV7N/ed9537fe-54d6-4d7f-811b-bbcfabca54d1-AGB67kojv7t8Nv3E.png"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRUMP>>(v1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TRUMP>(&mut v2, 47000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMP>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

