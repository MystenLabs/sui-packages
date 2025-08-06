module 0x20610d4d1f037809b5ea9fd9fd6102fe9a649eb6d0f16903d8b14d5dfc9769c4::admins {
    struct AdminAddedEvent has copy, drop {
        admin: address,
        added_by: address,
        added_at: u64,
    }

    struct AdminRemovedEvent has copy, drop {
        admin: address,
        removed_by: address,
        removed_at: u64,
    }

    struct OwnershipTransferredEvent has copy, drop {
        old_owner: address,
        new_owner: address,
        transferred_at: u64,
    }

    struct Owner has key {
        id: 0x2::object::UID,
        owner: address,
    }

    struct Admins has key {
        id: 0x2::object::UID,
        admins: 0x2::vec_set::VecSet<address>,
    }

    struct ADMINS has drop {
        dummy_field: bool,
    }

    public(friend) entry fun add_admin(arg0: &Owner, arg1: &mut Admins, arg2: address, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert_is_owner(arg0, 0x2::tx_context::sender(arg4));
        assert_is_not_admin(arg1, arg2);
        0x2::vec_set::insert<address>(&mut arg1.admins, arg2);
        let v0 = AdminAddedEvent{
            admin    : arg2,
            added_by : 0x2::tx_context::sender(arg4),
            added_at : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<AdminAddedEvent>(v0);
    }

    public(friend) fun assert_is_admin(arg0: &Admins, arg1: address) {
        assert!(is_admin(arg0, arg1), 1);
    }

    public(friend) fun assert_is_not_admin(arg0: &Admins, arg1: address) {
        assert!(!is_admin(arg0, arg1), 2);
    }

    public(friend) fun assert_is_owner(arg0: &Owner, arg1: address) {
        assert!(is_owner(arg0, arg1), 0);
    }

    public(friend) fun get_admins(arg0: &Admins) : 0x2::vec_set::VecSet<address> {
        arg0.admins
    }

    public(friend) fun get_owner(arg0: &Owner) : address {
        arg0.owner
    }

    fun init(arg0: ADMINS, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::types::is_one_time_witness<ADMINS>(&arg0), 3);
        let v0 = Owner{
            id    : 0x2::object::new(arg1),
            owner : 0x2::tx_context::sender(arg1),
        };
        0x2::transfer::share_object<Owner>(v0);
        let v1 = 0x1::vector::empty<address>();
        0x1::vector::push_back<address>(&mut v1, 0x2::tx_context::sender(arg1));
        let v2 = Admins{
            id     : 0x2::object::new(arg1),
            admins : 0x2::vec_set::from_keys<address>(v1),
        };
        0x2::transfer::share_object<Admins>(v2);
    }

    public(friend) fun is_admin(arg0: &Admins, arg1: address) : bool {
        0x2::vec_set::contains<address>(&arg0.admins, &arg1)
    }

    public(friend) fun is_owner(arg0: &Owner, arg1: address) : bool {
        arg0.owner == arg1
    }

    public(friend) entry fun remove_admin(arg0: &Owner, arg1: &mut Admins, arg2: address, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert_is_owner(arg0, 0x2::tx_context::sender(arg4));
        assert_is_admin(arg1, arg2);
        0x2::vec_set::remove<address>(&mut arg1.admins, &arg2);
        let v0 = AdminRemovedEvent{
            admin      : arg2,
            removed_by : 0x2::tx_context::sender(arg4),
            removed_at : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<AdminRemovedEvent>(v0);
    }

    public(friend) entry fun transfer_ownership(arg0: &mut Owner, arg1: address, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert_is_owner(arg0, 0x2::tx_context::sender(arg3));
        arg0.owner = arg1;
        let v0 = OwnershipTransferredEvent{
            old_owner      : arg0.owner,
            new_owner      : arg1,
            transferred_at : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<OwnershipTransferredEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

