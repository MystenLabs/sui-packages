module 0xd9e2812939895f88cf2b211760c0588321e25b671c6e19ef09e33bd84e8193a8::ticketsui {
    struct TICKETSUI has drop {
        dummy_field: bool,
    }

    struct TICKETSUISYM has drop, store {
        dummy_field: bool,
    }

    struct WitnessCap has key {
        id: 0x2::object::UID,
        witness: TICKETSUISYM,
    }

    fun add_policy(arg0: &0x2::coin::TreasuryCap<TICKETSUI>, arg1: &0x253ad007a659e538afdf1f077f9d3a086ca0baa44c3cec3ecda110d95e878ca7::factory::CollectionCap, arg2: &mut 0x253ad007a659e538afdf1f077f9d3a086ca0baa44c3cec3ecda110d95e878ca7::hub_token::HubStorage, arg3: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::token::new_policy<TICKETSUI>(arg0, arg3);
        0x253ad007a659e538afdf1f077f9d3a086ca0baa44c3cec3ecda110d95e878ca7::hub_token::create<TICKETSUI>(arg1, v1, arg2, arg3);
        0x2::token::share_policy<TICKETSUI>(v0);
    }

    fun init(arg0: TICKETSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = TICKETSUISYM{dummy_field: false};
        let v1 = WitnessCap{
            id      : 0x2::object::new(arg1),
            witness : v0,
        };
        0x2::transfer::transfer<WitnessCap>(v1, 0x2::tx_context::sender(arg1));
        let (v2, v3) = 0x2::coin::create_currency<TICKETSUI>(arg0, 9, b"TICKETSUISYM", b"ticketsui", b"This is my token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"link to an image")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TICKETSUI>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TICKETSUI>>(v3);
    }

    entry fun initialize_hub(arg0: WitnessCap, arg1: 0x253ad007a659e538afdf1f077f9d3a086ca0baa44c3cec3ecda110d95e878ca7::factory::CollectionCap, arg2: &0x253ad007a659e538afdf1f077f9d3a086ca0baa44c3cec3ecda110d95e878ca7::collection::PublisherWrapper, arg3: 0x1::option::Option<vector<u8>>, arg4: &mut 0x253ad007a659e538afdf1f077f9d3a086ca0baa44c3cec3ecda110d95e878ca7::referrals::ReferralTable, arg5: &mut 0x253ad007a659e538afdf1f077f9d3a086ca0baa44c3cec3ecda110d95e878ca7::collection_storage::State, arg6: &0x2::coin::TreasuryCap<TICKETSUI>, arg7: &mut 0x253ad007a659e538afdf1f077f9d3a086ca0baa44c3cec3ecda110d95e878ca7::hub_token::HubStorage, arg8: &mut 0x2::tx_context::TxContext) {
        let WitnessCap {
            id      : v0,
            witness : v1,
        } = arg0;
        0x2::object::delete(v0);
        add_policy(arg6, &arg1, arg7, arg8);
        let v2 = 1 == 1 && false || true;
        let v3 = 4 == 3 && false || true;
        0x253ad007a659e538afdf1f077f9d3a086ca0baa44c3cec3ecda110d95e878ca7::collection::create<TICKETSUISYM>(v1, arg1, 1000000, 10000, v2, v3, 500, 12312, arg2, arg3, arg4, arg5, arg8);
    }

    // decompiled from Move bytecode v6
}

