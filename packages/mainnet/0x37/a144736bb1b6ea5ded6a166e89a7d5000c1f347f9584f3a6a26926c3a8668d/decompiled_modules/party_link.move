module 0x37a144736bb1b6ea5ded6a166e89a7d5000c1f347f9584f3a6a26926c3a8668d::party_link {
    struct PartyLinks has drop {
        entries: 0x2::vec_map::VecMap<0x1::type_name::TypeName, vector<u8>>,
    }

    struct PartyLinkEntry has copy, drop {
        platform: 0x1::string::String,
        data: vector<u8>,
    }

    struct PartyLinksKey has copy, drop, store {
        dummy_field: bool,
    }

    struct PartyLinksSetEvent has copy, drop {
        party_id: 0x2::object::ID,
        links: vector<PartyLinkEntry>,
    }

    struct PartyLinksClearedEvent has copy, drop {
        party_id: 0x2::object::ID,
    }

    public fun add<T0: drop>(arg0: &mut PartyLinks, arg1: T0, arg2: vector<u8>) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(!0x2::vec_map::contains<0x1::type_name::TypeName, vector<u8>>(&arg0.entries, &v0), 3);
        assert!(0x2::vec_map::length<0x1::type_name::TypeName, vector<u8>>(&arg0.entries) < 50, 0);
        assert!(!0x1::vector::is_empty<u8>(&arg2), 1);
        assert!(0x1::vector::length<u8>(&arg2) <= 2048, 2);
        0x2::vec_map::insert<0x1::type_name::TypeName, vector<u8>>(&mut arg0.entries, v0, arg2);
    }

    public fun links(arg0: &0xb11906f9134cc6a0035febbe807465dbf125ddd4c1258cc1e64c78a1506c8e81::party::Party) : 0x2::vec_map::VecMap<0x1::type_name::TypeName, vector<u8>> {
        let v0 = PartyLinksKey{dummy_field: false};
        if (0x2::dynamic_field::exists<PartyLinksKey>(0xb11906f9134cc6a0035febbe807465dbf125ddd4c1258cc1e64c78a1506c8e81::party::uid(arg0), v0)) {
            let v2 = PartyLinksKey{dummy_field: false};
            *0x2::dynamic_field::borrow<PartyLinksKey, 0x2::vec_map::VecMap<0x1::type_name::TypeName, vector<u8>>>(0xb11906f9134cc6a0035febbe807465dbf125ddd4c1258cc1e64c78a1506c8e81::party::uid(arg0), v2)
        } else {
            0x2::vec_map::empty<0x1::type_name::TypeName, vector<u8>>()
        }
    }

    public fun new() : PartyLinks {
        PartyLinks{entries: 0x2::vec_map::empty<0x1::type_name::TypeName, vector<u8>>()}
    }

    public fun set_links(arg0: &mut 0xb11906f9134cc6a0035febbe807465dbf125ddd4c1258cc1e64c78a1506c8e81::party::Party, arg1: &0xb11906f9134cc6a0035febbe807465dbf125ddd4c1258cc1e64c78a1506c8e81::party::PartyAdminCap, arg2: PartyLinks) {
        let PartyLinks { entries: v0 } = arg2;
        let v1 = 0xb11906f9134cc6a0035febbe807465dbf125ddd4c1258cc1e64c78a1506c8e81::party::uid_mut(arg0, arg1);
        let v2 = PartyLinksKey{dummy_field: false};
        if (0x2::vec_map::is_empty<0x1::type_name::TypeName, vector<u8>>(&v0)) {
            if (0x2::dynamic_field::exists<PartyLinksKey>(v1, v2)) {
                let v3 = PartyLinksKey{dummy_field: false};
                0x2::dynamic_field::remove<PartyLinksKey, 0x2::vec_map::VecMap<0x1::type_name::TypeName, vector<u8>>>(v1, v3);
                let v4 = PartyLinksClearedEvent{party_id: 0x2::object::id<0xb11906f9134cc6a0035febbe807465dbf125ddd4c1258cc1e64c78a1506c8e81::party::Party>(arg0)};
                0x2::event::emit<PartyLinksClearedEvent>(v4);
            };
            return
        };
        if (0x2::dynamic_field::exists<PartyLinksKey>(v1, v2)) {
            let v5 = PartyLinksKey{dummy_field: false};
            let v6 = 0x2::dynamic_field::borrow_mut<PartyLinksKey, 0x2::vec_map::VecMap<0x1::type_name::TypeName, vector<u8>>>(v1, v5);
            let (v7, v8) = 0x2::vec_map::into_keys_values<0x1::type_name::TypeName, vector<u8>>(*v6);
            let (v9, v10) = 0x2::vec_map::into_keys_values<0x1::type_name::TypeName, vector<u8>>(v0);
            if (v7 == v9 && v8 == v10) {
                return
            };
            *v6 = v0;
        } else {
            let v11 = PartyLinksKey{dummy_field: false};
            0x2::dynamic_field::add<PartyLinksKey, 0x2::vec_map::VecMap<0x1::type_name::TypeName, vector<u8>>>(v1, v11, v0);
        };
        let v12 = 0x1::vector::empty<PartyLinkEntry>();
        let v13 = 0;
        while (v13 < 0x2::vec_map::length<0x1::type_name::TypeName, vector<u8>>(&v0)) {
            let (v14, v15) = 0x2::vec_map::get_entry_by_idx<0x1::type_name::TypeName, vector<u8>>(&v0, v13);
            let v16 = PartyLinkEntry{
                platform : 0x1::string::from_ascii(0x1::type_name::into_string(*v14)),
                data     : *v15,
            };
            0x1::vector::push_back<PartyLinkEntry>(&mut v12, v16);
            v13 = v13 + 1;
        };
        let v17 = PartyLinksSetEvent{
            party_id : 0x2::object::id<0xb11906f9134cc6a0035febbe807465dbf125ddd4c1258cc1e64c78a1506c8e81::party::Party>(arg0),
            links    : v12,
        };
        0x2::event::emit<PartyLinksSetEvent>(v17);
    }

    // decompiled from Move bytecode v7
}

