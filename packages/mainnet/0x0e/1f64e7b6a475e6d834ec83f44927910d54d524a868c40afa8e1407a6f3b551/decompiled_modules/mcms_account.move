module 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::mcms_account {
    struct OwnerCap has store, key {
        id: 0x2::object::UID,
    }

    struct AccountState has key {
        id: 0x2::object::UID,
        owner: address,
        pending_transfer: 0x1::option::Option<PendingTransfer>,
    }

    struct PendingTransfer has drop, store {
        from: address,
        to: address,
        accepted: bool,
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

    struct MCMS_ACCOUNT has drop {
        dummy_field: bool,
    }

    struct McmsAccountProof has drop {
        dummy_field: bool,
    }

    struct PublisherKey has copy, drop, store {
        dummy_field: bool,
    }

    public fun accept_ownership(arg0: &mut AccountState, arg1: &mut 0x2::tx_context::TxContext) {
        accept_ownership_internal(arg0, 0x2::tx_context::sender(arg1));
    }

    public(friend) fun accept_ownership_as_timelock(arg0: &mut AccountState, arg1: &mut 0x2::tx_context::TxContext) {
        accept_ownership_internal(arg0, 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::mcms_registry::get_multisig_address());
    }

    public fun accept_ownership_from_object(arg0: &mut AccountState, arg1: &mut 0x2::object::UID) {
        accept_ownership_internal(arg0, 0x2::object::uid_to_address(arg1));
    }

    fun accept_ownership_internal(arg0: &mut AccountState, arg1: address) {
        assert!(0x1::option::is_some<PendingTransfer>(&arg0.pending_transfer), 3);
        let v0 = 0x1::option::borrow_mut<PendingTransfer>(&mut arg0.pending_transfer);
        assert!(arg0.owner == v0.from, 4);
        assert!(arg1 == v0.to, 2);
        assert!(!v0.accepted, 7);
        v0.accepted = true;
        let v1 = OwnershipTransferAccepted{
            from : v0.from,
            to   : arg1,
        };
        0x2::event::emit<OwnershipTransferAccepted>(v1);
    }

    public(friend) fun create_mcms_account_proof() : McmsAccountProof {
        McmsAccountProof{dummy_field: false}
    }

    public fun execute_ownership_transfer(arg0: OwnerCap, arg1: &mut AccountState, arg2: &mut 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::mcms_registry::Registry, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::option::is_some<PendingTransfer>(&arg1.pending_transfer), 3);
        let v0 = 0x1::option::extract<PendingTransfer>(&mut arg1.pending_transfer);
        let v1 = arg1.owner;
        let v2 = v0.to;
        assert!(v0.from == v1, 4);
        assert!(v2 == arg3, 5);
        assert!(v0.accepted, 6);
        if (v2 == 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::mcms_registry::get_multisig_address()) {
            let v3 = PublisherKey{dummy_field: false};
            0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::mcms_registry::register_entrypoint<McmsAccountProof, OwnerCap>(arg2, 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::mcms_registry::create_publisher_wrapper<McmsAccountProof>(0x2::dynamic_field::borrow<PublisherKey, 0x2::package::Publisher>(&arg0.id, v3), create_mcms_account_proof()), create_mcms_account_proof(), arg0, vector[b"mcms_account", b"mcms_deployer", b"mcms_registry"], arg4);
        } else {
            0x2::transfer::transfer<OwnerCap>(arg0, v2);
        };
        arg1.owner = v2;
        arg1.pending_transfer = 0x1::option::none<PendingTransfer>();
        let v4 = OwnershipTransferred{
            from : v1,
            to   : v2,
        };
        0x2::event::emit<OwnershipTransferred>(v4);
    }

    fun init(arg0: MCMS_ACCOUNT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = AccountState{
            id               : 0x2::object::new(arg1),
            owner            : 0x2::tx_context::sender(arg1),
            pending_transfer : 0x1::option::none<PendingTransfer>(),
        };
        0x2::transfer::share_object<AccountState>(v0);
        let v1 = OwnerCap{id: 0x2::object::new(arg1)};
        let v2 = PublisherKey{dummy_field: false};
        0x2::dynamic_field::add<PublisherKey, 0x2::package::Publisher>(&mut v1.id, v2, 0x2::package::claim<MCMS_ACCOUNT>(arg0, arg1));
        0x2::transfer::transfer<OwnerCap>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun owner(arg0: &AccountState) : address {
        arg0.owner
    }

    public fun pending_transfer_accepted(arg0: &AccountState) : 0x1::option::Option<bool> {
        let v0 = &arg0.pending_transfer;
        if (0x1::option::is_some<PendingTransfer>(v0)) {
            0x1::option::some<bool>(0x1::option::borrow<PendingTransfer>(v0).accepted)
        } else {
            0x1::option::none<bool>()
        }
    }

    public fun pending_transfer_from(arg0: &AccountState) : 0x1::option::Option<address> {
        let v0 = &arg0.pending_transfer;
        if (0x1::option::is_some<PendingTransfer>(v0)) {
            0x1::option::some<address>(0x1::option::borrow<PendingTransfer>(v0).from)
        } else {
            0x1::option::none<address>()
        }
    }

    public fun pending_transfer_to(arg0: &AccountState) : 0x1::option::Option<address> {
        let v0 = &arg0.pending_transfer;
        if (0x1::option::is_some<PendingTransfer>(v0)) {
            0x1::option::some<address>(0x1::option::borrow<PendingTransfer>(v0).to)
        } else {
            0x1::option::none<address>()
        }
    }

    public fun transfer_ownership(arg0: &OwnerCap, arg1: &mut AccountState, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.owner != arg2, 1);
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

    public fun transfer_ownership_to_self(arg0: &OwnerCap, arg1: &mut AccountState, arg2: &mut 0x2::tx_context::TxContext) {
        transfer_ownership(arg0, arg1, 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::mcms_registry::get_multisig_address(), arg2);
    }

    // decompiled from Move bytecode v6
}

