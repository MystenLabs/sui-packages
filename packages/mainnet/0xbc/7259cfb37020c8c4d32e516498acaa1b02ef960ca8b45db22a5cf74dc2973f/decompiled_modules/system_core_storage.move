module 0xbc7259cfb37020c8c4d32e516498acaa1b02ef960ca8b45db22a5cf74dc2973f::system_core_storage {
    struct Storage has key {
        id: 0x2::object::UID,
        app_cap: 0xbc7259cfb37020c8c4d32e516498acaa1b02ef960ca8b45db22a5cf74dc2973f::app_manager::AppCap,
    }

    public(friend) fun get_app_cap(arg0: &Storage) : &0xbc7259cfb37020c8c4d32e516498acaa1b02ef960ca8b45db22a5cf74dc2973f::app_manager::AppCap {
        &arg0.app_cap
    }

    public fun initialize_cap_with_governance(arg0: &0xbc7259cfb37020c8c4d32e516498acaa1b02ef960ca8b45db22a5cf74dc2973f::genesis::GovernanceCap, arg1: &mut 0xbc7259cfb37020c8c4d32e516498acaa1b02ef960ca8b45db22a5cf74dc2973f::app_manager::TotalAppInfo, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Storage{
            id      : 0x2::object::new(arg2),
            app_cap : 0xbc7259cfb37020c8c4d32e516498acaa1b02ef960ca8b45db22a5cf74dc2973f::app_manager::register_cap_with_governance(arg0, arg1, arg2),
        };
        0x2::transfer::share_object<Storage>(v0);
    }

    // decompiled from Move bytecode v6
}

