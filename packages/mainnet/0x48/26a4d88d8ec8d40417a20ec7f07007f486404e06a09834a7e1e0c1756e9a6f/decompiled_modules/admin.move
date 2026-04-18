module 0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::admin {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    public fun authorize_cap(arg0: &AdminCap, arg1: &mut 0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::index::Index, arg2: 0x2::object::ID) {
        0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::index::authorize_cap(arg1, arg2);
    }

    public fun create_index(arg0: &AdminCap, arg1: u64, arg2: u8, arg3: u64, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : 0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::index::Index {
        0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::index::with_config(arg1, arg2, 0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::polygon::max_vertices_per_part(), 0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::polygon::max_parts(), arg3, arg4, arg5, arg6)
    }

    public fun destroy_index(arg0: &AdminCap, arg1: 0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::index::Index) {
        0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::index::destroy_empty(arg1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun mint_caps_with_ids(arg0: &AdminCap, arg1: &mut 0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::index::Index, arg2: &mut 0x2::tx_context::TxContext) : (0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::index::TransferCap, 0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::index::LifecycleCap, 0x2::object::ID, 0x2::object::ID) {
        let v0 = 0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::index::mint_transfer_cap(arg1, arg2);
        let v1 = 0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::index::mint_lifecycle_cap(arg1, arg2);
        (v0, v1, 0x2::object::id<0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::index::TransferCap>(&v0), 0x2::object::id<0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::index::LifecycleCap>(&v1))
    }

    public fun mint_lifecycle_cap(arg0: &AdminCap, arg1: &mut 0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::index::Index, arg2: &mut 0x2::tx_context::TxContext) : 0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::index::LifecycleCap {
        0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::index::mint_lifecycle_cap(arg1, arg2)
    }

    public fun mint_lifecycle_cap_with_id(arg0: &AdminCap, arg1: &mut 0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::index::Index, arg2: &mut 0x2::tx_context::TxContext) : (0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::index::LifecycleCap, 0x2::object::ID) {
        let v0 = 0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::index::mint_lifecycle_cap(arg1, arg2);
        (v0, 0x2::object::id<0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::index::LifecycleCap>(&v0))
    }

    public fun mint_transfer_cap(arg0: &AdminCap, arg1: &mut 0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::index::Index, arg2: &mut 0x2::tx_context::TxContext) : 0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::index::TransferCap {
        0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::index::mint_transfer_cap(arg1, arg2)
    }

    public fun revoke_lifecycle_cap(arg0: &AdminCap, arg1: &mut 0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::index::Index, arg2: 0x2::object::ID) {
        0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::index::revoke_cap(arg1, arg2);
    }

    public fun revoke_transfer_cap(arg0: &AdminCap, arg1: &mut 0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::index::Index, arg2: 0x2::object::ID) {
        0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::index::revoke_cap(arg1, arg2);
    }

    public fun seal_index(arg0: &AdminCap, arg1: &mut 0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::index::Index) {
        0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::index::seal(arg1);
    }

    public fun share_index(arg0: 0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::index::Index) {
        0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::index::share_existing(arg0);
    }

    public fun unseal_index(arg0: &AdminCap, arg1: &mut 0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::index::Index) {
        0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::index::unseal(arg1);
    }

    public fun update_config(arg0: &AdminCap, arg1: &mut 0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::index::Index, arg2: 0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::index::Config) {
        0x4826a4d88d8ec8d40417a20ec7f07007f486404e06a09834a7e1e0c1756e9a6f::index::set_config(arg1, arg2);
    }

    // decompiled from Move bytecode v7
}

