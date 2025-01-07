module 0x9b892e39208caab6eb601b55f488b0efc27c87e7ee68e5658a86bee30d00c052::nectar {
    struct NECTAR has drop {
        dummy_field: bool,
    }

    struct TreasuryCapHolder has key {
        id: 0x2::object::UID,
        treasury_cap: 0x2::coin::TreasuryCap<NECTAR>,
    }

    public entry fun transfer(arg0: 0x2::coin::Coin<NECTAR>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<NECTAR>>(arg0, arg1);
    }

    public entry fun extract_treasury_cap(arg0: TreasuryCapHolder) {
        let TreasuryCapHolder {
            id           : v0,
            treasury_cap : v1,
        } = arg0;
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NECTAR>>(v1, @0xea1de0ee7b462b6b050e22bd09567b46d016fc6726ee975138e0732298568a24);
        0x2::object::delete(v0);
    }

    fun init(arg0: NECTAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NECTAR>(arg0, 8, b"NECTAR", b"Nectar", b"Nectar tokens are sent by one Wild Channel to another", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/QmTL8RDUd5LLCPTany4mWscJkMsqhdbJmPk4xwQvJ2rhUb"))), arg1);
        let v2 = TreasuryCapHolder{
            id           : 0x2::object::new(arg1),
            treasury_cap : v0,
        };
        0x2::coin::mint_and_transfer<NECTAR>(&mut v2.treasury_cap, 12000000000000000000, @0x1620bc616589bd3c5630acb77a7276db1c87ce26deef920aabb3cfd6c2225add, arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<NECTAR>>(v1, @0xea1de0ee7b462b6b050e22bd09567b46d016fc6726ee975138e0732298568a24);
        0x2::transfer::transfer<TreasuryCapHolder>(v2, @0xea1de0ee7b462b6b050e22bd09567b46d016fc6726ee975138e0732298568a24);
    }

    public entry fun transfer_metadata(arg0: 0x2::coin::CoinMetadata<NECTAR>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<NECTAR>>(arg0, arg1);
    }

    public entry fun transfer_treasury_cap(arg0: TreasuryCapHolder, arg1: address) {
        0x2::transfer::transfer<TreasuryCapHolder>(arg0, arg1);
    }

    public entry fun transfer_treasury_cap_raw(arg0: 0x2::coin::TreasuryCap<NECTAR>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NECTAR>>(arg0, arg1);
    }

    public entry fun update_coin_description(arg0: &0x2::coin::TreasuryCap<NECTAR>, arg1: &mut 0x2::coin::CoinMetadata<NECTAR>, arg2: 0x1::string::String) {
        0x2::coin::update_description<NECTAR>(arg0, arg1, arg2);
    }

    public entry fun update_coin_name(arg0: &0x2::coin::TreasuryCap<NECTAR>, arg1: &mut 0x2::coin::CoinMetadata<NECTAR>, arg2: 0x1::string::String) {
        0x2::coin::update_name<NECTAR>(arg0, arg1, arg2);
    }

    public entry fun update_coin_symbol(arg0: &0x2::coin::TreasuryCap<NECTAR>, arg1: &mut 0x2::coin::CoinMetadata<NECTAR>, arg2: 0x1::ascii::String) {
        0x2::coin::update_symbol<NECTAR>(arg0, arg1, arg2);
    }

    public entry fun update_coin_url(arg0: &0x2::coin::TreasuryCap<NECTAR>, arg1: &mut 0x2::coin::CoinMetadata<NECTAR>, arg2: 0x1::ascii::String) {
        0x2::coin::update_icon_url<NECTAR>(arg0, arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

