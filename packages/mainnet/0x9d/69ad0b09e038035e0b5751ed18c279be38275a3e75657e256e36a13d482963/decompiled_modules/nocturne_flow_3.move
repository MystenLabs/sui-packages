module 0x9d69ad0b09e038035e0b5751ed18c279be38275a3e75657e256e36a13d482963::nocturne_flow_3 {
    struct NOCTURNE_FLOW_3 has drop {
        dummy_field: bool,
    }

    struct NOCTURNE_FLOW_3SUI has drop, store {
        dummy_field: bool,
    }

    struct WitnessCap has key {
        id: 0x2::object::UID,
        witness: NOCTURNE_FLOW_3SUI,
    }

    fun add_policy(arg0: &0x2::coin::TreasuryCap<NOCTURNE_FLOW_3>, arg1: &0x253ad007a659e538afdf1f077f9d3a086ca0baa44c3cec3ecda110d95e878ca7::factory::CollectionCap, arg2: &mut 0x253ad007a659e538afdf1f077f9d3a086ca0baa44c3cec3ecda110d95e878ca7::hub_token::HubStorage, arg3: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::token::new_policy<NOCTURNE_FLOW_3>(arg0, arg3);
        0x253ad007a659e538afdf1f077f9d3a086ca0baa44c3cec3ecda110d95e878ca7::hub_token::create<NOCTURNE_FLOW_3>(arg1, v1, arg2, arg3);
        0x2::token::share_policy<NOCTURNE_FLOW_3>(v0);
    }

    fun init(arg0: NOCTURNE_FLOW_3, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = NOCTURNE_FLOW_3SUI{dummy_field: false};
        let v1 = WitnessCap{
            id      : 0x2::object::new(arg1),
            witness : v0,
        };
        0x2::transfer::transfer<WitnessCap>(v1, 0x2::tx_context::sender(arg1));
        let (v2, v3) = 0x2::coin::create_currency<NOCTURNE_FLOW_3>(arg0, 9, b"NOCTURNE_FLOW_3SUI", b"nocturne_flow_3", b"Nocturne Flow 3", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://app.nomadcalendar.io/up/activities/685d4ada04769138c9937763_1750944473600.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOCTURNE_FLOW_3>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NOCTURNE_FLOW_3>>(v3);
    }

    entry fun initialize_hub(arg0: WitnessCap, arg1: 0x253ad007a659e538afdf1f077f9d3a086ca0baa44c3cec3ecda110d95e878ca7::factory::CollectionCap, arg2: &0x253ad007a659e538afdf1f077f9d3a086ca0baa44c3cec3ecda110d95e878ca7::collection::PublisherWrapper, arg3: 0x1::option::Option<vector<u8>>, arg4: &mut 0x253ad007a659e538afdf1f077f9d3a086ca0baa44c3cec3ecda110d95e878ca7::referrals::ReferralTable, arg5: &mut 0x253ad007a659e538afdf1f077f9d3a086ca0baa44c3cec3ecda110d95e878ca7::collection_storage::State, arg6: &0x2::coin::TreasuryCap<NOCTURNE_FLOW_3>, arg7: &mut 0x253ad007a659e538afdf1f077f9d3a086ca0baa44c3cec3ecda110d95e878ca7::hub_token::HubStorage, arg8: &mut 0x2::tx_context::TxContext) {
        let WitnessCap {
            id      : v0,
            witness : v1,
        } = arg0;
        0x2::object::delete(v0);
        add_policy(arg6, &arg1, arg7, arg8);
        let v2 = 1 == 1 && false || true;
        let v3 = 3 == 3 && false || true;
        0x253ad007a659e538afdf1f077f9d3a086ca0baa44c3cec3ecda110d95e878ca7::collection::create<NOCTURNE_FLOW_3SUI>(v1, arg1, 2000000, 1000000, v2, v3, 9999, 1785508320, arg2, arg3, arg4, arg5, arg8);
    }

    // decompiled from Move bytecode v6
}

