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

    public fun transfer_admin_cap(arg0: AdminCap, arg1: address) {
        0x2::transfer::public_transfer<AdminCap>(arg0, arg1);
    }

    public fun transfer_executor_cap(arg0: ExecutorCap, arg1: address) {
        0x2::transfer::public_transfer<ExecutorCap>(arg0, arg1);
    }

    public fun transfer_partial_fill_cap(arg0: PartialFillCap, arg1: address) {
        0x2::transfer::public_transfer<PartialFillCap>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

