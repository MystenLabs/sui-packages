module 0x48dd4a768969ae9c46c0d97fe40076877e1f7dce0a299eefb5ed1fec8262b2da::access_control {
    struct AccessEntry has copy, drop, store {
        address: address,
        cap_id: 0x2::object::ID,
    }

    struct Registry has key {
        id: 0x2::object::UID,
        owner_address: address,
        owner_cap_id: 0x2::object::ID,
        admins: vector<AccessEntry>,
        reviewers: vector<AccessEntry>,
    }

    struct OwnerCap has store, key {
        id: 0x2::object::UID,
        registry_id: 0x2::object::ID,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
        registry_id: 0x2::object::ID,
    }

    struct ReviewerCap has store, key {
        id: 0x2::object::UID,
        registry_id: 0x2::object::ID,
    }

    public fun add_admin(arg0: &OwnerCap, arg1: &mut Registry, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert_owner_authority(arg0, arg1, 0x2::tx_context::sender(arg3));
        assert!(!contains_address(&arg1.admins, arg2), 5);
        let v0 = 0x2::object::new(arg3);
        let v1 = AccessEntry{
            address : arg2,
            cap_id  : 0x2::object::uid_to_inner(&v0),
        };
        0x1::vector::push_back<AccessEntry>(&mut arg1.admins, v1);
        let v2 = AdminCap{
            id          : v0,
            registry_id : 0x2::object::id<Registry>(arg1),
        };
        0x2::transfer::public_transfer<AdminCap>(v2, arg2);
    }

    public fun add_reviewer_by_owner(arg0: &OwnerCap, arg1: &mut Registry, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert_owner_authority(arg0, arg1, 0x2::tx_context::sender(arg3));
        add_reviewer_entry(arg1, arg2, arg3);
    }

    fun add_reviewer_entry(arg0: &mut Registry, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(!contains_address(&arg0.reviewers, arg1), 6);
        let v0 = 0x2::object::new(arg2);
        let v1 = AccessEntry{
            address : arg1,
            cap_id  : 0x2::object::uid_to_inner(&v0),
        };
        0x1::vector::push_back<AccessEntry>(&mut arg0.reviewers, v1);
        let v2 = ReviewerCap{
            id          : v0,
            registry_id : 0x2::object::id<Registry>(arg0),
        };
        0x2::transfer::public_transfer<ReviewerCap>(v2, arg1);
    }

    public fun admin_registry_id(arg0: &AdminCap) : 0x2::object::ID {
        arg0.registry_id
    }

    fun assert_admin_authority(arg0: &AdminCap, arg1: &Registry, arg2: address) {
        assert!(arg0.registry_id == 0x2::object::id<Registry>(arg1), 2);
        assert!(contains_entry(&arg1.admins, arg2, 0x2::object::id<AdminCap>(arg0)), 4);
    }

    fun assert_owner_authority(arg0: &OwnerCap, arg1: &Registry, arg2: address) {
        assert!(arg0.registry_id == 0x2::object::id<Registry>(arg1), 1);
        assert!(arg1.owner_address == arg2 && arg1.owner_cap_id == 0x2::object::id<OwnerCap>(arg0), 3);
    }

    fun contains_address(arg0: &vector<AccessEntry>, arg1: address) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<AccessEntry>(arg0)) {
            if (0x1::vector::borrow<AccessEntry>(arg0, v0).address == arg1) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    fun contains_entry(arg0: &vector<AccessEntry>, arg1: address, arg2: 0x2::object::ID) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<AccessEntry>(arg0)) {
            let v1 = 0x1::vector::borrow<AccessEntry>(arg0, v0);
            if (v1.address == arg1 && v1.cap_id == arg2) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = 0x2::object::new(arg0);
        let v2 = 0x2::object::new(arg0);
        let v3 = Registry{
            id            : v1,
            owner_address : v0,
            owner_cap_id  : 0x2::object::uid_to_inner(&v2),
            admins        : 0x1::vector::empty<AccessEntry>(),
            reviewers     : 0x1::vector::empty<AccessEntry>(),
        };
        0x2::transfer::share_object<Registry>(v3);
        let v4 = OwnerCap{
            id          : v2,
            registry_id : 0x2::object::uid_to_inner(&v1),
        };
        0x2::transfer::public_transfer<OwnerCap>(v4, v0);
    }

    public fun is_admin(arg0: &Registry, arg1: address, arg2: 0x2::object::ID) : bool {
        contains_entry(&arg0.admins, arg1, arg2)
    }

    public fun is_owner(arg0: &Registry, arg1: address, arg2: 0x2::object::ID) : bool {
        arg0.owner_address == arg1 && arg0.owner_cap_id == arg2
    }

    public fun is_reviewer(arg0: &Registry, arg1: address, arg2: 0x2::object::ID) : bool {
        contains_entry(&arg0.reviewers, arg1, arg2)
    }

    public fun issue_admin_cap(arg0: &OwnerCap, arg1: &mut Registry, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        add_admin(arg0, arg1, arg2, arg3);
    }

    public fun issue_admin_cap_to_sender(arg0: &OwnerCap, arg1: &mut Registry, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        issue_admin_cap(arg0, arg1, v0, arg2);
    }

    public fun issue_reviewer_cap(arg0: &AdminCap, arg1: &mut Registry, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert_admin_authority(arg0, arg1, 0x2::tx_context::sender(arg3));
        add_reviewer_entry(arg1, arg2, arg3);
    }

    public fun issue_reviewer_cap_to_sender(arg0: &AdminCap, arg1: &mut Registry, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        issue_reviewer_cap(arg0, arg1, v0, arg2);
    }

    public fun owner_registry_id(arg0: &OwnerCap) : 0x2::object::ID {
        arg0.registry_id
    }

    public fun remove_admin(arg0: &OwnerCap, arg1: &mut Registry, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert_owner_authority(arg0, arg1, 0x2::tx_context::sender(arg3));
        let v0 = &mut arg1.admins;
        remove_entry_by_address(v0, arg2, 7);
    }

    fun remove_entry_by_address(arg0: &mut vector<AccessEntry>, arg1: address, arg2: u64) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<AccessEntry>(arg0)) {
            if (0x1::vector::borrow<AccessEntry>(arg0, v0).address == arg1) {
                0x1::vector::swap_remove<AccessEntry>(arg0, v0);
                return
            };
            v0 = v0 + 1;
        };
        abort arg2
    }

    public fun remove_reviewer(arg0: &AdminCap, arg1: &mut Registry, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert_admin_authority(arg0, arg1, 0x2::tx_context::sender(arg3));
        let v0 = &mut arg1.reviewers;
        remove_entry_by_address(v0, arg2, 8);
    }

    public fun remove_reviewer_by_owner(arg0: &OwnerCap, arg1: &mut Registry, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert_owner_authority(arg0, arg1, 0x2::tx_context::sender(arg3));
        let v0 = &mut arg1.reviewers;
        remove_entry_by_address(v0, arg2, 8);
    }

    public fun reviewer_registry_id(arg0: &ReviewerCap) : 0x2::object::ID {
        arg0.registry_id
    }

    public fun stats(arg0: &Registry) : (u64, u64, u64) {
        (1, 0x1::vector::length<AccessEntry>(&arg0.admins), 0x1::vector::length<AccessEntry>(&arg0.reviewers))
    }

    // decompiled from Move bytecode v7
}

