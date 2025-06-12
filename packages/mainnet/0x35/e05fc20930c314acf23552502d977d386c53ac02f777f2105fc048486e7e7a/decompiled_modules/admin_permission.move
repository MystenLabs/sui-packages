module 0x35e05fc20930c314acf23552502d977d386c53ac02f777f2105fc048486e7e7a::admin_permission {
    struct AdminPermission has store, key {
        id: 0x2::object::UID,
        owner: address,
        permissions_list: vector<0x1::string::String>,
        connected_users: vector<address>,
    }

    public entry fun add_connected_users(arg0: &0x35e05fc20930c314acf23552502d977d386c53ac02f777f2105fc048486e7e7a::cap::AdminCap, arg1: &mut AdminPermission, arg2: vector<address>) {
        0x1::vector::append<address>(&mut arg1.connected_users, arg2);
    }

    public entry fun add_permissions(arg0: &0x35e05fc20930c314acf23552502d977d386c53ac02f777f2105fc048486e7e7a::cap::AdminCap, arg1: &mut AdminPermission, arg2: vector<0x1::string::String>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.owner == 0x2::tx_context::sender(arg3), 1);
        0x1::vector::append<0x1::string::String>(&mut arg1.permissions_list, arg2);
    }

    public entry fun create_admin_permission(arg0: &0x35e05fc20930c314acf23552502d977d386c53ac02f777f2105fc048486e7e7a::cap::AdminCap, arg1: vector<0x1::string::String>, arg2: address, arg3: vector<address>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminPermission{
            id               : 0x2::object::new(arg4),
            owner            : arg2,
            permissions_list : arg1,
            connected_users  : arg3,
        };
        0x2::transfer::share_object<AdminPermission>(v0);
    }

    public fun is_connected_user(arg0: &AdminPermission, arg1: address, arg2: &0x2::tx_context::TxContext) : bool {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 3);
        0x1::vector::contains<address>(&arg0.connected_users, &arg1)
    }

    public entry fun remove_connected_user(arg0: &0x35e05fc20930c314acf23552502d977d386c53ac02f777f2105fc048486e7e7a::cap::AdminCap, arg1: &mut AdminPermission, arg2: u64) {
        assert!(arg2 < 0x1::vector::length<address>(&arg1.connected_users), 2);
        0x1::vector::remove<address>(&mut arg1.connected_users, arg2);
    }

    public entry fun remove_permission(arg0: &0x35e05fc20930c314acf23552502d977d386c53ac02f777f2105fc048486e7e7a::cap::AdminCap, arg1: &mut AdminPermission, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.owner == 0x2::tx_context::sender(arg3), 1);
        assert!(arg2 < 0x1::vector::length<0x1::string::String>(&arg1.permissions_list), 2);
        0x1::vector::remove<0x1::string::String>(&mut arg1.permissions_list, arg2);
    }

    public entry fun update_connected_user(arg0: &0x35e05fc20930c314acf23552502d977d386c53ac02f777f2105fc048486e7e7a::cap::AdminCap, arg1: &mut AdminPermission, arg2: u64, arg3: address) {
        assert!(arg2 < 0x1::vector::length<address>(&arg1.connected_users), 2);
        *0x1::vector::borrow_mut<address>(&mut arg1.connected_users, arg2) = arg3;
    }

    public entry fun update_permission(arg0: &0x35e05fc20930c314acf23552502d977d386c53ac02f777f2105fc048486e7e7a::cap::AdminCap, arg1: &mut AdminPermission, arg2: u64, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.owner == 0x2::tx_context::sender(arg4), 1);
        assert!(arg2 < 0x1::vector::length<0x1::string::String>(&arg1.permissions_list), 2);
        *0x1::vector::borrow_mut<0x1::string::String>(&mut arg1.permissions_list, arg2) = arg3;
    }

    // decompiled from Move bytecode v6
}

