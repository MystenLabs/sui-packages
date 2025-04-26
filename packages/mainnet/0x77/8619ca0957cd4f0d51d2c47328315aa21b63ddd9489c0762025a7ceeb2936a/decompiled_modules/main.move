module 0x778619ca0957cd4f0d51d2c47328315aa21b63ddd9489c0762025a7ceeb2936a::main {
    struct Project has store, key {
        id: 0x2::object::UID,
        project_id: vector<u8>,
        title: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        creator: address,
        goal: u64,
        raised: 0x2::balance::Balance<0x2::sui::SUI>,
        deadline: u64,
        active: bool,
        created_at: u64,
    }

    struct Donation has store, key {
        id: 0x2::object::UID,
        project_id: vector<u8>,
        donor: address,
        amount: u64,
        timestamp: u64,
    }

    struct ProjectRegistry has key {
        id: 0x2::object::UID,
        projects: 0x2::table::Table<vector<u8>, address>,
        host: address,
    }

    struct ProjectCreated has copy, drop {
        project_id: vector<u8>,
        creator: address,
        goal: u64,
        deadline: u64,
    }

    public fun create_project(arg0: &mut ProjectRegistry, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: u64, arg6: u64, arg7: 0x2::coin::Coin<0x2::sui::SUI>, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::epoch(arg8);
        assert!(arg6 > v0, 1);
        assert!(arg5 > 0, 2);
        let v1 = arg5 / 100 * 1;
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg7) >= v1, 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg7, v1, arg8), arg0.host);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg7, 0x2::tx_context::sender(arg8));
        let v2 = Project{
            id          : 0x2::object::new(arg8),
            project_id  : arg1,
            title       : 0x1::string::utf8(arg2),
            description : 0x1::string::utf8(arg3),
            image_url   : 0x1::string::utf8(arg4),
            creator     : 0x2::tx_context::sender(arg8),
            goal        : arg5,
            raised      : 0x2::balance::zero<0x2::sui::SUI>(),
            deadline    : arg6,
            active      : true,
            created_at  : v0,
        };
        let v3 = 0x2::object::id<Project>(&v2);
        0x2::table::add<vector<u8>, address>(&mut arg0.projects, arg1, 0x2::object::id_to_address(&v3));
        0x2::transfer::share_object<Project>(v2);
        let v4 = ProjectCreated{
            project_id : arg1,
            creator    : 0x2::tx_context::sender(arg8),
            goal       : arg5,
            deadline   : arg6,
        };
        0x2::event::emit<ProjectCreated>(v4);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = ProjectRegistry{
            id       : 0x2::object::new(arg0),
            projects : 0x2::table::new<vector<u8>, address>(arg0),
            host     : 0x2::tx_context::sender(arg0),
        };
        0x2::transfer::share_object<ProjectRegistry>(v0);
    }

    // decompiled from Move bytecode v6
}

