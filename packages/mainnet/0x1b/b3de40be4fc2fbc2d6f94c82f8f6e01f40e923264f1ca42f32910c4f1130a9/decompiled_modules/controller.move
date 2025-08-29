module 0x1bb3de40be4fc2fbc2d6f94c82f8f6e01f40e923264f1ca42f32910c4f1130a9::controller {
    struct SharedTraitController has key {
        id: 0x2::object::UID,
        admin: address,
        active_traits: 0x1bb3de40be4fc2fbc2d6f94c82f8f6e01f40e923264f1ca42f32910c4f1130a9::storage::TraitStorage,
        update_count: u64,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
        controller_id: 0x2::object::ID,
    }

    struct TraitUpdated has copy, drop {
        controller_id: 0x2::object::ID,
        trait_name: 0x1::string::String,
        updated_by: address,
        update_number: u64,
    }

    public fun add_trait(arg0: &mut SharedTraitController, arg1: &AdminCap, arg2: 0x1::string::String, arg3: vector<0x1::string::String>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg0.admin, 1);
        0x1bb3de40be4fc2fbc2d6f94c82f8f6e01f40e923264f1ca42f32910c4f1130a9::storage::store_large_trait(&mut arg0.active_traits, arg2, arg3, arg4);
        arg0.update_count = arg0.update_count + 1;
        let v0 = TraitUpdated{
            controller_id : 0x2::object::uid_to_inner(&arg0.id),
            trait_name    : arg2,
            updated_by    : 0x2::tx_context::sender(arg4),
            update_number : arg0.update_count,
        };
        0x2::event::emit<TraitUpdated>(v0);
    }

    public fun add_trait_chunk(arg0: &mut SharedTraitController, arg1: &AdminCap, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg5) == arg0.admin, 1);
        0x1bb3de40be4fc2fbc2d6f94c82f8f6e01f40e923264f1ca42f32910c4f1130a9::storage::add_chunk(&mut arg0.active_traits, arg2, arg3, arg4, arg5);
        arg0.update_count = arg0.update_count + 1;
    }

    public fun change_admin(arg0: &mut SharedTraitController, arg1: &AdminCap, arg2: address, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 1);
        arg0.admin = arg2;
    }

    public fun create_controller(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = SharedTraitController{
            id            : 0x2::object::new(arg0),
            admin         : 0x2::tx_context::sender(arg0),
            active_traits : 0x1bb3de40be4fc2fbc2d6f94c82f8f6e01f40e923264f1ca42f32910c4f1130a9::storage::create_storage(arg0),
            update_count  : 0,
        };
        0x2::transfer::share_object<SharedTraitController>(v0);
        let v1 = AdminCap{
            id            : 0x2::object::new(arg0),
            controller_id : 0x2::object::uid_to_inner(&v0.id),
        };
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun get_admin(arg0: &SharedTraitController) : address {
        arg0.admin
    }

    public fun get_reconstructed_trait(arg0: &SharedTraitController, arg1: 0x1::string::String) : 0x1::string::String {
        0x1bb3de40be4fc2fbc2d6f94c82f8f6e01f40e923264f1ca42f32910c4f1130a9::storage::reconstruct_trait(0x1bb3de40be4fc2fbc2d6f94c82f8f6e01f40e923264f1ca42f32910c4f1130a9::storage::get_trait(&arg0.active_traits, arg1))
    }

    public fun get_trait(arg0: &SharedTraitController, arg1: 0x1::string::String) : &0x1bb3de40be4fc2fbc2d6f94c82f8f6e01f40e923264f1ca42f32910c4f1130a9::storage::TraitData {
        0x1bb3de40be4fc2fbc2d6f94c82f8f6e01f40e923264f1ca42f32910c4f1130a9::storage::get_trait(&arg0.active_traits, arg1)
    }

    public fun get_trait_count(arg0: &SharedTraitController) : u64 {
        0x1bb3de40be4fc2fbc2d6f94c82f8f6e01f40e923264f1ca42f32910c4f1130a9::storage::get_trait_count(&arg0.active_traits)
    }

    public fun get_trait_storage(arg0: &SharedTraitController) : &0x1bb3de40be4fc2fbc2d6f94c82f8f6e01f40e923264f1ca42f32910c4f1130a9::storage::TraitStorage {
        &arg0.active_traits
    }

    public fun get_update_count(arg0: &SharedTraitController) : u64 {
        arg0.update_count
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
    }

    public fun remove_trait(arg0: &mut SharedTraitController, arg1: &AdminCap, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) : 0x1bb3de40be4fc2fbc2d6f94c82f8f6e01f40e923264f1ca42f32910c4f1130a9::storage::TraitData {
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 1);
        arg0.update_count = arg0.update_count + 1;
        0x1bb3de40be4fc2fbc2d6f94c82f8f6e01f40e923264f1ca42f32910c4f1130a9::storage::remove_trait(&mut arg0.active_traits, arg2)
    }

    public fun update_trait(arg0: &mut SharedTraitController, arg1: &AdminCap, arg2: 0x1::string::String, arg3: vector<0x1::string::String>, arg4: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg0.admin, 1);
        assert!(0x1bb3de40be4fc2fbc2d6f94c82f8f6e01f40e923264f1ca42f32910c4f1130a9::storage::trait_exists(&arg0.active_traits, arg2), 2);
        0x1bb3de40be4fc2fbc2d6f94c82f8f6e01f40e923264f1ca42f32910c4f1130a9::storage::update_trait(&mut arg0.active_traits, arg2, arg3);
        arg0.update_count = arg0.update_count + 1;
        let v0 = TraitUpdated{
            controller_id : 0x2::object::uid_to_inner(&arg0.id),
            trait_name    : arg2,
            updated_by    : 0x2::tx_context::sender(arg4),
            update_number : arg0.update_count,
        };
        0x2::event::emit<TraitUpdated>(v0);
    }

    // decompiled from Move bytecode v6
}

