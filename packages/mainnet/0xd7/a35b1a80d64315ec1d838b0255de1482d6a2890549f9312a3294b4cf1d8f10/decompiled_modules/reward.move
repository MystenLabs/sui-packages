module 0x89f0a1481600ea5efde8da94fc33277341b6192ffc4366d168e9bd54ea6dfbd6::reward {
    struct Reward<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        title: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        external_url: 0x1::string::String,
        attributes: 0x2::linked_table::LinkedTable<0x1::string::String, 0x89f0a1481600ea5efde8da94fc33277341b6192ffc4366d168e9bd54ea6dfbd6::trait::Trait>,
        edition: 0x1::string::String,
        creator: address,
        creation_date: u64,
    }

    public fun delete<T0, T1>(arg0: Reward<T0, T1>) {
        let Reward {
            id            : v0,
            title         : _,
            description   : _,
            image_url     : _,
            external_url  : _,
            attributes    : v5,
            edition       : _,
            creator       : _,
            creation_date : _,
        } = arg0;
        0x2::object::delete(v0);
        0x2::linked_table::drop<0x1::string::String, 0x89f0a1481600ea5efde8da94fc33277341b6192ffc4366d168e9bd54ea6dfbd6::trait::Trait>(v5);
    }

    public(friend) fun new<T0, T1>(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x2::linked_table::LinkedTable<0x1::string::String, 0x89f0a1481600ea5efde8da94fc33277341b6192ffc4366d168e9bd54ea6dfbd6::trait::Trait>, arg5: 0x1::string::String, arg6: u64, arg7: address, arg8: &mut 0x2::tx_context::TxContext) : Reward<T0, T1> {
        Reward<T0, T1>{
            id            : 0x2::object::new(arg8),
            title         : arg0,
            description   : arg1,
            image_url     : arg2,
            external_url  : arg3,
            attributes    : arg4,
            edition       : arg5,
            creator       : arg7,
            creation_date : arg6,
        }
    }

    public fun new_display<T0, T1>(arg0: &0x89f0a1481600ea5efde8da94fc33277341b6192ffc4366d168e9bd54ea6dfbd6::ticketing::TicketTypeProof<T0>, arg1: &0x89f0a1481600ea5efde8da94fc33277341b6192ffc4366d168e9bd54ea6dfbd6::ticketing::Registry, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x89f0a1481600ea5efde8da94fc33277341b6192ffc4366d168e9bd54ea6dfbd6::event_type::all();
        let v1 = 0x1::type_name::get<T1>();
        assert!(0x1::vector::contains<0x1::type_name::TypeName>(&v0, &v1), 1);
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"title"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"image_url"));
        let v4 = 0x1::vector::empty<0x1::string::String>();
        let v5 = &mut v4;
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{title}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{image_url}"));
        let v6 = 0x2::display::new_with_fields<Reward<T0, T1>>(0x89f0a1481600ea5efde8da94fc33277341b6192ffc4366d168e9bd54ea6dfbd6::ticketing::publisher(arg1), v2, v4, arg2);
        0x2::display::update_version<Reward<T0, T1>>(&mut v6);
        0x2::transfer::public_transfer<0x2::display::Display<Reward<T0, T1>>>(v6, 0x2::tx_context::sender(arg2));
    }

    public fun new_transfer_policy<T0, T1>(arg0: &0x89f0a1481600ea5efde8da94fc33277341b6192ffc4366d168e9bd54ea6dfbd6::ticketing::TicketTypeProof<T0>, arg1: &0x89f0a1481600ea5efde8da94fc33277341b6192ffc4366d168e9bd54ea6dfbd6::ticketing::Registry, arg2: &mut 0x2::tx_context::TxContext) : (0x2::transfer_policy::TransferPolicy<Reward<T0, T1>>, 0x2::transfer_policy::TransferPolicyCap<Reward<T0, T1>>) {
        let v0 = 0x89f0a1481600ea5efde8da94fc33277341b6192ffc4366d168e9bd54ea6dfbd6::event_type::all();
        let v1 = 0x1::type_name::get<T1>();
        assert!(0x1::vector::contains<0x1::type_name::TypeName>(&v0, &v1), 1);
        0x2::transfer_policy::new<Reward<T0, T1>>(0x89f0a1481600ea5efde8da94fc33277341b6192ffc4366d168e9bd54ea6dfbd6::ticketing::publisher(arg1), arg2)
    }

    // decompiled from Move bytecode v6
}

