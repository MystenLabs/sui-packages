module 0xd666d3234eb46551273014f5616ed2575e709a861dd3812613d59104a4cb7344::identity {
    struct IdentityManager<phantom T0> has store, key {
        id: 0x2::object::UID,
        address_to_identifier: 0x2::table::Table<address, 0x1::ascii::String>,
        identifier_info: 0x2::table::Table<0x1::ascii::String, IdentifierInfo>,
        whitelist_modules: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
    }

    struct IdentifierInfo has copy, drop, store {
        owner: address,
        updated_at: u64,
    }

    struct ReadAccess has drop {
        dummy_field: bool,
    }

    public fun new<T0: drop>(arg0: &mut 0xd666d3234eb46551273014f5616ed2575e709a861dd3812613d59104a4cb7344::config::Config, arg1: &0x8787e686e2fc7f1584106ed63aeec769f3f3216576fbcac500b8e507baa5079e::admin::AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        0xd666d3234eb46551273014f5616ed2575e709a861dd3812613d59104a4cb7344::config::assert_version(arg0);
        0xd666d3234eb46551273014f5616ed2575e709a861dd3812613d59104a4cb7344::config::add_registry<T0>(arg0);
        let v0 = IdentityManager<T0>{
            id                    : 0x2::derived_object::claim<0x1::ascii::String>(0xd666d3234eb46551273014f5616ed2575e709a861dd3812613d59104a4cb7344::config::config_uid_mut(arg0), 0xd666d3234eb46551273014f5616ed2575e709a861dd3812613d59104a4cb7344::config::derived_object_key<T0>(0x1::ascii::string(b"identity"))),
            address_to_identifier : 0x2::table::new<address, 0x1::ascii::String>(arg2),
            identifier_info       : 0x2::table::new<0x1::ascii::String, IdentifierInfo>(arg2),
            whitelist_modules     : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
        };
        0x2::transfer::public_share_object<IdentityManager<T0>>(v0);
        0x2::transfer::public_share_object<0xd666d3234eb46551273014f5616ed2575e709a861dd3812613d59104a4cb7344::reclaim::ReclaimManager<T0>>(0xd666d3234eb46551273014f5616ed2575e709a861dd3812613d59104a4cb7344::reclaim::new<T0>(arg0, arg2));
    }

    public fun add_whiteslit<T0, T1: drop>(arg0: &mut IdentityManager<T0>, arg1: &0x8787e686e2fc7f1584106ed63aeec769f3f3216576fbcac500b8e507baa5079e::admin::AdminCap) {
        0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg0.whitelist_modules, 0x1::type_name::with_original_ids<T1>());
    }

    fun assert_whitelist<T0, T1: drop>(arg0: &IdentityManager<T0>) {
        let v0 = 0x1::type_name::with_original_ids<T1>();
        assert!(0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.whitelist_modules, &v0), 102);
    }

    public fun drop_identifier_info(arg0: IdentifierInfo) : (address, u64) {
        let IdentifierInfo {
            owner      : v0,
            updated_at : v1,
        } = arg0;
        (v0, v1)
    }

    public fun get_read_access(arg0: &mut 0xd666d3234eb46551273014f5616ed2575e709a861dd3812613d59104a4cb7344::config::Config, arg1: &mut 0x8787e686e2fc7f1584106ed63aeec769f3f3216576fbcac500b8e507baa5079e::treasury::Treasury, arg2: 0x2::balance::Balance<0x2::sui::SUI>) : ReadAccess {
        0xd666d3234eb46551273014f5616ed2575e709a861dd3812613d59104a4cb7344::config::assert_version(arg0);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg2) >= 0xd666d3234eb46551273014f5616ed2575e709a861dd3812613d59104a4cb7344::config::base_read_fee(arg0), 101);
        0x8787e686e2fc7f1584106ed63aeec769f3f3216576fbcac500b8e507baa5079e::treasury::supply_treasury<0x2::sui::SUI>(arg1, arg2);
        ReadAccess{dummy_field: false}
    }

    public(friend) fun identifier_by_address<T0>(arg0: &IdentityManager<T0>, arg1: address) : 0x1::ascii::String {
        *0x2::table::borrow<address, 0x1::ascii::String>(&arg0.address_to_identifier, arg1)
    }

    public fun identifier_by_address_with_read_access<T0>(arg0: &IdentityManager<T0>, arg1: &ReadAccess, arg2: address) : 0x1::ascii::String {
        *0x2::table::borrow<address, 0x1::ascii::String>(&arg0.address_to_identifier, arg2)
    }

    public fun identifier_by_address_with_whitelist<T0, T1: drop>(arg0: &IdentityManager<T0>, arg1: T1, arg2: address) : 0x1::ascii::String {
        assert_whitelist<T0, T1>(arg0);
        *0x2::table::borrow<address, 0x1::ascii::String>(&arg0.address_to_identifier, arg2)
    }

    public(friend) fun identifier_info<T0>(arg0: &IdentityManager<T0>, arg1: 0x1::ascii::String) : IdentifierInfo {
        *0x2::table::borrow<0x1::ascii::String, IdentifierInfo>(&arg0.identifier_info, arg1)
    }

    public fun identifier_info_with_read_access<T0>(arg0: &IdentityManager<T0>, arg1: &ReadAccess, arg2: 0x1::ascii::String) : IdentifierInfo {
        *0x2::table::borrow<0x1::ascii::String, IdentifierInfo>(&arg0.identifier_info, arg2)
    }

    public fun identifier_info_with_whitelist<T0, T1: drop>(arg0: &IdentityManager<T0>, arg1: T1, arg2: 0x1::ascii::String) : IdentifierInfo {
        assert_whitelist<T0, T1>(arg0);
        *0x2::table::borrow<0x1::ascii::String, IdentifierInfo>(&arg0.identifier_info, arg2)
    }

    public fun module_address_to_identifier_borrow<T0>(arg0: &IdentityManager<T0>, arg1: &T0) : &0x2::table::Table<address, 0x1::ascii::String> {
        &arg0.address_to_identifier
    }

    public fun module_address_to_identifier_borrow_mut<T0>(arg0: &mut IdentityManager<T0>, arg1: &mut T0) : &mut 0x2::table::Table<address, 0x1::ascii::String> {
        &mut arg0.address_to_identifier
    }

    public fun module_identifier_info_borrow<T0>(arg0: &IdentityManager<T0>, arg1: &T0) : &0x2::table::Table<0x1::ascii::String, IdentifierInfo> {
        &arg0.identifier_info
    }

    public fun module_identifier_info_borrow_mut<T0>(arg0: &mut IdentityManager<T0>, arg1: &mut T0) : &mut 0x2::table::Table<0x1::ascii::String, IdentifierInfo> {
        &mut arg0.identifier_info
    }

    public fun new_identifier_info(arg0: address, arg1: u64) : IdentifierInfo {
        IdentifierInfo{
            owner      : arg0,
            updated_at : arg1,
        }
    }

    public fun owner(arg0: &IdentifierInfo) : address {
        arg0.owner
    }

    public fun remove_whiteslit<T0, T1: drop>(arg0: &mut IdentityManager<T0>, arg1: &0x8787e686e2fc7f1584106ed63aeec769f3f3216576fbcac500b8e507baa5079e::admin::AdminCap) {
        let v0 = 0x1::type_name::with_original_ids<T1>();
        0x2::vec_set::remove<0x1::type_name::TypeName>(&mut arg0.whitelist_modules, &v0);
    }

    public fun update_owner(arg0: &mut IdentifierInfo, arg1: address) {
        arg0.owner = arg1;
    }

    public fun update_updated_at(arg0: &mut IdentifierInfo, arg1: u64) {
        arg0.updated_at = arg1;
    }

    public fun updated_at(arg0: &IdentifierInfo) : u64 {
        arg0.updated_at
    }

    // decompiled from Move bytecode v6
}

