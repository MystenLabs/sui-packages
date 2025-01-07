module 0xa21f100d218cac9a7ed4f9a6e607b1d129ab1667a766bea299549b4d56e59a86::e_ticket {
    struct ETicket has key {
        id: 0x2::object::UID,
        merchant_id: 0x2::object::ID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        thumbnail_url: 0x1::string::String,
        location: 0x1::string::String,
        status: 0x1::string::String,
        start_at: u64,
        end_at: u64,
        number_of_used_ticket: u64,
        dynamic_ticket_collection: 0x2::object::ID,
        creator: address,
    }

    struct ETicketManagement has key {
        id: 0x2::object::UID,
        merchant_id: vector<u8>,
        tracked_created_e_ticket: 0x2::vec_set::VecSet<0x2::object::ID>,
        total_e_ticket_event: u64,
    }

    struct ETicketCreatedEvent has copy, drop {
        id: 0x2::object::ID,
        merchant_id: 0x2::object::ID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        thumbnail_url: 0x1::string::String,
        location: 0x1::string::String,
        status: 0x1::string::String,
        start_at: u64,
        end_at: u64,
        dynamic_ticket_collection: 0x2::object::ID,
        creator: address,
    }

    struct ETicketUpdatedEvent has copy, drop {
        id: 0x2::object::ID,
        merchant_id: 0x2::object::ID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        thumbnail_url: 0x1::string::String,
        location: 0x1::string::String,
        status: 0x1::string::String,
        start_at: u64,
        end_at: u64,
        dynamic_ticket_collection: 0x2::object::ID,
        sender: address,
    }

    struct ETicketPublishedEvent has copy, drop {
        id: 0x2::object::ID,
        merchant_id: 0x2::object::ID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        thumbnail_url: 0x1::string::String,
        location: 0x1::string::String,
        new_status: 0x1::string::String,
        start_at: u64,
        end_at: u64,
        dynamic_ticket_collection: 0x2::object::ID,
        sender: address,
    }

    struct ETicketUnpublishedEvent has copy, drop {
        id: 0x2::object::ID,
        merchant_id: 0x2::object::ID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        thumbnail_url: 0x1::string::String,
        location: 0x1::string::String,
        new_status: 0x1::string::String,
        start_at: u64,
        end_at: u64,
        dynamic_ticket_collection: 0x2::object::ID,
        sender: address,
    }

    struct ETicketDeletedEvent has copy, drop {
        id: 0x2::object::ID,
        merchant_id: 0x2::object::ID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        thumbnail_url: 0x1::string::String,
        location: 0x1::string::String,
        new_status: 0x1::string::String,
        start_at: u64,
        end_at: u64,
        dynamic_ticket_collection: 0x2::object::ID,
        sender: address,
    }

    struct DynamicTicketUsedEvent has copy, drop {
        id: 0x2::object::ID,
        event_id: 0x2::object::ID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        type: u64,
        is_transferable: bool,
        image_url: 0x1::string::String,
        update_image_url: 0x1::string::String,
        used_at: u64,
        status: 0x1::string::String,
        used_by: address,
    }

    public entry fun delete(arg0: ETicket, arg1: &0xa21f100d218cac9a7ed4f9a6e607b1d129ab1667a766bea299549b4d56e59a86::merchant::Merchant, arg2: &0xa21f100d218cac9a7ed4f9a6e607b1d129ab1667a766bea299549b4d56e59a86::merchant::SBT, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        let v0 = 0xa21f100d218cac9a7ed4f9a6e607b1d129ab1667a766bea299549b4d56e59a86::permission::e_ticket_delete();
        0xa21f100d218cac9a7ed4f9a6e607b1d129ab1667a766bea299549b4d56e59a86::merchant::check_merchant_and_permission_sbt(arg1, arg2, &v0, arg3);
        assert!(arg0.status == 0x1::string::utf8(b"draft"), 5000);
        let v1 = ETicketDeletedEvent{
            id                        : 0x2::object::id<ETicket>(&arg0),
            merchant_id               : arg0.merchant_id,
            name                      : arg0.name,
            description               : arg0.description,
            thumbnail_url             : arg0.thumbnail_url,
            location                  : arg0.location,
            new_status                : 0x1::string::utf8(b"deleted"),
            start_at                  : arg0.start_at,
            end_at                    : arg0.end_at,
            dynamic_ticket_collection : arg0.dynamic_ticket_collection,
            sender                    : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<ETicketDeletedEvent>(v1);
        let ETicket {
            id                        : v2,
            merchant_id               : _,
            name                      : _,
            description               : _,
            thumbnail_url             : _,
            location                  : _,
            status                    : _,
            start_at                  : _,
            end_at                    : _,
            number_of_used_ticket     : _,
            dynamic_ticket_collection : _,
            creator                   : _,
        } = arg0;
        0x2::object::delete(v2);
    }

    public fun create_e_ticket(arg0: &mut ETicketManagement, arg1: &mut 0xa21f100d218cac9a7ed4f9a6e607b1d129ab1667a766bea299549b4d56e59a86::merchant::Merchant, arg2: &0xa21f100d218cac9a7ed4f9a6e607b1d129ab1667a766bea299549b4d56e59a86::merchant::SBT, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: u64, arg8: u64, arg9: &0xa21f100d218cac9a7ed4f9a6e607b1d129ab1667a766bea299549b4d56e59a86::nft_management::DynamicNftCollection, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xa21f100d218cac9a7ed4f9a6e607b1d129ab1667a766bea299549b4d56e59a86::permission::e_ticket_create();
        0xa21f100d218cac9a7ed4f9a6e607b1d129ab1667a766bea299549b4d56e59a86::merchant::check_merchant_and_permission_sbt(arg1, arg2, &v0, arg10);
        let v1 = ETicket{
            id                        : 0x2::object::new(arg11),
            merchant_id               : 0x2::object::id<0xa21f100d218cac9a7ed4f9a6e607b1d129ab1667a766bea299549b4d56e59a86::merchant::Merchant>(arg1),
            name                      : arg3,
            description               : arg4,
            thumbnail_url             : arg6,
            location                  : arg5,
            status                    : 0x1::string::utf8(b"draft"),
            start_at                  : arg7,
            end_at                    : arg8,
            number_of_used_ticket     : 0,
            dynamic_ticket_collection : 0x2::object::id<0xa21f100d218cac9a7ed4f9a6e607b1d129ab1667a766bea299549b4d56e59a86::nft_management::DynamicNftCollection>(arg9),
            creator                   : 0x2::tx_context::sender(arg11),
        };
        0x2::vec_set::insert<0x2::object::ID>(&mut arg0.tracked_created_e_ticket, 0x2::object::uid_to_inner(&v1.id));
        arg0.total_e_ticket_event = arg0.total_e_ticket_event + 1;
        0xa21f100d218cac9a7ed4f9a6e607b1d129ab1667a766bea299549b4d56e59a86::merchant::increase_e_ticket_quantity(arg1);
        let v2 = ETicketCreatedEvent{
            id                        : 0x2::object::id<ETicket>(&v1),
            merchant_id               : v1.merchant_id,
            name                      : v1.name,
            description               : v1.description,
            thumbnail_url             : v1.thumbnail_url,
            location                  : arg5,
            status                    : 0x1::string::utf8(b"draft"),
            start_at                  : v1.start_at,
            end_at                    : v1.end_at,
            dynamic_ticket_collection : v1.dynamic_ticket_collection,
            creator                   : 0x2::tx_context::sender(arg11),
        };
        0x2::event::emit<ETicketCreatedEvent>(v2);
        0x2::transfer::share_object<ETicket>(v1);
    }

    public(friend) fun init_e_ticket_management(arg0: vector<u8>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = ETicketManagement{
            id                       : 0x2::object::new(arg1),
            merchant_id              : arg0,
            tracked_created_e_ticket : 0x2::vec_set::empty<0x2::object::ID>(),
            total_e_ticket_event     : 0,
        };
        0x2::transfer::share_object<ETicketManagement>(v0);
        0x2::object::id<ETicketManagement>(&v0)
    }

    public entry fun publish(arg0: &mut ETicket, arg1: &0xa21f100d218cac9a7ed4f9a6e607b1d129ab1667a766bea299549b4d56e59a86::merchant::Merchant, arg2: &0xa21f100d218cac9a7ed4f9a6e607b1d129ab1667a766bea299549b4d56e59a86::merchant::SBT, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        let v0 = 0xa21f100d218cac9a7ed4f9a6e607b1d129ab1667a766bea299549b4d56e59a86::permission::e_ticket_publish();
        0xa21f100d218cac9a7ed4f9a6e607b1d129ab1667a766bea299549b4d56e59a86::merchant::check_merchant_and_permission_sbt(arg1, arg2, &v0, arg3);
        assert!(arg0.status == 0x1::string::utf8(b"draft") || arg0.status == 0x1::string::utf8(b"unpublished"), 5001);
        arg0.status = 0x1::string::utf8(b"published");
        let v1 = ETicketPublishedEvent{
            id                        : 0x2::object::id<ETicket>(arg0),
            merchant_id               : arg0.merchant_id,
            name                      : arg0.name,
            description               : arg0.description,
            thumbnail_url             : arg0.thumbnail_url,
            location                  : arg0.location,
            new_status                : arg0.status,
            start_at                  : arg0.start_at,
            end_at                    : arg0.end_at,
            dynamic_ticket_collection : arg0.dynamic_ticket_collection,
            sender                    : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<ETicketPublishedEvent>(v1);
    }

    public entry fun unpublish(arg0: &mut ETicket, arg1: &0xa21f100d218cac9a7ed4f9a6e607b1d129ab1667a766bea299549b4d56e59a86::merchant::Merchant, arg2: &0xa21f100d218cac9a7ed4f9a6e607b1d129ab1667a766bea299549b4d56e59a86::merchant::SBT, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        let v0 = 0xa21f100d218cac9a7ed4f9a6e607b1d129ab1667a766bea299549b4d56e59a86::permission::e_ticket_unpublish();
        0xa21f100d218cac9a7ed4f9a6e607b1d129ab1667a766bea299549b4d56e59a86::merchant::check_merchant_and_permission_sbt(arg1, arg2, &v0, arg3);
        assert!(arg0.status == 0x1::string::utf8(b"published"), 5002);
        arg0.status = 0x1::string::utf8(b"unpublished");
        let v1 = ETicketUnpublishedEvent{
            id                        : 0x2::object::id<ETicket>(arg0),
            merchant_id               : arg0.merchant_id,
            name                      : arg0.name,
            description               : arg0.description,
            thumbnail_url             : arg0.thumbnail_url,
            location                  : arg0.location,
            new_status                : arg0.status,
            start_at                  : arg0.start_at,
            end_at                    : arg0.end_at,
            dynamic_ticket_collection : arg0.dynamic_ticket_collection,
            sender                    : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<ETicketUnpublishedEvent>(v1);
    }

    public fun update_e_ticket(arg0: &mut ETicket, arg1: &0xa21f100d218cac9a7ed4f9a6e607b1d129ab1667a766bea299549b4d56e59a86::merchant::Merchant, arg2: &0xa21f100d218cac9a7ed4f9a6e607b1d129ab1667a766bea299549b4d56e59a86::merchant::SBT, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: &0xa21f100d218cac9a7ed4f9a6e607b1d129ab1667a766bea299549b4d56e59a86::nft_management::DynamicNftCollection, arg7: 0x1::string::String, arg8: u64, arg9: u64, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xa21f100d218cac9a7ed4f9a6e607b1d129ab1667a766bea299549b4d56e59a86::permission::e_ticket_update();
        0xa21f100d218cac9a7ed4f9a6e607b1d129ab1667a766bea299549b4d56e59a86::merchant::check_merchant_and_permission_sbt(arg1, arg2, &v0, arg10);
        if (arg0.status == 0x1::string::utf8(b"draft")) {
            arg0.dynamic_ticket_collection = 0x2::object::id<0xa21f100d218cac9a7ed4f9a6e607b1d129ab1667a766bea299549b4d56e59a86::nft_management::DynamicNftCollection>(arg6);
            arg0.start_at = arg8;
        };
        arg0.name = arg3;
        arg0.description = arg4;
        arg0.thumbnail_url = arg5;
        arg0.location = arg7;
        arg0.end_at = arg9;
        let v1 = ETicketUpdatedEvent{
            id                        : 0x2::object::uid_to_inner(&arg0.id),
            merchant_id               : 0x2::object::id<0xa21f100d218cac9a7ed4f9a6e607b1d129ab1667a766bea299549b4d56e59a86::merchant::Merchant>(arg1),
            name                      : arg3,
            description               : arg4,
            thumbnail_url             : arg5,
            location                  : arg7,
            status                    : arg0.status,
            start_at                  : arg8,
            end_at                    : arg9,
            dynamic_ticket_collection : arg0.dynamic_ticket_collection,
            sender                    : 0x2::tx_context::sender(arg11),
        };
        0x2::event::emit<ETicketUpdatedEvent>(v1);
    }

    public entry fun use_dynamic_ticket(arg0: &mut ETicket, arg1: &mut 0xa21f100d218cac9a7ed4f9a6e607b1d129ab1667a766bea299549b4d56e59a86::dynamic_nft::DynamicNft, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status == 0x1::string::utf8(b"published"), 5002);
        assert!(0x2::clock::timestamp_ms(arg2) >= arg0.start_at && 0x2::clock::timestamp_ms(arg2) < arg0.end_at, 5003);
        let v0 = arg0.dynamic_ticket_collection;
        assert!(0xa21f100d218cac9a7ed4f9a6e607b1d129ab1667a766bea299549b4d56e59a86::dynamic_nft::get_collection_id(arg1) == &v0, 5004);
        0xa21f100d218cac9a7ed4f9a6e607b1d129ab1667a766bea299549b4d56e59a86::dynamic_nft::use_dynamic_nft(arg1, arg2, arg3);
        arg0.number_of_used_ticket = arg0.number_of_used_ticket + 1;
        let v1 = DynamicTicketUsedEvent{
            id               : 0x2::object::id<0xa21f100d218cac9a7ed4f9a6e607b1d129ab1667a766bea299549b4d56e59a86::dynamic_nft::DynamicNft>(arg1),
            event_id         : 0x2::object::id<ETicket>(arg0),
            name             : 0xa21f100d218cac9a7ed4f9a6e607b1d129ab1667a766bea299549b4d56e59a86::dynamic_nft::get_dynamic_nft_name(arg1),
            description      : 0xa21f100d218cac9a7ed4f9a6e607b1d129ab1667a766bea299549b4d56e59a86::dynamic_nft::get_dynamic_nft_description(arg1),
            type             : 0xa21f100d218cac9a7ed4f9a6e607b1d129ab1667a766bea299549b4d56e59a86::dynamic_nft::get_dynamic_nft_type(arg1),
            is_transferable  : 0xa21f100d218cac9a7ed4f9a6e607b1d129ab1667a766bea299549b4d56e59a86::dynamic_nft::get_dynamic_nft_transferable(arg1),
            image_url        : 0xa21f100d218cac9a7ed4f9a6e607b1d129ab1667a766bea299549b4d56e59a86::dynamic_nft::get_dynamic_nft_image_url(arg1),
            update_image_url : 0xa21f100d218cac9a7ed4f9a6e607b1d129ab1667a766bea299549b4d56e59a86::dynamic_nft::get_dynamic_nft_update_image_url(arg1),
            used_at          : 0x2::clock::timestamp_ms(arg2),
            status           : 0xa21f100d218cac9a7ed4f9a6e607b1d129ab1667a766bea299549b4d56e59a86::dynamic_nft::get_dynamic_nft_status(arg1),
            used_by          : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<DynamicTicketUsedEvent>(v1);
    }

    // decompiled from Move bytecode v6
}

