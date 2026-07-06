module 0xc79d01572bfa9dcc5ab24ef658dc0f027cae9ccfe8ceec1746f0ec998afb72d0::config {
    struct Config has store, key {
        id: 0x2::object::UID,
        version: u64,
        active_assistants: vector<0x2::object::ID>,
    }

    public(friend) fun new<T0: drop>(arg0: &T0, arg1: &mut 0x2::tx_context::TxContext) : Config {
        assert!(0x2::types::is_one_time_witness<T0>(arg0), 13835339809431879683);
        Config{
            id                : 0x2::object::new(arg1),
            version           : 1,
            active_assistants : 0x1::vector::empty<0x2::object::ID>(),
        }
    }

    public fun active_assistants(arg0: &Config) : vector<0x2::object::ID> {
        arg0.active_assistants
    }

    public(friend) fun assert_authority_cap_is_valid<T0>(arg0: &Config, arg1: &0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0xc79d01572bfa9dcc5ab24ef658dc0f027cae9ccfe8ceec1746f0ec998afb72d0::authority::PACKAGE, T0>) {
        assert!(authority_cap_is_valid<T0>(arg0, arg1), 13835621812689698821);
    }

    public(friend) fun assert_correct_version(arg0: &Config) {
        assert!(arg0.version == 1, 13835058824081309697);
    }

    public fun authority_cap_is_valid<T0>(arg0: &Config, arg1: &0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0xc79d01572bfa9dcc5ab24ef658dc0f027cae9ccfe8ceec1746f0ec998afb72d0::authority::PACKAGE, T0>) : bool {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (v0 == 0x1::type_name::with_defining_ids<0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::ADMIN>()) {
            true
        } else if (v0 == 0x1::type_name::with_defining_ids<0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::ASSISTANT>()) {
            let v2 = 0x2::object::id<0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0xc79d01572bfa9dcc5ab24ef658dc0f027cae9ccfe8ceec1746f0ec998afb72d0::authority::PACKAGE, T0>>(arg1);
            0x1::vector::contains<0x2::object::ID>(&arg0.active_assistants, &v2)
        } else {
            false
        }
    }

    public(friend) fun borrow_mut_id(arg0: &mut Config) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    public fun current_version() : u64 {
        1
    }

    public fun new_package_assistant_cap(arg0: &mut Config, arg1: &0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0xc79d01572bfa9dcc5ab24ef658dc0f027cae9ccfe8ceec1746f0ec998afb72d0::authority::PACKAGE, 0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::ADMIN>, arg2: &mut 0x2::tx_context::TxContext) : 0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0xc79d01572bfa9dcc5ab24ef658dc0f027cae9ccfe8ceec1746f0ec998afb72d0::authority::PACKAGE, 0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::ASSISTANT> {
        assert_correct_version(arg0);
        let v0 = 0xc79d01572bfa9dcc5ab24ef658dc0f027cae9ccfe8ceec1746f0ec998afb72d0::authority::create_multiton_package_assistant_cap(&mut arg0.id, arg2);
        0x1::vector::push_back<0x2::object::ID>(&mut arg0.active_assistants, 0x2::object::id<0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0xc79d01572bfa9dcc5ab24ef658dc0f027cae9ccfe8ceec1746f0ec998afb72d0::authority::PACKAGE, 0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::ASSISTANT>>(&v0));
        v0
    }

    public fun revoke_package_assistant_cap(arg0: &mut Config, arg1: &0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0xc79d01572bfa9dcc5ab24ef658dc0f027cae9ccfe8ceec1746f0ec998afb72d0::authority::PACKAGE, 0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::ADMIN>, arg2: 0x2::object::ID) {
        assert_correct_version(arg0);
        let v0 = &arg0.active_assistants;
        let v1 = 0;
        let v2;
        while (v1 < 0x1::vector::length<0x2::object::ID>(v0)) {
            if (0x1::vector::borrow<0x2::object::ID>(v0, v1) == &arg2) {
                v2 = 0x1::option::some<u64>(v1);
                /* label 6 */
                assert!(0x1::option::is_some<u64>(&v2), 13835903090098044935);
                0x1::vector::remove<0x2::object::ID>(&mut arg0.active_assistants, 0x1::option::destroy_some<u64>(v2));
                return
            };
            v1 = v1 + 1;
        };
        v2 = 0x1::option::none<u64>();
        /* goto 6 */
    }

    public fun upgrade_version<T0>(arg0: &mut Config, arg1: &0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0xc79d01572bfa9dcc5ab24ef658dc0f027cae9ccfe8ceec1746f0ec998afb72d0::authority::PACKAGE, T0>) {
        assert!(arg0.version < 1, 13835058746771898369);
        0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::assert_is_admin_or_assistant<T0>();
        assert_authority_cap_is_valid<T0>(arg0, arg1);
        arg0.version = 1;
    }

    // decompiled from Move bytecode v7
}

