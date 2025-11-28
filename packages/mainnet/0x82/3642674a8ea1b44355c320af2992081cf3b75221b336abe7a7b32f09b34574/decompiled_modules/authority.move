module 0x823642674a8ea1b44355c320af2992081cf3b75221b336abe7a7b32f09b34574::authority {
    struct PACKAGE {
        dummy_field: bool,
    }

    struct ADMIN {
        dummy_field: bool,
    }

    struct ASSISTANT {
        dummy_field: bool,
    }

    struct AuthorityCap<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        for: 0x2::object::ID,
    }

    struct AuthKey has copy, drop, store {
        dummy_field: bool,
    }

    struct AuthCap has store {
        dummy_field: bool,
    }

    public fun add_authorization(arg0: &mut 0x2::object::UID, arg1: &AuthorityCap<PACKAGE, ADMIN>) {
        assert!(!is_authorized(arg0), 1);
        let v0 = AuthKey{dummy_field: false};
        let v1 = AuthCap{dummy_field: false};
        0x2::dynamic_field::add<AuthKey, AuthCap>(arg0, v0, v1);
        0x823642674a8ea1b44355c320af2992081cf3b75221b336abe7a7b32f09b34574::events::emit_added_authorization(0x2::object::uid_to_inner(arg0));
    }

    public(friend) fun assert_source_has_been_authorized(arg0: &0x2::object::UID) {
        assert!(is_authorized(arg0), 2);
    }

    public(friend) fun create_package_admin_cap_and_keep<T0: drop>(arg0: &T0, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::types::is_one_time_witness<T0>(arg0), 0);
        let v0 = AuthorityCap<PACKAGE, ADMIN>{
            id  : 0x2::object::new(arg1),
            for : this_package(),
        };
        0x2::transfer::transfer<AuthorityCap<PACKAGE, ADMIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public(friend) fun create_package_assistant_cap(arg0: &mut 0x2::tx_context::TxContext) : AuthorityCap<PACKAGE, ASSISTANT> {
        AuthorityCap<PACKAGE, ASSISTANT>{
            id  : 0x2::object::new(arg0),
            for : this_package(),
        }
    }

    public fun is_authorized(arg0: &0x2::object::UID) : bool {
        let v0 = AuthKey{dummy_field: false};
        0x2::dynamic_field::exists_<AuthKey>(arg0, v0)
    }

    public fun remove_authorization(arg0: &mut 0x2::object::UID, arg1: &AuthorityCap<PACKAGE, ADMIN>) {
        assert!(is_authorized(arg0), 2);
        let v0 = AuthKey{dummy_field: false};
        let AuthCap {  } = 0x2::dynamic_field::remove<AuthKey, AuthCap>(arg0, v0);
        0x823642674a8ea1b44355c320af2992081cf3b75221b336abe7a7b32f09b34574::events::emit_removed_authorization(0x2::object::uid_to_inner(arg0));
    }

    fun this_package() : 0x2::object::ID {
        let v0 = 0x1::type_name::with_original_ids<ADMIN>();
        let v1 = 0x1::ascii::into_bytes(0x1::type_name::address_string(&v0));
        0x2::object::id_from_address(0x2::address::from_ascii_bytes(&v1))
    }

    // decompiled from Move bytecode v6
}

