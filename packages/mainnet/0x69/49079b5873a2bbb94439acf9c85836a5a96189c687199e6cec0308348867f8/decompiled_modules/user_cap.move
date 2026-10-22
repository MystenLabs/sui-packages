module 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::user_cap {
    struct UserCap<phantom T0> has store, key {
        id: 0x2::object::UID,
        holder: 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::keys::Holder,
    }

    public(friend) fun activate<T0>(arg0: &mut 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::registry::Registry, arg1: 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::keys::Holder) {
        assert!(0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::registry::get_user_cap_exists<T0>(arg0, arg1), 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::errors::registry_protocol_not_found());
        assert!(!get_is_active<T0>(arg0, arg1), 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::errors::registry_protocol_already_authorized());
        0x2::table::add<0x2::object::ID, 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::structs::CapRecord>(0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::registry::active_caps_mut(arg0), get_user_cap_id<T0>(arg0, arg1), 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::structs::new_cap_record(0x1::type_name::with_defining_ids<T0>(), arg1));
    }

    public(friend) fun assert_active<T0>(arg0: &0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::registry::Registry, arg1: &UserCap<T0>) : 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::keys::Holder {
        assert!(0x2::table::contains<0x2::object::ID, 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::structs::CapRecord>(0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::registry::active_caps(arg0), 0x2::object::id<UserCap<T0>>(arg1)), 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::errors::registry_protocol_not_authorized());
        arg1.holder
    }

    public(friend) fun assert_active_at<T0>(arg0: &0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::registry::Registry, arg1: 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::keys::Holder) {
        assert!(get_is_active<T0>(arg0, arg1), 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::errors::registry_protocol_not_authorized());
    }

    public fun get_is_active<T0>(arg0: &0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::registry::Registry, arg1: 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::keys::Holder) : bool {
        0x2::table::contains<0x2::object::ID, 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::structs::CapRecord>(0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::registry::active_caps(arg0), get_user_cap_id<T0>(arg0, arg1))
    }

    public fun get_user_cap_holder<T0>(arg0: &UserCap<T0>) : 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::keys::Holder {
        arg0.holder
    }

    public fun get_user_cap_id<T0>(arg0: &0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::registry::Registry, arg1: 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::keys::Holder) : 0x2::object::ID {
        0x2::object::id_from_address(0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::registry::get_user_cap_address<T0>(arg0, arg1))
    }

    public(friend) fun mint<T0>(arg0: &mut 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::registry::Registry, arg1: 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::keys::Holder) : UserCap<T0> {
        let v0 = UserCap<T0>{
            id     : 0x2::derived_object::claim<0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::keys::UserCapKey<T0>>(0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::registry::get_uid_mut(arg0), 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::keys::user_cap_key<T0>(arg1)),
            holder : arg1,
        };
        0x2::table::add<0x2::object::ID, 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::structs::CapRecord>(0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::registry::active_caps_mut(arg0), 0x2::object::id<UserCap<T0>>(&v0), 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::structs::new_cap_record(0x1::type_name::with_defining_ids<T0>(), arg1));
        v0
    }

    public(friend) fun revoke<T0>(arg0: &mut 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::registry::Registry, arg1: 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::keys::Holder) {
        assert_active_at<T0>(arg0, arg1);
        0x2::table::remove<0x2::object::ID, 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::structs::CapRecord>(0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::registry::active_caps_mut(arg0), get_user_cap_id<T0>(arg0, arg1));
    }

    // decompiled from Move bytecode v7
}

