module 0x65fed65f89fd943bcff0a9826b4834dfd22c720b5b91440a022bc94af3f5cb1e::satoshi {
    struct SATOSHI has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SATOSHI>, arg1: 0x2::coin::Coin<SATOSHI>) {
        0x2::coin::burn<SATOSHI>(arg0, arg1);
    }

    public entry fun add_airdrop(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<SATOSHI>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<SATOSHI>(arg0, arg1, arg2, arg3);
    }

    entry fun add_blacklist(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<SATOSHI>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<SATOSHI>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: SATOSHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<SATOSHI>(arg0, 6, b"Satoshi", b"LEN SASSAMAN", b"Len Sassaman is the real Satoshi, the Bitcoin founder", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://silver-urgent-porpoise-620.mypinata.cloud/ipfs/QmPbKz7CzpaJEndmSJ5vPt8JvS8zXWuE5WBk6WGvAsk4UL"))), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<SATOSHI>(&mut v3, 10000000000000000, @0x258a374da7888c66219b7531815a4184092d3b3019cb909b7572b94c69a0fac5, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SATOSHI>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SATOSHI>>(v3, @0xafb6e183d6ec876e8b4693316d01d9f09c2d248eccb355fc70b25a0c9b1a7406);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<SATOSHI>>(v1, @0xafb6e183d6ec876e8b4693316d01d9f09c2d248eccb355fc70b25a0c9b1a7406);
    }

    entry fun unblock_account(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<SATOSHI>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<SATOSHI>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

