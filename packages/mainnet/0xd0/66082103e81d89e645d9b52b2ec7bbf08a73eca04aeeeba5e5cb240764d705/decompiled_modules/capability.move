module 0xf53c071b6575ee2e5b1b19158acbbf21944aa6474d7b8e688365015295a7c0a7::capability {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct ExecutorCap has store, key {
        id: 0x2::object::UID,
        label: vector<u8>,
        minted_by: address,
    }

    struct PartialFillCap has store, key {
        id: 0x2::object::UID,
        label: vector<u8>,
        minted_by: address,
    }

    struct RevocationRegistry has store, key {
        id: 0x2::object::UID,
        revoked_executor_caps: vector<0x2::object::ID>,
        revoked_partial_fill_caps: vector<0x2::object::ID>,
    }

    public fun create_revocation_registry(arg0: &AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = RevocationRegistry{
            id                        : 0x2::object::new(arg1),
            revoked_executor_caps     : 0x1::vector::empty<0x2::object::ID>(),
            revoked_partial_fill_caps : 0x1::vector::empty<0x2::object::ID>(),
        };
        0x2::transfer::public_share_object<RevocationRegistry>(v0);
    }

    public fun destroy_executor_cap(arg0: ExecutorCap) {
        let ExecutorCap {
            id        : v0,
            label     : _,
            minted_by : _,
        } = arg0;
        let v3 = v0;
        0xf53c071b6575ee2e5b1b19158acbbf21944aa6474d7b8e688365015295a7c0a7::events::emit_executor_cap_destroyed(0x2::object::uid_to_inner(&v3));
        0x2::object::delete(v3);
    }

    public fun destroy_partial_fill_cap(arg0: PartialFillCap) {
        let PartialFillCap {
            id        : v0,
            label     : _,
            minted_by : _,
        } = arg0;
        let v3 = v0;
        0xf53c071b6575ee2e5b1b19158acbbf21944aa6474d7b8e688365015295a7c0a7::events::emit_partial_fill_cap_destroyed(0x2::object::uid_to_inner(&v3));
        0x2::object::delete(v3);
    }

    public fun executor_cap_label(arg0: &ExecutorCap) : &vector<u8> {
        &arg0.label
    }

    public fun executor_cap_minted_by(arg0: &ExecutorCap) : address {
        arg0.minted_by
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        let v1 = 0x2::tx_context::sender(arg0);
        0xf53c071b6575ee2e5b1b19158acbbf21944aa6474d7b8e688365015295a7c0a7::events::emit_admin_cap_created(0x2::object::id<AdminCap>(&v0), v1);
        0x2::transfer::public_transfer<AdminCap>(v0, v1);
    }

    public fun is_executor_cap_revoked(arg0: &RevocationRegistry, arg1: 0x2::object::ID) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x2::object::ID>(&arg0.revoked_executor_caps)) {
            if (*0x1::vector::borrow<0x2::object::ID>(&arg0.revoked_executor_caps, v0) == arg1) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    public fun is_partial_fill_cap_revoked(arg0: &RevocationRegistry, arg1: 0x2::object::ID) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x2::object::ID>(&arg0.revoked_partial_fill_caps)) {
            if (*0x1::vector::borrow<0x2::object::ID>(&arg0.revoked_partial_fill_caps, v0) == arg1) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    public fun mint_executor_cap(arg0: &AdminCap, arg1: vector<u8>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u8>(&arg1) > 0, 0xf53c071b6575ee2e5b1b19158acbbf21944aa6474d7b8e688365015295a7c0a7::errors::empty_label());
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = ExecutorCap{
            id        : 0x2::object::new(arg3),
            label     : arg1,
            minted_by : v0,
        };
        0xf53c071b6575ee2e5b1b19158acbbf21944aa6474d7b8e688365015295a7c0a7::events::emit_executor_cap_minted(0x2::object::id<ExecutorCap>(&v1), arg2, arg1, v0);
        0x2::transfer::public_transfer<ExecutorCap>(v1, arg2);
    }

    public fun mint_partial_fill_cap(arg0: &AdminCap, arg1: vector<u8>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u8>(&arg1) > 0, 0xf53c071b6575ee2e5b1b19158acbbf21944aa6474d7b8e688365015295a7c0a7::errors::empty_label());
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = PartialFillCap{
            id        : 0x2::object::new(arg3),
            label     : arg1,
            minted_by : v0,
        };
        0xf53c071b6575ee2e5b1b19158acbbf21944aa6474d7b8e688365015295a7c0a7::events::emit_partial_fill_cap_minted(0x2::object::id<PartialFillCap>(&v1), arg2, arg1, v0);
        0x2::transfer::public_transfer<PartialFillCap>(v1, arg2);
    }

    public fun partial_fill_cap_label(arg0: &PartialFillCap) : &vector<u8> {
        &arg0.label
    }

    public fun partial_fill_cap_minted_by(arg0: &PartialFillCap) : address {
        arg0.minted_by
    }

    public fun revoke_executor_cap_by_id(arg0: &AdminCap, arg1: &mut RevocationRegistry, arg2: 0x2::object::ID) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x2::object::ID>(&arg1.revoked_executor_caps)) {
            assert!(*0x1::vector::borrow<0x2::object::ID>(&arg1.revoked_executor_caps, v0) != arg2, 0xf53c071b6575ee2e5b1b19158acbbf21944aa6474d7b8e688365015295a7c0a7::errors::cap_already_revoked());
            v0 = v0 + 1;
        };
        0x1::vector::push_back<0x2::object::ID>(&mut arg1.revoked_executor_caps, arg2);
    }

    public fun revoke_partial_fill_cap_by_id(arg0: &AdminCap, arg1: &mut RevocationRegistry, arg2: 0x2::object::ID) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x2::object::ID>(&arg1.revoked_partial_fill_caps)) {
            assert!(*0x1::vector::borrow<0x2::object::ID>(&arg1.revoked_partial_fill_caps, v0) != arg2, 0xf53c071b6575ee2e5b1b19158acbbf21944aa6474d7b8e688365015295a7c0a7::errors::partial_cap_already_revoked());
            v0 = v0 + 1;
        };
        0x1::vector::push_back<0x2::object::ID>(&mut arg1.revoked_partial_fill_caps, arg2);
    }

    public fun transfer_admin_cap(arg0: AdminCap, arg1: address) {
        0x2::transfer::public_transfer<AdminCap>(arg0, arg1);
    }

    public fun transfer_executor_cap(arg0: ExecutorCap, arg1: address) {
        0x2::transfer::public_transfer<ExecutorCap>(arg0, arg1);
    }

    public fun transfer_partial_fill_cap(arg0: PartialFillCap, arg1: address) {
        0x2::transfer::public_transfer<PartialFillCap>(arg0, arg1);
    }

    public fun unrevoke_executor_cap(arg0: &AdminCap, arg1: &mut RevocationRegistry, arg2: 0x2::object::ID) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x2::object::ID>(&arg1.revoked_executor_caps)) {
            if (*0x1::vector::borrow<0x2::object::ID>(&arg1.revoked_executor_caps, v0) == arg2) {
                0x1::vector::swap_remove<0x2::object::ID>(&mut arg1.revoked_executor_caps, v0);
                return
            };
            v0 = v0 + 1;
        };
        abort 0xf53c071b6575ee2e5b1b19158acbbf21944aa6474d7b8e688365015295a7c0a7::errors::revocation_not_found()
    }

    public fun unrevoke_partial_fill_cap(arg0: &AdminCap, arg1: &mut RevocationRegistry, arg2: 0x2::object::ID) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x2::object::ID>(&arg1.revoked_partial_fill_caps)) {
            if (*0x1::vector::borrow<0x2::object::ID>(&arg1.revoked_partial_fill_caps, v0) == arg2) {
                0x1::vector::swap_remove<0x2::object::ID>(&mut arg1.revoked_partial_fill_caps, v0);
                return
            };
            v0 = v0 + 1;
        };
        abort 0xf53c071b6575ee2e5b1b19158acbbf21944aa6474d7b8e688365015295a7c0a7::errors::revocation_not_found()
    }

    // decompiled from Move bytecode v6
}

