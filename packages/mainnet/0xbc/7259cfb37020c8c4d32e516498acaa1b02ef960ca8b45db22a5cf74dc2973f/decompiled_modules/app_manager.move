module 0xbc7259cfb37020c8c4d32e516498acaa1b02ef960ca8b45db22a5cf74dc2973f::app_manager {
    struct TotalAppInfo has store, key {
        id: 0x2::object::UID,
        app_caps: vector<0x2::object::ID>,
    }

    struct AppCap has store, key {
        id: 0x2::object::UID,
        app_id: u16,
    }

    public fun destroy_app_cap(arg0: AppCap) {
        let AppCap {
            id     : v0,
            app_id : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun get_app_id(arg0: &AppCap) : u16 {
        arg0.app_id
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = TotalAppInfo{
            id       : 0x2::object::new(arg0),
            app_caps : 0x1::vector::empty<0x2::object::ID>(),
        };
        0x2::transfer::share_object<TotalAppInfo>(v0);
    }

    fun register_app(arg0: &mut TotalAppInfo, arg1: &mut 0x2::tx_context::TxContext) : AppCap {
        let v0 = 0x2::object::new(arg1);
        let v1 = AppCap{
            id     : v0,
            app_id : (0x1::vector::length<0x2::object::ID>(&arg0.app_caps) as u16),
        };
        0x1::vector::push_back<0x2::object::ID>(&mut arg0.app_caps, 0x2::object::uid_to_inner(&v0));
        v1
    }

    public fun register_cap_with_governance(arg0: &0xbc7259cfb37020c8c4d32e516498acaa1b02ef960ca8b45db22a5cf74dc2973f::genesis::GovernanceCap, arg1: &mut TotalAppInfo, arg2: &mut 0x2::tx_context::TxContext) : AppCap {
        register_app(arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

