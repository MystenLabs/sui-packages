module 0xf4218e4bed10b50debd21b7f010b54643128052c5ccba3cc8af0e8c965426e93::allowlist {
    struct Allowlist has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        members: vector<Member>,
        access_fee: u64,
        total_members: u64,
        created_at: u64,
        updated_at: u64,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct Member has copy, drop, store {
        address: address,
        added_at: u64,
        expires_at: 0x1::option::Option<u64>,
        added_by: address,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
        allowlist_id: 0x2::object::ID,
    }

    struct AllowlistCreated has copy, drop {
        allowlist_id: 0x2::object::ID,
        name: 0x1::string::String,
        creator: address,
        timestamp: u64,
    }

    struct MemberAdded has copy, drop {
        allowlist_id: 0x2::object::ID,
        member: address,
        added_by: address,
        expires_at: 0x1::option::Option<u64>,
        timestamp: u64,
    }

    struct MemberRemoved has copy, drop {
        allowlist_id: 0x2::object::ID,
        member: address,
        removed_by: address,
        timestamp: u64,
    }

    public fun add_member(arg0: &mut Allowlist, arg1: &AdminCap, arg2: address, arg3: 0x1::option::Option<u64>, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        assert!(arg1.allowlist_id == 0x2::object::id<Allowlist>(arg0), 0);
        assert!(!is_member(arg0, arg2, arg4), 2);
        let v0 = Member{
            address    : arg2,
            added_at   : 0x2::clock::timestamp_ms(arg4),
            expires_at : arg3,
            added_by   : 0x2::tx_context::sender(arg5),
        };
        0x1::vector::push_back<Member>(&mut arg0.members, v0);
        arg0.total_members = arg0.total_members + 1;
        arg0.updated_at = 0x2::clock::timestamp_ms(arg4);
        let v1 = MemberAdded{
            allowlist_id : 0x2::object::id<Allowlist>(arg0),
            member       : arg2,
            added_by     : 0x2::tx_context::sender(arg5),
            expires_at   : arg3,
            timestamp    : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<MemberAdded>(v1);
    }

    public fun add_members_batch(arg0: &mut Allowlist, arg1: &AdminCap, arg2: vector<address>, arg3: 0x1::option::Option<u64>, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        assert!(arg1.allowlist_id == 0x2::object::id<Allowlist>(arg0), 0);
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg2)) {
            let v1 = *0x1::vector::borrow<address>(&arg2, v0);
            if (!is_member(arg0, v1, arg4)) {
                add_member(arg0, arg1, v1, arg3, arg4, arg5);
            };
            v0 = v0 + 1;
        };
    }

    public fun create(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : AdminCap {
        let v0 = 0x2::object::new(arg4);
        let v1 = 0x2::object::uid_to_inner(&v0);
        let v2 = Allowlist{
            id            : v0,
            name          : arg0,
            description   : arg1,
            members       : 0x1::vector::empty<Member>(),
            access_fee    : arg2,
            total_members : 0,
            created_at    : 0x2::clock::timestamp_ms(arg3),
            updated_at    : 0x2::clock::timestamp_ms(arg3),
            balance       : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        let v3 = AllowlistCreated{
            allowlist_id : v1,
            name         : v2.name,
            creator      : 0x2::tx_context::sender(arg4),
            timestamp    : v2.created_at,
        };
        0x2::event::emit<AllowlistCreated>(v3);
        0x2::transfer::share_object<Allowlist>(v2);
        AdminCap{
            id           : 0x2::object::new(arg4),
            allowlist_id : v1,
        }
    }

    entry fun create_allowlist(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = create(arg0, arg1, arg2, arg3, arg4);
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg4));
    }

    public fun get_access_fee(arg0: &Allowlist) : u64 {
        arg0.access_fee
    }

    public fun get_balance(arg0: &Allowlist) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.balance)
    }

    public fun get_description(arg0: &Allowlist) : &0x1::string::String {
        &arg0.description
    }

    public fun get_members(arg0: &Allowlist) : &vector<Member> {
        &arg0.members
    }

    public fun get_name(arg0: &Allowlist) : &0x1::string::String {
        &arg0.name
    }

    public fun get_total_members(arg0: &Allowlist) : u64 {
        arg0.total_members
    }

    public fun is_member(arg0: &Allowlist, arg1: address, arg2: &0x2::clock::Clock) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<Member>(&arg0.members)) {
            let v1 = 0x1::vector::borrow<Member>(&arg0.members, v0);
            if (v1.address == arg1) {
                if (0x1::option::is_some<u64>(&v1.expires_at)) {
                    return 0x2::clock::timestamp_ms(arg2) < *0x1::option::borrow<u64>(&v1.expires_at)
                };
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    fun is_prefix(arg0: vector<u8>, arg1: vector<u8>) : bool {
        if (0x1::vector::length<u8>(&arg0) > 0x1::vector::length<u8>(&arg1)) {
            return false
        };
        let v0 = 0;
        while (v0 < 0x1::vector::length<u8>(&arg0)) {
            if (*0x1::vector::borrow<u8>(&arg0, v0) != *0x1::vector::borrow<u8>(&arg1, v0)) {
                return false
            };
            v0 = v0 + 1;
        };
        true
    }

    entry fun join_with_payment(arg0: &mut Allowlist, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) >= arg0.access_fee, 4);
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(!is_member(arg0, v0, arg2), 2);
        0x2::coin::put<0x2::sui::SUI>(&mut arg0.balance, arg1);
        let v1 = Member{
            address    : v0,
            added_at   : 0x2::clock::timestamp_ms(arg2),
            expires_at : 0x1::option::none<u64>(),
            added_by   : v0,
        };
        0x1::vector::push_back<Member>(&mut arg0.members, v1);
        arg0.total_members = arg0.total_members + 1;
        arg0.updated_at = 0x2::clock::timestamp_ms(arg2);
        let v2 = MemberAdded{
            allowlist_id : 0x2::object::id<Allowlist>(arg0),
            member       : v0,
            added_by     : v0,
            expires_at   : 0x1::option::none<u64>(),
            timestamp    : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<MemberAdded>(v2);
    }

    public fun namespace(arg0: &Allowlist) : vector<u8> {
        0x2::object::uid_to_bytes(&arg0.id)
    }

    public fun publish_content(arg0: &mut Allowlist, arg1: &AdminCap, arg2: 0x1::string::String, arg3: 0x1::string::String) {
        assert!(arg1.allowlist_id == 0x2::object::id<Allowlist>(arg0), 0);
        0x2::dynamic_field::add<0x1::string::String, 0x1::string::String>(&mut arg0.id, arg2, arg3);
    }

    public fun remove_member(arg0: &mut Allowlist, arg1: &AdminCap, arg2: address, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert!(arg1.allowlist_id == 0x2::object::id<Allowlist>(arg0), 0);
        let v0 = 0;
        let v1 = false;
        while (v0 < 0x1::vector::length<Member>(&arg0.members)) {
            if (0x1::vector::borrow<Member>(&arg0.members, v0).address == arg2) {
                0x1::vector::remove<Member>(&mut arg0.members, v0);
                v1 = true;
                break
            };
            v0 = v0 + 1;
        };
        assert!(v1, 3);
        arg0.total_members = arg0.total_members - 1;
        arg0.updated_at = 0x2::clock::timestamp_ms(arg3);
        let v2 = MemberRemoved{
            allowlist_id : 0x2::object::id<Allowlist>(arg0),
            member       : arg2,
            removed_by   : 0x2::tx_context::sender(arg4),
            timestamp    : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<MemberRemoved>(v2);
    }

    entry fun seal_approve(arg0: vector<u8>, arg1: &Allowlist, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(is_prefix(namespace(arg1), arg0), 1);
        assert!(is_member(arg1, 0x2::tx_context::sender(arg3), arg2), 1);
    }

    public fun update_metadata(arg0: &mut Allowlist, arg1: &AdminCap, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u64, arg5: &0x2::clock::Clock) {
        assert!(arg1.allowlist_id == 0x2::object::id<Allowlist>(arg0), 0);
        arg0.name = arg2;
        arg0.description = arg3;
        arg0.access_fee = arg4;
        arg0.updated_at = 0x2::clock::timestamp_ms(arg5);
    }

    public fun withdraw_fees(arg0: &mut Allowlist, arg1: &AdminCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(arg1.allowlist_id == 0x2::object::id<Allowlist>(arg0), 0);
        0x2::coin::take<0x2::sui::SUI>(&mut arg0.balance, arg2, arg3)
    }

    // decompiled from Move bytecode v6
}

