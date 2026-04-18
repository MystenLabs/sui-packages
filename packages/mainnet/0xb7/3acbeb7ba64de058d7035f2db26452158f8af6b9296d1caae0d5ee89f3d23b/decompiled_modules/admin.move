module 0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::admin {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    public fun authorize_cap(arg0: &AdminCap, arg1: &mut 0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::index::Index, arg2: 0x2::object::ID) {
        0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::index::authorize_cap(arg1, arg2);
    }

    public fun create_index(arg0: &AdminCap, arg1: u64, arg2: u8, arg3: u64, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : 0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::index::Index {
        0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::index::with_config(arg1, arg2, 0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::polygon::max_vertices_per_part(), 0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::polygon::max_parts(), arg3, arg4, arg5, arg6)
    }

    public fun destroy_index(arg0: &AdminCap, arg1: 0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::index::Index) {
        0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::index::destroy_empty(arg1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun mint_caps_with_ids(arg0: &AdminCap, arg1: &mut 0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::index::Index, arg2: &mut 0x2::tx_context::TxContext) : (0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::index::TransferCap, 0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::index::LifecycleCap, 0x2::object::ID, 0x2::object::ID) {
        let v0 = 0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::index::mint_transfer_cap(arg1, arg2);
        let v1 = 0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::index::mint_lifecycle_cap(arg1, arg2);
        (v0, v1, 0x2::object::id<0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::index::TransferCap>(&v0), 0x2::object::id<0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::index::LifecycleCap>(&v1))
    }

    public fun mint_lifecycle_cap(arg0: &AdminCap, arg1: &mut 0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::index::Index, arg2: &mut 0x2::tx_context::TxContext) : 0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::index::LifecycleCap {
        0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::index::mint_lifecycle_cap(arg1, arg2)
    }

    public fun mint_lifecycle_cap_with_id(arg0: &AdminCap, arg1: &mut 0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::index::Index, arg2: &mut 0x2::tx_context::TxContext) : (0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::index::LifecycleCap, 0x2::object::ID) {
        let v0 = 0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::index::mint_lifecycle_cap(arg1, arg2);
        (v0, 0x2::object::id<0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::index::LifecycleCap>(&v0))
    }

    public fun mint_transfer_cap(arg0: &AdminCap, arg1: &mut 0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::index::Index, arg2: &mut 0x2::tx_context::TxContext) : 0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::index::TransferCap {
        0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::index::mint_transfer_cap(arg1, arg2)
    }

    public fun revoke_lifecycle_cap(arg0: &AdminCap, arg1: &mut 0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::index::Index, arg2: 0x2::object::ID) {
        0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::index::revoke_cap(arg1, arg2);
    }

    public fun revoke_transfer_cap(arg0: &AdminCap, arg1: &mut 0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::index::Index, arg2: 0x2::object::ID) {
        0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::index::revoke_cap(arg1, arg2);
    }

    public fun seal_index(arg0: &AdminCap, arg1: &mut 0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::index::Index) {
        0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::index::seal(arg1);
    }

    public fun share_index(arg0: 0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::index::Index) {
        0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::index::share_existing(arg0);
    }

    public fun unseal_index(arg0: &AdminCap, arg1: &mut 0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::index::Index) {
        0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::index::unseal(arg1);
    }

    public fun update_config(arg0: &AdminCap, arg1: &mut 0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::index::Index, arg2: 0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::index::Config) {
        0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::index::set_config(arg1, arg2);
    }

    // decompiled from Move bytecode v7
}

