module 0xbdbe4e3300e2a6ba3b077715bd710f346014e13e03d6fcb42f3315f81ba9c280::name {
    struct NAME has drop {
        dummy_field: bool,
    }

    struct SYMBOL10 has drop, store {
        dummy_field: bool,
    }

    struct WitnessCap has key {
        id: 0x2::object::UID,
        witness: SYMBOL10,
    }

    fun add_policy(arg0: &0x2::coin::TreasuryCap<NAME>, arg1: &0xed93ee123cd3a9501c3db7235d65e8ee49b28ed4d4778be4a88181fe9f12021e::factory::CollectionCap, arg2: &mut 0xed93ee123cd3a9501c3db7235d65e8ee49b28ed4d4778be4a88181fe9f12021e::hub_token::HubStorage, arg3: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::token::new_policy<NAME>(arg0, arg3);
        0xed93ee123cd3a9501c3db7235d65e8ee49b28ed4d4778be4a88181fe9f12021e::hub_token::create<NAME>(arg1, v1, arg2, arg3);
        0x2::token::share_policy<NAME>(v0);
    }

    fun init(arg0: NAME, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = SYMBOL10{dummy_field: false};
        let v1 = WitnessCap{
            id      : 0x2::object::new(arg1),
            witness : v0,
        };
        0x2::transfer::transfer<WitnessCap>(v1, 0x2::tx_context::sender(arg1));
        let (v2, v3) = 0x2::coin::create_currency<NAME>(arg0, 9, b"SYMBOL10", b"name", b"This is my token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"link to an image")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NAME>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NAME>>(v3);
    }

    entry fun initialize_hub(arg0: WitnessCap, arg1: 0xed93ee123cd3a9501c3db7235d65e8ee49b28ed4d4778be4a88181fe9f12021e::factory::CollectionCap, arg2: &0xed93ee123cd3a9501c3db7235d65e8ee49b28ed4d4778be4a88181fe9f12021e::collection::PublisherWrapper, arg3: 0x1::option::Option<vector<u8>>, arg4: &mut 0xed93ee123cd3a9501c3db7235d65e8ee49b28ed4d4778be4a88181fe9f12021e::referrals::ReferralTable, arg5: &mut 0xed93ee123cd3a9501c3db7235d65e8ee49b28ed4d4778be4a88181fe9f12021e::collection_storage::State, arg6: &0x2::coin::TreasuryCap<NAME>, arg7: &mut 0xed93ee123cd3a9501c3db7235d65e8ee49b28ed4d4778be4a88181fe9f12021e::hub_token::HubStorage, arg8: &mut 0x2::tx_context::TxContext) {
        let WitnessCap {
            id      : v0,
            witness : v1,
        } = arg0;
        0x2::object::delete(v0);
        add_policy(arg6, &arg1, arg7, arg8);
        let v2 = 1 == 1 && false || true;
        let v3 = 4 == 3 && false || true;
        0xed93ee123cd3a9501c3db7235d65e8ee49b28ed4d4778be4a88181fe9f12021e::collection::create<SYMBOL10>(v1, arg1, 1000000, 10000, v2, v3, 500, 12312, arg2, arg3, arg4, arg5, arg8);
    }

    // decompiled from Move bytecode v6
}

