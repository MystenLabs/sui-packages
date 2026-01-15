module 0x2::address_alias {
    struct AddressAliasState has key {
        id: 0x2::object::UID,
        version: u64,
    }

    struct AddressAliases has key {
        id: 0x2::object::UID,
        aliases: 0x2::vec_set::VecSet<address>,
    }

    struct AliasKey has copy, drop, store {
        pos0: address,
    }

    entry fun add(arg0: &mut AddressAliases, arg1: address) {
        assert!(!0x2::vec_set::contains<address>(&arg0.aliases, &arg1), 13835621361718132741);
        0x2::vec_set::insert<address>(&mut arg0.aliases, arg1);
        assert!(0x2::vec_set::length<address>(&arg0.aliases) <= 8, 13836184320261750793);
    }

    fun create(arg0: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg0) == @0x0, 13835058231375822849);
        let v0 = AddressAliasState{
            id      : 0x2::object::address_alias_state(),
            version : 0,
        };
        0x2::transfer::share_object<AddressAliasState>(v0);
    }

    entry fun enable(arg0: &mut AddressAliasState, arg1: &0x2::tx_context::TxContext) {
        let v0 = AliasKey{pos0: 0x2::tx_context::sender(arg1)};
        assert!(!0x2::derived_object::exists<AliasKey>(&arg0.id, v0), 13835621305883557893);
        let v1 = AliasKey{pos0: 0x2::tx_context::sender(arg1)};
        let v2 = AddressAliases{
            id      : 0x2::derived_object::claim<AliasKey>(&mut arg0.id, v1),
            aliases : 0x2::vec_set::singleton<address>(0x2::tx_context::sender(arg1)),
        };
        0x2::transfer::party_transfer<AddressAliases>(v2, 0x2::party::single_owner(0x2::tx_context::sender(arg1)));
    }

    entry fun remove(arg0: &mut AddressAliases, arg1: address) {
        assert!(0x2::vec_set::contains<address>(&arg0.aliases, &arg1), 13835339951165800451);
        assert!(0x2::vec_set::length<address>(&arg0.aliases) > 1, 13835902905414451207);
        0x2::vec_set::remove<address>(&mut arg0.aliases, &arg1);
    }

    entry fun replace_all(arg0: &mut AddressAliases, arg1: vector<address>) {
        let v0 = 0x2::vec_set::from_keys<address>(arg1);
        assert!(0x2::vec_set::length<address>(&v0) > 0, 13835902871054712839);
        assert!(0x2::vec_set::length<address>(&v0) <= 8, 13836184350326521865);
        arg0.aliases = v0;
    }

    // decompiled from Move bytecode v6
}

