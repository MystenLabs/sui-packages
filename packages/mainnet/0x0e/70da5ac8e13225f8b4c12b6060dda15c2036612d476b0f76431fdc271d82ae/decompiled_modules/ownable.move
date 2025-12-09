module 0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::ownable {
    struct OwnerCap has store, key {
        id: 0x2::object::UID,
    }

    struct OwnableState has store {
        owner: address,
        pending_transfer: 0x1::option::Option<PendingTransfer>,
        owner_cap_id: 0x2::object::ID,
    }

    struct PendingTransfer has drop, store {
        from: address,
        to: address,
        accepted: bool,
    }

    struct PublisherKey has copy, drop, store {
        dummy_field: bool,
    }

    struct NewOwnableStateEvent has copy, drop, store {
        owner_cap_id: 0x2::object::ID,
        owner: address,
    }

    struct OwnershipTransferRequested has copy, drop {
        from: address,
        to: address,
    }

    struct OwnershipTransferAccepted has copy, drop {
        from: address,
        to: address,
    }

    struct OwnershipTransferred has copy, drop {
        from: address,
        to: address,
    }

    public(friend) fun accept_ownership(arg0: &mut OwnableState, arg1: &0x2::tx_context::TxContext) {
        accept_ownership_internal(arg0, 0x2::tx_context::sender(arg1));
    }

    public(friend) fun accept_ownership_from_object(arg0: &mut OwnableState, arg1: &0x2::object::UID, arg2: &0x2::tx_context::TxContext) {
        accept_ownership_internal(arg0, 0x2::object::uid_to_address(arg1));
    }

    fun accept_ownership_internal(arg0: &mut OwnableState, arg1: address) {
        assert!(0x1::option::is_some<PendingTransfer>(&arg0.pending_transfer), 4);
        let v0 = 0x1::option::borrow_mut<PendingTransfer>(&mut arg0.pending_transfer);
        assert!(arg0.owner == v0.from, 6);
        assert!(arg1 == v0.to, 3);
        assert!(!v0.accepted, 5);
        v0.accepted = true;
        let v1 = OwnershipTransferAccepted{
            from : v0.from,
            to   : arg1,
        };
        0x2::event::emit<OwnershipTransferAccepted>(v1);
    }

    public(friend) fun attach_publisher(arg0: &mut OwnerCap, arg1: 0x2::package::Publisher) {
        let v0 = PublisherKey{dummy_field: false};
        0x2::dynamic_field::add<PublisherKey, 0x2::package::Publisher>(&mut arg0.id, v0, arg1);
    }

    public(friend) fun borrow_publisher(arg0: &OwnerCap) : &0x2::package::Publisher {
        let v0 = PublisherKey{dummy_field: false};
        0x2::dynamic_field::borrow<PublisherKey, 0x2::package::Publisher>(&arg0.id, v0)
    }

    public fun default_key() : vector<u8> {
        b"CCIP_OWNABLE"
    }

    public(friend) fun execute_ownership_transfer(arg0: OwnerCap, arg1: &mut OwnableState, arg2: address, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::object::id<OwnerCap>(&arg0) == arg1.owner_cap_id, 1);
        assert!(0x1::option::is_some<PendingTransfer>(&arg1.pending_transfer), 4);
        let v0 = 0x1::option::extract<PendingTransfer>(&mut arg1.pending_transfer);
        let v1 = arg1.owner;
        let v2 = v0.to;
        assert!(v0.from == v1, 6);
        assert!(v2 == arg2, 7);
        assert!(v0.accepted, 8);
        assert!(v2 != 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms_registry::get_multisig_address(), 9);
        arg1.owner = arg2;
        0x2::transfer::transfer<OwnerCap>(arg0, arg2);
        let v3 = OwnershipTransferred{
            from : v1,
            to   : v2,
        };
        0x2::event::emit<OwnershipTransferred>(v3);
    }

    public(friend) fun execute_ownership_transfer_to_mcms<T0: drop>(arg0: OwnerCap, arg1: &mut OwnableState, arg2: &mut 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms_registry::Registry, arg3: address, arg4: 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms_registry::PublisherWrapper<T0>, arg5: T0, arg6: vector<vector<u8>>, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::object::id<OwnerCap>(&arg0) == arg1.owner_cap_id, 1);
        assert!(0x1::option::is_some<PendingTransfer>(&arg1.pending_transfer), 4);
        let v0 = 0x1::option::extract<PendingTransfer>(&mut arg1.pending_transfer);
        let v1 = arg1.owner;
        let v2 = v0.to;
        assert!(v0.from == v1, 6);
        assert!(v2 == arg3, 7);
        assert!(v0.accepted, 8);
        assert!(arg3 == 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms_registry::get_multisig_address(), 10);
        arg1.owner = arg3;
        0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms_registry::register_entrypoint<T0, OwnerCap>(arg2, arg4, arg5, arg0, arg6, arg7);
        let v3 = OwnershipTransferred{
            from : v1,
            to   : v2,
        };
        0x2::event::emit<OwnershipTransferred>(v3);
    }

    public fun has_pending_transfer(arg0: &OwnableState) : bool {
        0x1::option::is_some<PendingTransfer>(&arg0.pending_transfer)
    }

    public(friend) fun mcms_accept_ownership(arg0: &mut OwnableState, arg1: address, arg2: &0x2::tx_context::TxContext) {
        accept_ownership_internal(arg0, arg1);
    }

    public(friend) fun new(arg0: &mut 0x2::object::UID, arg1: &0x2::tx_context::TxContext) : (OwnableState, OwnerCap) {
        let v0 = OwnerCap{id: 0x2::derived_object::claim<vector<u8>>(arg0, b"CCIP_OWNABLE")};
        new_internal(v0, arg1)
    }

    fun new_internal(arg0: OwnerCap, arg1: &0x2::tx_context::TxContext) : (OwnableState, OwnerCap) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = OwnableState{
            owner            : v0,
            pending_transfer : 0x1::option::none<PendingTransfer>(),
            owner_cap_id     : 0x2::object::id<OwnerCap>(&arg0),
        };
        let v2 = NewOwnableStateEvent{
            owner_cap_id : 0x2::object::id<OwnerCap>(&arg0),
            owner        : v0,
        };
        0x2::event::emit<NewOwnableStateEvent>(v2);
        (v1, arg0)
    }

    public(friend) fun new_with_key<T0: copy + drop + store>(arg0: &mut 0x2::object::UID, arg1: T0, arg2: &0x2::tx_context::TxContext) : (OwnableState, OwnerCap) {
        let v0 = OwnerCap{id: 0x2::derived_object::claim<T0>(arg0, arg1)};
        new_internal(v0, arg2)
    }

    public fun owner(arg0: &OwnableState) : address {
        arg0.owner
    }

    public fun owner_cap_id(arg0: &OwnableState) : 0x2::object::ID {
        arg0.owner_cap_id
    }

    public fun pending_transfer_accepted(arg0: &OwnableState) : 0x1::option::Option<bool> {
        let v0 = &arg0.pending_transfer;
        if (0x1::option::is_some<PendingTransfer>(v0)) {
            0x1::option::some<bool>(0x1::option::borrow<PendingTransfer>(v0).accepted)
        } else {
            0x1::option::none<bool>()
        }
    }

    public fun pending_transfer_from(arg0: &OwnableState) : 0x1::option::Option<address> {
        let v0 = &arg0.pending_transfer;
        if (0x1::option::is_some<PendingTransfer>(v0)) {
            0x1::option::some<address>(0x1::option::borrow<PendingTransfer>(v0).from)
        } else {
            0x1::option::none<address>()
        }
    }

    public fun pending_transfer_to(arg0: &OwnableState) : 0x1::option::Option<address> {
        let v0 = &arg0.pending_transfer;
        if (0x1::option::is_some<PendingTransfer>(v0)) {
            0x1::option::some<address>(0x1::option::borrow<PendingTransfer>(v0).to)
        } else {
            0x1::option::none<address>()
        }
    }

    public(friend) fun transfer_ownership(arg0: &OwnerCap, arg1: &mut OwnableState, arg2: address, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::object::id<OwnerCap>(arg0) == arg1.owner_cap_id, 1);
        assert!(arg1.owner != arg2, 2);
        let v0 = PendingTransfer{
            from     : arg1.owner,
            to       : arg2,
            accepted : false,
        };
        arg1.pending_transfer = 0x1::option::some<PendingTransfer>(v0);
        let v1 = OwnershipTransferRequested{
            from : arg1.owner,
            to   : arg2,
        };
        0x2::event::emit<OwnershipTransferRequested>(v1);
    }

    // decompiled from Move bytecode v6
}

