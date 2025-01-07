module 0x89f0a1481600ea5efde8da94fc33277341b6192ffc4366d168e9bd54ea6dfbd6::reward_drop {
    struct RewardDrop<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        rewards: 0x2::table_vec::TableVec<0x89f0a1481600ea5efde8da94fc33277341b6192ffc4366d168e9bd54ea6dfbd6::reward::Reward<T0, T1>>,
    }

    public fun new<T0, T1>(arg0: &0x89f0a1481600ea5efde8da94fc33277341b6192ffc4366d168e9bd54ea6dfbd6::ticketing::TicketTypeProof<T0>, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: vector<0x89f0a1481600ea5efde8da94fc33277341b6192ffc4366d168e9bd54ea6dfbd6::trait::Trait>, arg6: 0x1::string::String, arg7: u16, arg8: &0x2::clock::Clock, arg9: address, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x89f0a1481600ea5efde8da94fc33277341b6192ffc4366d168e9bd54ea6dfbd6::event_type::all();
        let v1 = 0x1::type_name::get<T1>();
        assert!(0x1::vector::contains<0x1::type_name::TypeName>(&v0, &v1), 0);
        let v2 = 0x2::table_vec::empty<0x89f0a1481600ea5efde8da94fc33277341b6192ffc4366d168e9bd54ea6dfbd6::reward::Reward<T0, T1>>(arg10);
        let v3 = 0;
        while (v3 < arg7) {
            v3 = v3 + 1;
            let v4 = 0x2::linked_table::new<0x1::string::String, 0x89f0a1481600ea5efde8da94fc33277341b6192ffc4366d168e9bd54ea6dfbd6::trait::Trait>(arg10);
            let v5 = 0;
            while (v5 < 0x1::vector::length<0x89f0a1481600ea5efde8da94fc33277341b6192ffc4366d168e9bd54ea6dfbd6::trait::Trait>(&arg5)) {
                let v6 = *0x1::vector::borrow<0x89f0a1481600ea5efde8da94fc33277341b6192ffc4366d168e9bd54ea6dfbd6::trait::Trait>(&arg5, v5);
                0x2::linked_table::push_back<0x1::string::String, 0x89f0a1481600ea5efde8da94fc33277341b6192ffc4366d168e9bd54ea6dfbd6::trait::Trait>(&mut v4, *0x89f0a1481600ea5efde8da94fc33277341b6192ffc4366d168e9bd54ea6dfbd6::trait::name(&v6), v6);
                v5 = v5 + 1;
            };
            0x2::table_vec::push_back<0x89f0a1481600ea5efde8da94fc33277341b6192ffc4366d168e9bd54ea6dfbd6::reward::Reward<T0, T1>>(&mut v2, 0x89f0a1481600ea5efde8da94fc33277341b6192ffc4366d168e9bd54ea6dfbd6::reward::new<T0, T1>(arg1, arg2, arg3, arg4, v4, arg6, 0x2::clock::timestamp_ms(arg8), arg9, arg10));
        };
        let v7 = RewardDrop<T0, T1>{
            id      : 0x2::object::new(arg10),
            rewards : v2,
        };
        0x2::transfer::share_object<RewardDrop<T0, T1>>(v7);
    }

    public fun delete<T0, T1>(arg0: &0x89f0a1481600ea5efde8da94fc33277341b6192ffc4366d168e9bd54ea6dfbd6::ticketing::TicketTypeProof<T0>, arg1: RewardDrop<T0, T1>) {
        let RewardDrop {
            id      : v0,
            rewards : v1,
        } = arg1;
        let v2 = v1;
        while (!0x2::table_vec::is_empty<0x89f0a1481600ea5efde8da94fc33277341b6192ffc4366d168e9bd54ea6dfbd6::reward::Reward<T0, T1>>(&v2)) {
            0x89f0a1481600ea5efde8da94fc33277341b6192ffc4366d168e9bd54ea6dfbd6::reward::delete<T0, T1>(0x2::table_vec::pop_back<0x89f0a1481600ea5efde8da94fc33277341b6192ffc4366d168e9bd54ea6dfbd6::reward::Reward<T0, T1>>(&mut v2));
        };
        0x2::table_vec::destroy_empty<0x89f0a1481600ea5efde8da94fc33277341b6192ffc4366d168e9bd54ea6dfbd6::reward::Reward<T0, T1>>(v2);
        0x2::object::delete(v0);
    }

    public fun claim<T0, T1>(arg0: &0x89f0a1481600ea5efde8da94fc33277341b6192ffc4366d168e9bd54ea6dfbd6::core::AdminCap, arg1: &mut RewardDrop<T0, T1>) : 0x89f0a1481600ea5efde8da94fc33277341b6192ffc4366d168e9bd54ea6dfbd6::reward::Reward<T0, T1> {
        0x2::table_vec::pop_back<0x89f0a1481600ea5efde8da94fc33277341b6192ffc4366d168e9bd54ea6dfbd6::reward::Reward<T0, T1>>(&mut arg1.rewards)
    }

    // decompiled from Move bytecode v6
}

