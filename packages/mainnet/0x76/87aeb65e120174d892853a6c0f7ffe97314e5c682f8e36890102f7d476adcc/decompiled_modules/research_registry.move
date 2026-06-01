module 0x7687aeb65e120174d892853a6c0f7ffe97314e5c682f8e36890102f7d476adcc::research_registry {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct TbiCap has store, key {
        id: 0x2::object::UID,
        org_id: address,
    }

    struct UniCap has store, key {
        id: 0x2::object::UID,
        org_id: address,
    }

    struct Organization has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        is_tbi: bool,
    }

    struct User has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        org_id: address,
        role: 0x1::string::String,
    }

    struct ResearchRecord has store, key {
        id: 0x2::object::UID,
        ipfs_cid: 0x1::string::String,
        author_name: 0x1::string::String,
        research_title: 0x1::string::String,
        org_id: address,
        timestamp_ms: u64,
    }

    struct ResearchRegistered has copy, drop {
        record_id: address,
        ipfs_cid: 0x1::string::String,
        author_name: 0x1::string::String,
        research_title: 0x1::string::String,
        org_id: address,
        timestamp_ms: u64,
    }

    struct OrganizationCreated has copy, drop {
        org_id: address,
        name: 0x1::string::String,
        is_tbi: bool,
    }

    entry fun create_organization(arg0: &AdminCap, arg1: 0x1::string::String, arg2: bool, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg4);
        let v1 = 0x2::object::uid_to_address(&v0);
        let v2 = Organization{
            id     : v0,
            name   : arg1,
            is_tbi : arg2,
        };
        if (arg2) {
            let v3 = TbiCap{
                id     : 0x2::object::new(arg4),
                org_id : v1,
            };
            0x2::transfer::transfer<TbiCap>(v3, arg3);
        } else {
            let v4 = UniCap{
                id     : 0x2::object::new(arg4),
                org_id : v1,
            };
            0x2::transfer::transfer<UniCap>(v4, arg3);
        };
        let v5 = OrganizationCreated{
            org_id : v1,
            name   : arg1,
            is_tbi : arg2,
        };
        0x2::event::emit<OrganizationCreated>(v5);
        0x2::transfer::share_object<Organization>(v2);
    }

    entry fun create_user_profile(arg0: 0x1::string::String, arg1: address, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = User{
            id     : 0x2::object::new(arg3),
            name   : arg0,
            org_id : arg1,
            role   : arg2,
        };
        0x2::transfer::transfer<User>(v0, 0x2::tx_context::sender(arg3));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    entry fun mint_research_for_incubatee(arg0: &TbiCap, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: address, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg5);
        let v1 = ResearchRecord{
            id             : 0x2::object::new(arg6),
            ipfs_cid       : arg1,
            author_name    : arg2,
            research_title : arg3,
            org_id         : arg0.org_id,
            timestamp_ms   : v0,
        };
        let v2 = ResearchRegistered{
            record_id      : 0x2::object::uid_to_address(&v1.id),
            ipfs_cid       : v1.ipfs_cid,
            author_name    : v1.author_name,
            research_title : v1.research_title,
            org_id         : arg0.org_id,
            timestamp_ms   : v0,
        };
        0x2::event::emit<ResearchRegistered>(v2);
        0x2::transfer::transfer<ResearchRecord>(v1, arg4);
    }

    entry fun mint_research_for_student(arg0: &UniCap, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: address, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg5);
        let v1 = ResearchRecord{
            id             : 0x2::object::new(arg6),
            ipfs_cid       : arg1,
            author_name    : arg2,
            research_title : arg3,
            org_id         : arg0.org_id,
            timestamp_ms   : v0,
        };
        let v2 = ResearchRegistered{
            record_id      : 0x2::object::uid_to_address(&v1.id),
            ipfs_cid       : v1.ipfs_cid,
            author_name    : v1.author_name,
            research_title : v1.research_title,
            org_id         : arg0.org_id,
            timestamp_ms   : v0,
        };
        0x2::event::emit<ResearchRegistered>(v2);
        0x2::transfer::transfer<ResearchRecord>(v1, arg4);
    }

    // decompiled from Move bytecode v7
}

