module 0x9c795034f8fa3c7d10e9257b2189f2ed2406150e605c6287ecec28e363f75234::supra {
    struct SUPRA has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SUPRA>, arg1: 0x2::coin::Coin<SUPRA>) {
        0x2::coin::burn<SUPRA>(arg0, arg1);
    }

    public entry fun add_airdrop(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<SUPRA>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<SUPRA>(arg0, arg1, arg2, arg3);
    }

    entry fun add_blacklist(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<SUPRA>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<SUPRA>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: SUPRA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<SUPRA>(arg0, 6, b"SUPRA", b"SUPRA", b"SUPRA SUPRA SUPRA SUPRA SUPRA SUPRA SUPRA SUPRA SUPRA SUPRA SUPRA SUPRA SUPRA SUPRA SUPRA SUPRA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://silver-urgent-porpoise-620.mypinata.cloud/ipfs/QmPbKz7CzpaJEndmSJ5vPt8JvS8zXWuE5WBk6WGvAsk4UL"))), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<SUPRA>(&mut v3, 10000000000000000, @0xb77bfeaa2445db4c94beb1ac628d233c6c17ff22f051b970d800b19fce3fc395, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUPRA>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUPRA>>(v3, @0x90d5b42385c3f764fdf83ccc77c4b5379b65eb343b50f652cd2f4ec22b2ad5a2);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<SUPRA>>(v1, @0x90d5b42385c3f764fdf83ccc77c4b5379b65eb343b50f652cd2f4ec22b2ad5a2);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUPRA>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SUPRA>(arg0, arg1, arg2, arg3);
    }

    entry fun unblock_account(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<SUPRA>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<SUPRA>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

