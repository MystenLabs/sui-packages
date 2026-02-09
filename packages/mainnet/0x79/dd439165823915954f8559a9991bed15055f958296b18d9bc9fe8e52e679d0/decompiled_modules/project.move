module 0x79dd439165823915954f8559a9991bed15055f958296b18d9bc9fe8e52e679d0::project {
    struct ProjectMetadata has store {
        title: vector<u8>,
        description: vector<u8>,
        category: vector<u8>,
        cover_image_url: vector<u8>,
    }

    struct ProjectFinancial<phantom T0> has store {
        balance: 0x2::balance::Balance<T0>,
        total_received: u64,
    }

    struct ProjectStats has store {
        supporter_count: u64,
        is_active: bool,
        created_at: u64,
    }

    struct Project<phantom T0> has key {
        id: 0x2::object::UID,
        creator: address,
        metadata: ProjectMetadata,
        financial: ProjectFinancial<T0>,
        stats: ProjectStats,
    }

    struct ProjectCap has store, key {
        id: 0x2::object::UID,
        project_id: 0x2::object::ID,
    }

    struct ProjectUpdate has drop, store {
        title: vector<u8>,
        content: vector<u8>,
        timestamp: u64,
        author: address,
    }

    struct ProjectCreatedEvent has copy, drop {
        project_id: 0x2::object::ID,
        creator: address,
        title: vector<u8>,
        category: vector<u8>,
        timestamp: u64,
    }

    struct DonationReceivedEvent has copy, drop {
        project_id: 0x2::object::ID,
        donor: address,
        amount: u64,
        timestamp: u64,
    }

    struct UpdatePostedEvent has copy, drop {
        project_id: 0x2::object::ID,
        update_id: vector<u8>,
        title: vector<u8>,
        author: address,
        timestamp: u64,
    }

    struct FundsWithdrawnEvent has copy, drop {
        project_id: 0x2::object::ID,
        amount: u64,
        recipient: address,
        timestamp: u64,
    }

    public fun create_project<T0>(arg0: &mut 0x79dd439165823915954f8559a9991bed15055f958296b18d9bc9fe8e52e679d0::platform::DonationPlatform, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg5);
        let v1 = 0x2::object::uid_to_inner(&v0);
        let v2 = 0x2::tx_context::sender(arg5);
        let v3 = 0x2::tx_context::epoch_timestamp_ms(arg5);
        let v4 = ProjectMetadata{
            title           : arg1,
            description     : arg2,
            category        : arg3,
            cover_image_url : arg4,
        };
        let v5 = ProjectFinancial<T0>{
            balance        : 0x2::balance::zero<T0>(),
            total_received : 0,
        };
        let v6 = ProjectStats{
            supporter_count : 0,
            is_active       : true,
            created_at      : v3,
        };
        let v7 = Project<T0>{
            id        : v0,
            creator   : v2,
            metadata  : v4,
            financial : v5,
            stats     : v6,
        };
        let v8 = ProjectCap{
            id         : 0x2::object::new(arg5),
            project_id : v1,
        };
        0x79dd439165823915954f8559a9991bed15055f958296b18d9bc9fe8e52e679d0::platform::increment_project_count(arg0);
        let v9 = ProjectCreatedEvent{
            project_id : v1,
            creator    : v2,
            title      : v7.metadata.title,
            category   : v7.metadata.category,
            timestamp  : v3,
        };
        0x2::event::emit<ProjectCreatedEvent>(v9);
        0x2::transfer::share_object<Project<T0>>(v7);
        0x2::transfer::transfer<ProjectCap>(v8, v2);
    }

    public fun get_financial_info<T0>(arg0: &Project<T0>) : (u64, u64, u64) {
        (0x2::balance::value<T0>(&arg0.financial.balance), arg0.financial.total_received, arg0.stats.supporter_count)
    }

    public fun get_info<T0>(arg0: &Project<T0>) : (address, &vector<u8>, &vector<u8>, &vector<u8>, &vector<u8>, bool, u64) {
        (arg0.creator, &arg0.metadata.title, &arg0.metadata.description, &arg0.metadata.category, &arg0.metadata.cover_image_url, arg0.stats.is_active, arg0.stats.created_at)
    }

    public fun get_update<T0>(arg0: &Project<T0>, arg1: vector<u8>) : &ProjectUpdate {
        0x2::dynamic_field::borrow<vector<u8>, ProjectUpdate>(&arg0.id, arg1)
    }

    public fun get_update_details(arg0: &ProjectUpdate) : (&vector<u8>, &vector<u8>, u64, address) {
        (&arg0.title, &arg0.content, arg0.timestamp, arg0.author)
    }

    public fun has_update<T0>(arg0: &Project<T0>, arg1: vector<u8>) : bool {
        0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, arg1)
    }

    public fun post_update<T0>(arg0: &ProjectCap, arg1: &mut Project<T0>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.project_id == 0x2::object::id<Project<T0>>(arg1), 0);
        let v0 = 0x2::tx_context::epoch_timestamp_ms(arg5);
        let v1 = 0x2::tx_context::sender(arg5);
        let v2 = ProjectUpdate{
            title     : arg3,
            content   : arg4,
            timestamp : v0,
            author    : v1,
        };
        let v3 = UpdatePostedEvent{
            project_id : 0x2::object::id<Project<T0>>(arg1),
            update_id  : arg2,
            title      : arg3,
            author     : v1,
            timestamp  : v0,
        };
        0x2::event::emit<UpdatePostedEvent>(v3);
        0x2::dynamic_field::add<vector<u8>, ProjectUpdate>(&mut arg1.id, arg2, v2);
    }

    public fun receive_donation<T0>(arg0: &mut Project<T0>, arg1: 0x2::coin::Coin<T0>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg1);
        arg0.financial.total_received = arg0.financial.total_received + v0;
        arg0.stats.supporter_count = arg0.stats.supporter_count + 1;
        0x2::balance::join<T0>(&mut arg0.financial.balance, 0x2::coin::into_balance<T0>(arg1));
        let v1 = DonationReceivedEvent{
            project_id : 0x2::object::id<Project<T0>>(arg0),
            donor      : arg2,
            amount     : v0,
            timestamp  : 0x2::tx_context::epoch_timestamp_ms(arg3),
        };
        0x2::event::emit<DonationReceivedEvent>(v1);
    }

    public fun withdraw_funds<T0>(arg0: &ProjectCap, arg1: &mut Project<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg0.project_id == 0x2::object::id<Project<T0>>(arg1), 0);
        assert!(0x2::balance::value<T0>(&arg1.financial.balance) >= arg2, 1);
        let v0 = FundsWithdrawnEvent{
            project_id : 0x2::object::id<Project<T0>>(arg1),
            amount     : arg2,
            recipient  : 0x2::tx_context::sender(arg3),
            timestamp  : 0x2::tx_context::epoch_timestamp_ms(arg3),
        };
        0x2::event::emit<FundsWithdrawnEvent>(v0);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.financial.balance, arg2), arg3)
    }

    // decompiled from Move bytecode v6
}

