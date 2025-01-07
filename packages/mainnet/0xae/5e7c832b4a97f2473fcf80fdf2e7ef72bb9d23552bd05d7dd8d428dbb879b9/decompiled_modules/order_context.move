module 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order_context {
    struct OrderContext has drop {
        maven_id: 0x2::object::ID,
        mode: u8,
        created_role_ids: vector<0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::RoleID>,
        created_permission_ids: vector<0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::PermissionID>,
    }

    public fun get_maven_id(arg0: &OrderContext) : 0x2::object::ID {
        arg0.maven_id
    }

    public fun get_permission_id(arg0: &OrderContext, arg1: &0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::QueryID<0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::PermissionID>) : 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::PermissionID {
        if (0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::is_ref<0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::PermissionID>(arg1)) {
            *0x1::vector::borrow<0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::PermissionID>(&arg0.created_permission_ids, 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::get_permission_ref(arg1))
        } else {
            *0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::get_id<0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::PermissionID>(arg1)
        }
    }

    public fun get_permission_id_vec(arg0: &OrderContext, arg1: &vector<0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::QueryID<0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::PermissionID>>) : vector<0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::PermissionID> {
        let v0 = 0x1::vector::empty<0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::PermissionID>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::QueryID<0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::PermissionID>>(arg1)) {
            0x1::vector::push_back<0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::PermissionID>(&mut v0, get_permission_id(arg0, 0x1::vector::borrow<0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::QueryID<0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::PermissionID>>(arg1, v1)));
            v1 = v1 + 1;
        };
        v0
    }

    public fun get_role_id(arg0: &OrderContext, arg1: &0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::QueryID<0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::RoleID>) : 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::RoleID {
        if (0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::is_ref<0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::RoleID>(arg1)) {
            *0x1::vector::borrow<0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::RoleID>(&arg0.created_role_ids, 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::get_role_ref(arg1))
        } else {
            *0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::get_id<0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::RoleID>(arg1)
        }
    }

    public fun in_seq_mode(arg0: &OrderContext) : bool {
        arg0.mode == 0
    }

    public fun in_timelock_mode(arg0: &OrderContext) : bool {
        arg0.mode == 1
    }

    fun new(arg0: 0x2::object::ID, arg1: u8) : OrderContext {
        OrderContext{
            maven_id               : arg0,
            mode                   : arg1,
            created_role_ids       : 0x1::vector::empty<0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::RoleID>(),
            created_permission_ids : 0x1::vector::empty<0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::PermissionID>(),
        }
    }

    public fun new_seq_context(arg0: 0x2::object::ID) : OrderContext {
        new(arg0, 0)
    }

    public fun new_timelock_context(arg0: 0x2::object::ID) : OrderContext {
        new(arg0, 1)
    }

    public fun push_permission_id(arg0: &mut OrderContext, arg1: 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::PermissionID) {
        0x1::vector::push_back<0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::PermissionID>(&mut arg0.created_permission_ids, arg1);
    }

    public fun push_role_id(arg0: &mut OrderContext, arg1: 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::RoleID) {
        0x1::vector::push_back<0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::RoleID>(&mut arg0.created_role_ids, arg1);
    }

    // decompiled from Move bytecode v6
}

