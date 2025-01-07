module 0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_ai_ticket {
    struct COLLECTION_AI_TICKET has drop {
        dummy_field: bool,
    }

    struct CollectionAiTicket has store, key {
        id: 0x2::object::UID,
        owner: address,
        type: u8,
        fulfilled: bool,
    }

    struct CollectionAiTicketPurchased has copy, drop {
        object_id: 0x2::object::ID,
        type: u8,
        price: u64,
        maintainer_balance_change: u64,
        purchaser: address,
    }

    struct CollectionAiTicketFulfilled has copy, drop {
        object_id: 0x2::object::ID,
        type: u8,
    }

    fun create_ai_art_ticket(arg0: u64, arg1: &mut 0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_maintainer::CollectionMaintainer, arg2: &mut 0x2::tx_context::TxContext) : CollectionAiTicket {
        let v0 = 0x2::tx_context::sender(arg2);
        0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_maintainer::increment_ai_art_ticket_count(arg1);
        create_ai_ticket(1, v0, 0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_maintainer::ai_art_ticket_price(arg1), arg0, arg2)
    }

    fun create_ai_ticket(arg0: u8, arg1: address, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : CollectionAiTicket {
        let v0 = CollectionAiTicket{
            id        : 0x2::object::new(arg4),
            owner     : arg1,
            type      : arg0,
            fulfilled : false,
        };
        let v1 = CollectionAiTicketPurchased{
            object_id                 : 0x2::object::id<CollectionAiTicket>(&v0),
            type                      : v0.type,
            price                     : arg2,
            maintainer_balance_change : arg3,
            purchaser                 : arg1,
        };
        0x2::event::emit<CollectionAiTicketPurchased>(v1);
        v0
    }

    fun create_ai_title_ticket(arg0: u64, arg1: &mut 0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_maintainer::CollectionMaintainer, arg2: &mut 0x2::tx_context::TxContext) : CollectionAiTicket {
        let v0 = 0x2::tx_context::sender(arg2);
        0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_maintainer::increment_ai_title_ticket_count(arg1);
        create_ai_ticket(2, v0, 0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_maintainer::ai_title_ticket_price(arg1), arg0, arg2)
    }

    public entry fun fulfill(arg0: &mut CollectionAiTicket, arg1: &0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_maintainer::CollectionAdminCap) {
        assert!(!arg0.fulfilled, 0);
        let v0 = CollectionAiTicketFulfilled{
            object_id : 0x2::object::id<CollectionAiTicket>(arg0),
            type      : arg0.type,
        };
        0x2::event::emit<CollectionAiTicketFulfilled>(v0);
        arg0.fulfilled = true;
    }

    public fun fulfilled(arg0: &CollectionAiTicket) : bool {
        arg0.fulfilled
    }

    fun init(arg0: COLLECTION_AI_TICKET, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        let v2 = 0x2::package::claim<COLLECTION_AI_TICKET>(arg0, arg1);
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"The Collection AI Ticket"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://arweave.net/4wuv64FYFUH2T3l6Fo0F1FeBu3_6qJ705KVzEtUaR-E"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"A ticket to generate an AI image for use in The Collection"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://thecollection.ai"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"The Collection"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://arweave.net/K_N97SKiJU-jv-O4_7MwEwRnuGt5z7rJJp3GKJcRqBs"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"A collection of AI art as selected by the community."));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"Ethos"));
        let v5 = 0x2::display::new_with_fields<CollectionAiTicket>(&v2, v0, v3, arg1);
        0x2::display::update_version<CollectionAiTicket>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<CollectionAiTicket>>(v5, 0x2::tx_context::sender(arg1));
    }

    public fun owner(arg0: &CollectionAiTicket) : address {
        arg0.owner
    }

    public entry fun purchase_art_ticket(arg0: &mut 0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_maintainer::CollectionMaintainer, arg1: vector<0x2::coin::Coin<0x2::sui::SUI>>, arg2: &mut 0x2::tx_context::TxContext) {
        0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_maintainer::assert_maintainer_version_and_paused(arg0);
        let (v0, v1) = 0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_maintainer::pay_for_ai_art_ticket(arg1, arg0, arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v1, 0x2::tx_context::sender(arg2));
        0x2::transfer::share_object<CollectionAiTicket>(create_ai_art_ticket(v0, arg0, arg2));
    }

    public entry fun purchase_art_ticket_with_bundle(arg0: &mut 0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_maintainer::CollectionMaintainer, arg1: &mut 0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_bundle::CollectionBundle, arg2: &mut 0x2::tx_context::TxContext) {
        0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_bundle::assert_valid_purchase(arg1, 1);
        0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_maintainer::assert_maintainer_version_and_paused(arg0);
        let v0 = 0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_maintainer::ticket_units_for_ai_art_ticket(arg0);
        assert!(v0 > 0, 2);
        0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_bundle::decrement(arg1, v0);
        0x2::transfer::share_object<CollectionAiTicket>(create_ai_art_ticket(0, arg0, arg2));
    }

    public entry fun purchase_title_ticket(arg0: &mut 0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_maintainer::CollectionMaintainer, arg1: vector<0x2::coin::Coin<0x2::sui::SUI>>, arg2: &mut 0x2::tx_context::TxContext) {
        0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_maintainer::assert_maintainer_version_and_paused(arg0);
        let (v0, v1) = 0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_maintainer::pay_for_ai_title_ticket(arg1, arg0, arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v1, 0x2::tx_context::sender(arg2));
        0x2::transfer::share_object<CollectionAiTicket>(create_ai_title_ticket(v0, arg0, arg2));
    }

    public entry fun purchase_title_ticket_with_bundle(arg0: &mut 0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_maintainer::CollectionMaintainer, arg1: &mut 0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_bundle::CollectionBundle, arg2: &mut 0x2::tx_context::TxContext) {
        0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_bundle::assert_valid_purchase(arg1, 2);
        0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_maintainer::assert_maintainer_version_and_paused(arg0);
        let v0 = 0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_maintainer::ticket_units_for_ai_title_ticket(arg0);
        assert!(v0 > 0, 2);
        0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_bundle::decrement(arg1, v0);
        0x2::transfer::share_object<CollectionAiTicket>(create_ai_title_ticket(0, arg0, arg2));
    }

    // decompiled from Move bytecode v6
}

