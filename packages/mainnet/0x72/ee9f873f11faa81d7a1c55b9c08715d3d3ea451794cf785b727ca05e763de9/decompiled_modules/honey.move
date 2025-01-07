module 0x72ee9f873f11faa81d7a1c55b9c08715d3d3ea451794cf785b727ca05e763de9::honey {
    struct HONEY has drop {
        dummy_field: bool,
    }

    struct TreasuryCapHolder has key {
        id: 0x2::object::UID,
        treasury_cap: 0x2::coin::TreasuryCap<HONEY>,
    }

    public entry fun transfer(arg0: 0x2::coin::Coin<HONEY>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<HONEY>>(arg0, arg1);
    }

    public entry fun extract_treasury_cap(arg0: TreasuryCapHolder) {
        let TreasuryCapHolder {
            id           : v0,
            treasury_cap : v1,
        } = arg0;
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HONEY>>(v1, @0x1620bc616589bd3c5630acb77a7276db1c87ce26deef920aabb3cfd6c2225add);
        0x2::object::delete(v0);
    }

    fun init(arg0: HONEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HONEY>(arg0, 8, b"HONEY", b"HONEY", b"The more the Nectar the more the Honey", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/Qmae2eQaP3x2Bgi95nfnWnrBoPwUBjnyM1beDnugjiH89p"))), arg1);
        let v2 = TreasuryCapHolder{
            id           : 0x2::object::new(arg1),
            treasury_cap : v0,
        };
        0x2::coin::mint_and_transfer<HONEY>(&mut v2.treasury_cap, 1000000000000000000, @0x1620bc616589bd3c5630acb77a7276db1c87ce26deef920aabb3cfd6c2225add, arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HONEY>>(v1);
        0x2::transfer::transfer<TreasuryCapHolder>(v2, @0x1620bc616589bd3c5630acb77a7276db1c87ce26deef920aabb3cfd6c2225add);
    }

    public entry fun transfer_metadata(arg0: 0x2::coin::CoinMetadata<HONEY>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<HONEY>>(arg0, arg1);
    }

    public entry fun transfer_treasury_cap(arg0: TreasuryCapHolder, arg1: address) {
        0x2::transfer::transfer<TreasuryCapHolder>(arg0, arg1);
    }

    public entry fun transfer_treasury_cap_raw(arg0: 0x2::coin::TreasuryCap<HONEY>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HONEY>>(arg0, arg1);
    }

    public entry fun update_coin_description(arg0: &0x2::coin::TreasuryCap<HONEY>, arg1: &mut 0x2::coin::CoinMetadata<HONEY>, arg2: 0x1::string::String) {
        0x2::coin::update_description<HONEY>(arg0, arg1, arg2);
    }

    public entry fun update_coin_name(arg0: &0x2::coin::TreasuryCap<HONEY>, arg1: &mut 0x2::coin::CoinMetadata<HONEY>, arg2: 0x1::string::String) {
        0x2::coin::update_name<HONEY>(arg0, arg1, arg2);
    }

    public entry fun update_coin_symbol(arg0: &0x2::coin::TreasuryCap<HONEY>, arg1: &mut 0x2::coin::CoinMetadata<HONEY>, arg2: 0x1::ascii::String) {
        0x2::coin::update_symbol<HONEY>(arg0, arg1, arg2);
    }

    public entry fun update_coin_url(arg0: &0x2::coin::TreasuryCap<HONEY>, arg1: &mut 0x2::coin::CoinMetadata<HONEY>, arg2: 0x1::ascii::String) {
        0x2::coin::update_icon_url<HONEY>(arg0, arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

