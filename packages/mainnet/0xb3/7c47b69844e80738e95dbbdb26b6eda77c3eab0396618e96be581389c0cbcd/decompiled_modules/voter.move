module 0xb37c47b69844e80738e95dbbdb26b6eda77c3eab0396618e96be581389c0cbcd::voter {
    struct Voter has store, key {
        id: 0x2::object::UID,
        cap: 0x1::option::Option<0xb37c47b69844e80738e95dbbdb26b6eda77c3eab0396618e96be581389c0cbcd::voter_cap::VoterCap>,
        balances: 0x2::bag::Bag,
    }

    public fun check_fresh(arg0: &Voter) {
        assert!(0x1::option::is_none<0xb37c47b69844e80738e95dbbdb26b6eda77c3eab0396618e96be581389c0cbcd::voter_cap::VoterCap>(&arg0.cap), 9223372122754121727);
    }

    public fun notify_reward<T0>(arg0: &mut Voter, arg1: 0x2::balance::Balance<T0>) {
        assert!(0x2::balance::value<T0>(&arg1) > 0, 9223372195768565759);
        let v0 = 0x1::type_name::get<T0>();
        if (!0x2::bag::contains<0x1::type_name::TypeName>(&arg0.balances, v0)) {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0, 0x2::balance::zero<T0>());
        };
        0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0), arg1);
    }

    public(friend) fun receive_voter_cap(arg0: &mut Voter, arg1: 0xb37c47b69844e80738e95dbbdb26b6eda77c3eab0396618e96be581389c0cbcd::voter_cap::VoterCap) {
        check_fresh(arg0);
        0x1::option::fill<0xb37c47b69844e80738e95dbbdb26b6eda77c3eab0396618e96be581389c0cbcd::voter_cap::VoterCap>(&mut arg0.cap, arg1);
    }

    public fun validate_voter_cap(arg0: &Voter, arg1: 0x2::object::ID) : bool {
        if (0x1::option::is_none<0xb37c47b69844e80738e95dbbdb26b6eda77c3eab0396618e96be581389c0cbcd::voter_cap::VoterCap>(&arg0.cap)) {
            return false
        };
        0xb37c47b69844e80738e95dbbdb26b6eda77c3eab0396618e96be581389c0cbcd::voter_cap::get_gauger_id(0x1::option::borrow<0xb37c47b69844e80738e95dbbdb26b6eda77c3eab0396618e96be581389c0cbcd::voter_cap::VoterCap>(&arg0.cap)) == arg1
    }

    // decompiled from Move bytecode v6
}

