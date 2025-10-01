module 0x1198edab988f56ced66d5f8a511be599ebcb4d7e86bbff60966fd00383bc4cda::roles {
    struct Admin has key {
        id: 0x2::object::UID,
    }

    struct ROLES has drop {
        dummy_field: bool,
    }

    struct Creator has store, key {
        id: 0x2::object::UID,
        launch: 0x2::object::ID,
    }

    public fun add_admin(arg0: &0x506d979252eea6a3e8d270f46e64a5bd49407a31b83ba7ef2be300cc098aca83::access_control::OwnerCap<ROLES>, arg1: &mut 0x506d979252eea6a3e8d270f46e64a5bd49407a31b83ba7ef2be300cc098aca83::access_control::SRoles<ROLES>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x506d979252eea6a3e8d270f46e64a5bd49407a31b83ba7ef2be300cc098aca83::access_control::add_role<ROLES, Admin>(arg0, arg1, arg2, arg3);
    }

    public fun assert_launch_creator(arg0: &Creator, arg1: 0x2::object::ID) {
        assert!(arg0.launch == arg1, 0);
    }

    fun init(arg0: ROLES, arg1: &mut 0x2::tx_context::TxContext) {
        0x506d979252eea6a3e8d270f46e64a5bd49407a31b83ba7ef2be300cc098aca83::access_control::default<ROLES>(&arg0, arg1);
    }

    public(friend) fun new_creator(arg0: 0x2::object::ID, arg1: &mut 0x2::tx_context::TxContext) : Creator {
        Creator{
            id     : 0x2::object::new(arg1),
            launch : arg0,
        }
    }

    public fun revoke_admin(arg0: &0x506d979252eea6a3e8d270f46e64a5bd49407a31b83ba7ef2be300cc098aca83::access_control::OwnerCap<ROLES>, arg1: &mut 0x506d979252eea6a3e8d270f46e64a5bd49407a31b83ba7ef2be300cc098aca83::access_control::SRoles<ROLES>, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        0x506d979252eea6a3e8d270f46e64a5bd49407a31b83ba7ef2be300cc098aca83::access_control::revoke_role_access<ROLES>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

