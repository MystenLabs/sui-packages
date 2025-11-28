module 0x823642674a8ea1b44355c320af2992081cf3b75221b336abe7a7b32f09b34574::config {
    struct Config has key {
        id: 0x2::object::UID,
        version: u64,
        active_assistants: vector<0x2::object::ID>,
    }

    public fun active_assistants(arg0: &Config) : vector<0x2::object::ID> {
        arg0.active_assistants
    }

    public(friend) fun assert_authority_cap_is_valid<T0>(arg0: &Config, arg1: &0x823642674a8ea1b44355c320af2992081cf3b75221b336abe7a7b32f09b34574::authority::AuthorityCap<0x823642674a8ea1b44355c320af2992081cf3b75221b336abe7a7b32f09b34574::authority::PACKAGE, T0>) {
        assert!(has_authority<T0>(arg0, arg1), 2);
    }

    public(friend) fun assert_package_version(arg0: &Config) {
        assert!(arg0.version <= 1, 1);
    }

    public(friend) fun create_config_and_share<T0: drop>(arg0: &T0, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::types::is_one_time_witness<T0>(arg0), 0);
        let v0 = Config{
            id                : 0x2::object::new(arg1),
            version           : 1,
            active_assistants : 0x1::vector::empty<0x2::object::ID>(),
        };
        0x2::transfer::share_object<Config>(v0);
    }

    public(friend) fun has_authority<T0>(arg0: &Config, arg1: &0x823642674a8ea1b44355c320af2992081cf3b75221b336abe7a7b32f09b34574::authority::AuthorityCap<0x823642674a8ea1b44355c320af2992081cf3b75221b336abe7a7b32f09b34574::authority::PACKAGE, T0>) : bool {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (v0 == 0x1::type_name::with_defining_ids<0x823642674a8ea1b44355c320af2992081cf3b75221b336abe7a7b32f09b34574::authority::ADMIN>()) {
            true
        } else if (v0 == 0x1::type_name::with_defining_ids<0x823642674a8ea1b44355c320af2992081cf3b75221b336abe7a7b32f09b34574::authority::ASSISTANT>()) {
            let v2 = 0x2::object::id<0x823642674a8ea1b44355c320af2992081cf3b75221b336abe7a7b32f09b34574::authority::AuthorityCap<0x823642674a8ea1b44355c320af2992081cf3b75221b336abe7a7b32f09b34574::authority::PACKAGE, T0>>(arg1);
            0x1::vector::contains<0x2::object::ID>(&arg0.active_assistants, &v2)
        } else {
            false
        }
    }

    public fun new_assistant_cap(arg0: &mut Config, arg1: &0x823642674a8ea1b44355c320af2992081cf3b75221b336abe7a7b32f09b34574::authority::AuthorityCap<0x823642674a8ea1b44355c320af2992081cf3b75221b336abe7a7b32f09b34574::authority::PACKAGE, 0x823642674a8ea1b44355c320af2992081cf3b75221b336abe7a7b32f09b34574::authority::ADMIN>, arg2: &mut 0x2::tx_context::TxContext) : 0x823642674a8ea1b44355c320af2992081cf3b75221b336abe7a7b32f09b34574::authority::AuthorityCap<0x823642674a8ea1b44355c320af2992081cf3b75221b336abe7a7b32f09b34574::authority::PACKAGE, 0x823642674a8ea1b44355c320af2992081cf3b75221b336abe7a7b32f09b34574::authority::ASSISTANT> {
        assert_package_version(arg0);
        let v0 = 0x823642674a8ea1b44355c320af2992081cf3b75221b336abe7a7b32f09b34574::authority::create_package_assistant_cap(arg2);
        0x1::vector::push_back<0x2::object::ID>(&mut arg0.active_assistants, 0x2::object::id<0x823642674a8ea1b44355c320af2992081cf3b75221b336abe7a7b32f09b34574::authority::AuthorityCap<0x823642674a8ea1b44355c320af2992081cf3b75221b336abe7a7b32f09b34574::authority::PACKAGE, 0x823642674a8ea1b44355c320af2992081cf3b75221b336abe7a7b32f09b34574::authority::ASSISTANT>>(&v0));
        v0
    }

    public fun revoke_assistant_cap(arg0: &mut Config, arg1: &0x823642674a8ea1b44355c320af2992081cf3b75221b336abe7a7b32f09b34574::authority::AuthorityCap<0x823642674a8ea1b44355c320af2992081cf3b75221b336abe7a7b32f09b34574::authority::PACKAGE, 0x823642674a8ea1b44355c320af2992081cf3b75221b336abe7a7b32f09b34574::authority::ADMIN>, arg2: 0x2::object::ID) {
        assert_package_version(arg0);
        let v0 = &arg0.active_assistants;
        let v1 = 0;
        let v2;
        while (v1 < 0x1::vector::length<0x2::object::ID>(v0)) {
            if (0x1::vector::borrow<0x2::object::ID>(v0, v1) == &arg2) {
                v2 = 0x1::option::some<u64>(v1);
                /* label 6 */
                assert!(0x1::option::is_some<u64>(&v2), 3);
                0x1::vector::remove<0x2::object::ID>(&mut arg0.active_assistants, 0x1::option::extract<u64>(&mut v2));
                return
            };
            v1 = v1 + 1;
        };
        v2 = 0x1::option::none<u64>();
        /* goto 6 */
    }

    // decompiled from Move bytecode v6
}

