module 0xd8646fb1f9d1d0fe75db886ac7e6d581db33cbc63916dfa6d1f7536b61bb28c2::config {
    struct Config has store, key {
        id: 0x2::object::UID,
        version: u64,
        active_assistant: 0x2::object::ID,
    }

    public(friend) fun assert_authority_cap_is_valid<T0>(arg0: &Config, arg1: &0xd8646fb1f9d1d0fe75db886ac7e6d581db33cbc63916dfa6d1f7536b61bb28c2::authority::AuthorityCap<0xd8646fb1f9d1d0fe75db886ac7e6d581db33cbc63916dfa6d1f7536b61bb28c2::authority::PACKAGE, T0>) {
        assert!(authority_cap_is_valid<T0>(arg0, arg1), 13835621610826235909);
    }

    public(friend) fun assert_correct_version(arg0: &Config) {
        assert!(arg0.version == 1, 13835058622217846785);
    }

    public fun authority_cap_is_valid<T0>(arg0: &Config, arg1: &0xd8646fb1f9d1d0fe75db886ac7e6d581db33cbc63916dfa6d1f7536b61bb28c2::authority::AuthorityCap<0xd8646fb1f9d1d0fe75db886ac7e6d581db33cbc63916dfa6d1f7536b61bb28c2::authority::PACKAGE, T0>) : bool {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        0xd8646fb1f9d1d0fe75db886ac7e6d581db33cbc63916dfa6d1f7536b61bb28c2::authority::is_admin(v0) || 0xd8646fb1f9d1d0fe75db886ac7e6d581db33cbc63916dfa6d1f7536b61bb28c2::authority::is_assistant(v0) && arg0.active_assistant == 0x2::object::id<0xd8646fb1f9d1d0fe75db886ac7e6d581db33cbc63916dfa6d1f7536b61bb28c2::authority::AuthorityCap<0xd8646fb1f9d1d0fe75db886ac7e6d581db33cbc63916dfa6d1f7536b61bb28c2::authority::PACKAGE, T0>>(arg1)
    }

    public(friend) fun create_config_and_share<T0: drop>(arg0: &T0, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::types::is_one_time_witness<T0>(arg0), 13835339800841945091);
        let v0 = Config{
            id               : 0x2::object::new(arg1),
            version          : 1,
            active_assistant : 0x2::object::id_from_address(@0x0),
        };
        0x2::transfer::share_object<Config>(v0);
    }

    public fun current_version() : u64 {
        1
    }

    public fun rotate_assistant_cap(arg0: &mut Config, arg1: &0xd8646fb1f9d1d0fe75db886ac7e6d581db33cbc63916dfa6d1f7536b61bb28c2::authority::AuthorityCap<0xd8646fb1f9d1d0fe75db886ac7e6d581db33cbc63916dfa6d1f7536b61bb28c2::authority::PACKAGE, 0xd8646fb1f9d1d0fe75db886ac7e6d581db33cbc63916dfa6d1f7536b61bb28c2::authority::ADMIN>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xd8646fb1f9d1d0fe75db886ac7e6d581db33cbc63916dfa6d1f7536b61bb28c2::authority::create_package_assistant_cap(arg3);
        arg0.active_assistant = 0x2::object::id<0xd8646fb1f9d1d0fe75db886ac7e6d581db33cbc63916dfa6d1f7536b61bb28c2::authority::AuthorityCap<0xd8646fb1f9d1d0fe75db886ac7e6d581db33cbc63916dfa6d1f7536b61bb28c2::authority::PACKAGE, 0xd8646fb1f9d1d0fe75db886ac7e6d581db33cbc63916dfa6d1f7536b61bb28c2::authority::ASSISTANT>>(&v0);
        0x2::transfer::public_transfer<0xd8646fb1f9d1d0fe75db886ac7e6d581db33cbc63916dfa6d1f7536b61bb28c2::authority::AuthorityCap<0xd8646fb1f9d1d0fe75db886ac7e6d581db33cbc63916dfa6d1f7536b61bb28c2::authority::PACKAGE, 0xd8646fb1f9d1d0fe75db886ac7e6d581db33cbc63916dfa6d1f7536b61bb28c2::authority::ASSISTANT>>(v0, arg2);
    }

    public fun upgrade_version(arg0: &mut Config, arg1: &0xd8646fb1f9d1d0fe75db886ac7e6d581db33cbc63916dfa6d1f7536b61bb28c2::authority::AuthorityCap<0xd8646fb1f9d1d0fe75db886ac7e6d581db33cbc63916dfa6d1f7536b61bb28c2::authority::PACKAGE, 0xd8646fb1f9d1d0fe75db886ac7e6d581db33cbc63916dfa6d1f7536b61bb28c2::authority::ADMIN>) {
        assert!(arg0.version == 1 - 1, 13835058489073860609);
        arg0.version = 1;
    }

    // decompiled from Move bytecode v6
}

