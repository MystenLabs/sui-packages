module 0xbbf6fbfce5d0c517cc2d8b921424edcf00f578343861e00e0e6801b7cb0db2bf::fixer {
    struct Ticket has copy, drop {
        token_id: u64,
        attributes_names: vector<0x1::ascii::String>,
        attributes_values: vector<0x1::ascii::String>,
    }

    struct TokenSlice has store {
        from: u64,
        to: u64,
    }

    struct TokenField has store, key {
        id: 0x2::object::UID,
        gen_mode: u8,
        balance: u64,
        supply: u64,
        slices: 0x2::table::Table<u64, TokenSlice>,
    }

    struct FieldSlice has copy, drop, store {
        balance: u64,
        supply: u64,
        prefix: 0x1::ascii::String,
        value: 0x1::ascii::String,
        suffix: 0x1::ascii::String,
        from: u64,
        to: u64,
    }

    struct Field has store, key {
        id: 0x2::object::UID,
        name: 0x1::ascii::String,
        gen_mode: u8,
        slices: 0x2::table::Table<u64, FieldSlice>,
    }

    struct AddFixerWhitelistEvent has copy, drop {
        fixer: 0x2::object::ID,
        roots: vector<address>,
    }

    struct RemoveFixerWhitelistEvent has copy, drop {
        fixer: 0x2::object::ID,
        roots: vector<address>,
    }

    struct Fixer has store, key {
        id: 0x2::object::UID,
        version: u64,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::ascii::String,
        project_url: 0x1::string::String,
        link: 0x1::string::String,
        token_id: 0x1::option::Option<TokenField>,
        mystery_box_attributes: 0x2::table::Table<0x1::ascii::String, Field>,
        mystery_box_attributes_names: vector<0x1::ascii::String>,
        attributes: 0x2::table::Table<0x1::ascii::String, Field>,
        attributes_names: vector<0x1::ascii::String>,
        whitelists: 0x2::table::Table<address, bool>,
        balance: u64,
        supply: u64,
    }

    public fun add_attribute(arg0: &mut Fixer, arg1: bool, arg2: 0x1::ascii::String, arg3: u8, arg4: vector<u64>, arg5: vector<0x1::ascii::String>, arg6: vector<0x1::ascii::String>, arg7: vector<0x1::ascii::String>, arg8: vector<u64>, arg9: vector<u64>, arg10: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0);
        let (v0, v1) = if (arg1) {
            let v1 = &mut arg0.mystery_box_attributes_names;
            (&mut arg0.mystery_box_attributes, v1)
        } else {
            let v1 = &mut arg0.attributes_names;
            (&mut arg0.attributes, v1)
        };
        if (!0x2::table::contains<0x1::ascii::String, Field>(v0, arg2)) {
            0x1::vector::push_back<0x1::ascii::String>(v1, arg2);
            let v2 = Field{
                id       : 0x2::object::new(arg10),
                name     : arg2,
                gen_mode : arg3,
                slices   : 0x2::table::new<u64, FieldSlice>(arg10),
            };
            0x2::table::add<0x1::ascii::String, Field>(v0, arg2, v2);
        };
        let v3 = 0x2::table::borrow_mut<0x1::ascii::String, Field>(v0, arg2);
        assert!(v3.gen_mode == arg3, 10005);
        let v4 = 0;
        while (v4 < 0x1::vector::length<u64>(&arg4)) {
            let v5 = FieldSlice{
                balance : 0,
                supply  : *0x1::vector::borrow<u64>(&arg4, v4),
                prefix  : *0x1::vector::borrow<0x1::ascii::String>(&arg5, v4),
                value   : *0x1::vector::borrow<0x1::ascii::String>(&arg6, v4),
                suffix  : *0x1::vector::borrow<0x1::ascii::String>(&arg7, v4),
                from    : *0x1::vector::borrow<u64>(&arg8, v4),
                to      : *0x1::vector::borrow<u64>(&arg9, v4),
            };
            0x2::table::add<u64, FieldSlice>(&mut v3.slices, 0x2::table::length<u64, FieldSlice>(&v3.slices), v5);
            v4 = v4 + 1;
        };
    }

    public fun add_whitelist(arg0: &mut Fixer, arg1: vector<address>) {
        assert_version(arg0);
        let v0 = 0;
        let v1 = 0x1::vector::empty<address>();
        while (v0 < 0x1::vector::length<address>(&arg1)) {
            let v2 = *0x1::vector::borrow<address>(&arg1, v0);
            if (!0x2::table::contains<address, bool>(&arg0.whitelists, v2)) {
                0x1::vector::push_back<address>(&mut v1, v2);
                0x2::table::add<address, bool>(&mut arg0.whitelists, v2, true);
            };
            v0 = v0 + 1;
        };
        let v3 = AddFixerWhitelistEvent{
            fixer : 0x2::object::id<Fixer>(arg0),
            roots : v1,
        };
        0x2::event::emit<AddFixerWhitelistEvent>(v3);
    }

    fun assert_version(arg0: &Fixer) {
        assert!(arg0.version == 1, 10001);
    }

    public fun assert_whitelist(arg0: &Fixer, arg1: u64, arg2: vector<0x1::ascii::String>, arg3: vector<0x1::ascii::String>, arg4: vector<address>) {
        assert!(contains_whitelist(arg0, generate_merkle_root(arg1, arg2, arg3, arg4)), 10007);
    }

    public fun borrow_attribute(arg0: &Fixer, arg1: bool, arg2: 0x1::ascii::String) : &Field {
        if (arg1) {
            0x2::table::borrow<0x1::ascii::String, Field>(&arg0.mystery_box_attributes, arg2)
        } else {
            0x2::table::borrow<0x1::ascii::String, Field>(&arg0.attributes, arg2)
        }
    }

    public fun borrow_attributes(arg0: &Fixer) : &0x2::table::Table<0x1::ascii::String, Field> {
        &arg0.attributes
    }

    public fun borrow_attributes_names(arg0: &Fixer) : &vector<0x1::ascii::String> {
        &arg0.attributes_names
    }

    public fun borrow_balance(arg0: &Fixer) : &u64 {
        &arg0.balance
    }

    public fun borrow_description(arg0: &Fixer) : &0x1::string::String {
        &arg0.description
    }

    public fun borrow_image_url(arg0: &Fixer) : &0x1::ascii::String {
        &arg0.image_url
    }

    public fun borrow_link(arg0: &Fixer) : &0x1::string::String {
        &arg0.link
    }

    public fun borrow_mut_attribute(arg0: &mut Fixer, arg1: bool, arg2: 0x1::ascii::String) : &mut Field {
        assert_version(arg0);
        if (arg1) {
            0x2::table::borrow_mut<0x1::ascii::String, Field>(&mut arg0.mystery_box_attributes, arg2)
        } else {
            0x2::table::borrow_mut<0x1::ascii::String, Field>(&mut arg0.attributes, arg2)
        }
    }

    public fun borrow_mut_attributes(arg0: &mut Fixer) : &mut 0x2::table::Table<0x1::ascii::String, Field> {
        assert_version(arg0);
        &mut arg0.attributes
    }

    public fun borrow_mut_attributes_names(arg0: &mut Fixer) : &mut vector<0x1::ascii::String> {
        assert_version(arg0);
        &mut arg0.attributes_names
    }

    public fun borrow_mut_balance(arg0: &mut Fixer) : &mut u64 {
        assert_version(arg0);
        &mut arg0.balance
    }

    public fun borrow_mut_description(arg0: &mut Fixer) : &mut 0x1::string::String {
        assert_version(arg0);
        &mut arg0.description
    }

    public fun borrow_mut_image_url(arg0: &mut Fixer) : &mut 0x1::ascii::String {
        assert_version(arg0);
        &mut arg0.image_url
    }

    public fun borrow_mut_link(arg0: &mut Fixer) : &mut 0x1::string::String {
        assert_version(arg0);
        &mut arg0.link
    }

    public fun borrow_mut_mystery_box_attributes(arg0: &mut Fixer) : &mut 0x2::table::Table<0x1::ascii::String, Field> {
        assert_version(arg0);
        &mut arg0.mystery_box_attributes
    }

    public fun borrow_mut_mystery_box_attributes_names(arg0: &mut Fixer) : &mut vector<0x1::ascii::String> {
        assert_version(arg0);
        &mut arg0.mystery_box_attributes_names
    }

    public fun borrow_mut_name(arg0: &mut Fixer) : &mut 0x1::string::String {
        assert_version(arg0);
        &mut arg0.name
    }

    public fun borrow_mut_project_url(arg0: &mut Fixer) : &mut 0x1::string::String {
        assert_version(arg0);
        &mut arg0.project_url
    }

    public fun borrow_mut_supply(arg0: &mut Fixer) : &mut u64 {
        assert_version(arg0);
        &mut arg0.supply
    }

    public fun borrow_mut_token_id(arg0: &mut Fixer) : &mut 0x1::option::Option<TokenField> {
        assert_version(arg0);
        &mut arg0.token_id
    }

    public fun borrow_mut_uid(arg0: &mut Fixer) : &mut 0x2::object::UID {
        assert_version(arg0);
        &mut arg0.id
    }

    public fun borrow_mut_whitelists(arg0: &mut Fixer) : &mut 0x2::table::Table<address, bool> {
        assert_version(arg0);
        &mut arg0.whitelists
    }

    public fun borrow_mystery_box_attributes(arg0: &Fixer) : &0x2::table::Table<0x1::ascii::String, Field> {
        &arg0.mystery_box_attributes
    }

    public fun borrow_mystery_box_attributes_names(arg0: &Fixer) : &vector<0x1::ascii::String> {
        &arg0.mystery_box_attributes_names
    }

    public fun borrow_name(arg0: &Fixer) : &0x1::string::String {
        &arg0.name
    }

    public fun borrow_project_url(arg0: &Fixer) : &0x1::string::String {
        &arg0.project_url
    }

    public fun borrow_supply(arg0: &Fixer) : &u64 {
        &arg0.supply
    }

    public fun borrow_token_id(arg0: &Fixer) : &0x1::option::Option<TokenField> {
        &arg0.token_id
    }

    public fun borrow_token_mode(arg0: &Fixer) : 0x1::option::Option<u8> {
        if (0x1::option::is_none<TokenField>(&arg0.token_id)) {
            0x1::option::none<u8>()
        } else {
            0x1::option::some<u8>(0x1::option::borrow<TokenField>(&arg0.token_id).gen_mode)
        }
    }

    public fun borrow_uid(arg0: &Fixer) : &0x2::object::UID {
        &arg0.id
    }

    public fun borrow_version(arg0: &Fixer) : &u64 {
        &arg0.version
    }

    public fun borrow_whitelists(arg0: &Fixer) : &0x2::table::Table<address, bool> {
        &arg0.whitelists
    }

    public fun contains_attribute(arg0: &Fixer, arg1: bool, arg2: 0x1::ascii::String) : bool {
        arg1 && 0x1::vector::contains<0x1::ascii::String>(&arg0.mystery_box_attributes_names, &arg2) || 0x1::vector::contains<0x1::ascii::String>(&arg0.attributes_names, &arg2)
    }

    public fun contains_whitelist(arg0: &Fixer, arg1: address) : bool {
        0x2::table::contains<address, bool>(&arg0.whitelists, arg1)
    }

    public fun decrease(arg0: &mut Fixer, arg1: u64) {
        assert_version(arg0);
        arg0.balance = arg0.balance - arg1;
        arg0.supply = arg0.supply - arg1;
    }

    public fun decrease_supply(arg0: &mut Fixer, arg1: u64) {
        assert_version(arg0);
        let v0 = arg0.supply - arg1;
        assert!(arg0.balance <= v0, 10004);
        arg0.supply = v0;
    }

    public fun distribute(arg0: &mut Fixer, arg1: bool) : (u64, 0x2::vec_map::VecMap<0x1::ascii::String, 0x1::ascii::String>) {
        assert_version(arg0);
        assert!(arg0.balance <= arg0.supply, 10006);
        let v0 = 0;
        let v1 = 0x2::vec_map::empty<0x1::ascii::String, 0x1::ascii::String>();
        let (v2, v3) = if (arg1) {
            let v3 = &mut arg0.mystery_box_attributes_names;
            let v2 = &mut arg0.mystery_box_attributes;
            (v2, v3)
        } else {
            let v3 = &mut arg0.attributes_names;
            let v2 = &mut arg0.attributes;
            assert!(0x1::option::is_some<TokenField>(&arg0.token_id), 10009);
            let v4 = 0x1::option::borrow_mut<TokenField>(&mut arg0.token_id);
            v0 = distribution_token(v4);
            (v2, v3)
        };
        let v5 = 0;
        while (v5 < 0x1::vector::length<0x1::ascii::String>(v3)) {
            let v6 = 0x2::table::borrow_mut<0x1::ascii::String, Field>(v2, *0x1::vector::borrow<0x1::ascii::String>(v3, v5));
            if (v6.gen_mode == 0) {
                let v7 = distribution_field(v6, 0);
                0x2::vec_map::insert<0x1::ascii::String, 0x1::ascii::String>(&mut v1, v6.name, v7);
            } else if (v6.gen_mode == 2 || v6.gen_mode == 1) {
                let v8 = distribution_field(v6, rand_num(0x2::object::uid_to_bytes(&arg0.id), arg0.supply - arg0.balance));
                0x2::vec_map::insert<0x1::ascii::String, 0x1::ascii::String>(&mut v1, v6.name, v8);
            };
            v5 = v5 + 1;
        };
        (v0, v1)
    }

    fun distribution_field(arg0: &mut Field, arg1: u64) : 0x1::ascii::String {
        if (arg0.gen_mode == 0) {
            0x2::table::borrow_mut<u64, FieldSlice>(&mut arg0.slices, 0).value
        } else {
            internal_distribution_field(arg0, arg1)
        }
    }

    fun distribution_token(arg0: &mut TokenField) : u64 {
        assert!(arg0.supply > 0, 10003);
        assert!(arg0.balance < arg0.supply, 10003);
        assert!(arg0.gen_mode == 0 || arg0.gen_mode == 1, 10008);
        let v0 = 0;
        if (arg0.gen_mode == 1) {
            v0 = rand_num(0x2::object::uid_to_bytes(&arg0.id), arg0.supply - arg0.balance);
        };
        internal_distribution_token(arg0, v0)
    }

    fun generate_merkle_root(arg0: u64, arg1: vector<0x1::ascii::String>, arg2: vector<0x1::ascii::String>, arg3: vector<address>) : address {
        let v0 = Ticket{
            token_id          : arg0,
            attributes_names  : arg1,
            attributes_values : arg2,
        };
        let v1 = 0x1::vector::empty<vector<u8>>();
        let v2 = 0;
        while (v2 < 0x1::vector::length<address>(&arg3)) {
            0x1::vector::push_back<vector<u8>>(&mut v1, 0x2::address::to_bytes(*0x1::vector::borrow<address>(&arg3, v2)));
            v2 = v2 + 1;
        };
        0x2::address::from_bytes(0x74009bf460b51d87a2742f58bbd761bb55419621d0e5e3b4ba7978a8f0a66db1::merkle_proof::process_proof(&v1, 0x1::hash::sha2_256(0x2::bcs::to_bytes<Ticket>(&v0))))
    }

    public fun increase(arg0: &mut Fixer, arg1: u64) {
        let v0 = arg0.balance + arg1;
        assert!(v0 <= arg0.supply, 10004);
        arg0.balance = v0;
    }

    public fun increase_supply(arg0: &mut Fixer, arg1: u64) {
        assert_version(arg0);
        arg0.supply = arg0.supply + arg1;
    }

    public fun init_fixer(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: 0x1::option::Option<u8>, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) : Fixer {
        let v0 = 0x1::option::none<TokenField>();
        if (0x1::option::is_some<u8>(&arg5)) {
            let v1 = init_token_field(*0x1::option::borrow<u8>(&arg5), 0, arg6, arg7);
            0x1::option::fill<TokenField>(&mut v0, v1);
        };
        Fixer{
            id                           : 0x2::object::new(arg7),
            version                      : 1,
            name                         : 0x1::string::utf8(arg0),
            description                  : 0x1::string::utf8(arg1),
            image_url                    : 0x1::ascii::string(arg2),
            project_url                  : 0x1::string::utf8(arg3),
            link                         : 0x1::string::utf8(arg4),
            token_id                     : v0,
            mystery_box_attributes       : 0x2::table::new<0x1::ascii::String, Field>(arg7),
            mystery_box_attributes_names : 0x1::vector::empty<0x1::ascii::String>(),
            attributes                   : 0x2::table::new<0x1::ascii::String, Field>(arg7),
            attributes_names             : 0x1::vector::empty<0x1::ascii::String>(),
            whitelists                   : 0x2::table::new<address, bool>(arg7),
            balance                      : 0,
            supply                       : arg6,
        }
    }

    fun init_token_field(arg0: u8, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : TokenField {
        let v0 = 0x2::table::new<u64, TokenSlice>(arg3);
        let v1 = TokenSlice{
            from : 1,
            to   : arg2,
        };
        0x2::table::add<u64, TokenSlice>(&mut v0, 0, v1);
        TokenField{
            id       : 0x2::object::new(arg3),
            gen_mode : arg0,
            balance  : arg1,
            supply   : arg2,
            slices   : v0,
        }
    }

    fun internal_distribution_field(arg0: &mut Field, arg1: u64) : 0x1::ascii::String {
        let v0 = 0x1::ascii::string(b"");
        let v1 = 0;
        let v2 = 0;
        while (v1 < 0x2::table::length<u64, FieldSlice>(&arg0.slices)) {
            let v3 = 0x2::table::borrow_mut<u64, FieldSlice>(&mut arg0.slices, v1);
            let v4 = v3.supply - v3.balance;
            if (v2 <= arg1 && arg1 < v2 + v4) {
                if (arg0.gen_mode == 1) {
                    v0 = v3.value;
                } else {
                    let v5 = 0x1::ascii::into_bytes(v3.prefix);
                    0x1::vector::append<u8>(&mut v5, 0x1::ascii::into_bytes(u128_to_string(((v3.from + arg1 % (v3.to - v3.from + 1)) as u128))));
                    0x1::vector::append<u8>(&mut v5, 0x1::ascii::into_bytes(v3.suffix));
                    v0 = 0x1::ascii::string(v5);
                };
                v3.balance = v3.balance + 1;
                break
            };
            v2 = v2 + v4;
            v1 = v1 + 1;
        };
        v0
    }

    fun internal_distribution_token(arg0: &mut TokenField, arg1: u64) : u64 {
        let v0 = 0;
        let v1 = 0x2::table::length<u64, TokenSlice>(&arg0.slices);
        let v2 = 0;
        let v3 = 0;
        while (v2 < v1) {
            let v4 = 0x2::table::borrow_mut<u64, TokenSlice>(&mut arg0.slices, v2);
            let v5 = v4.to - v4.from + 1;
            if (v3 <= arg1 && arg1 < v3 + v5) {
                let v6 = v4.from + arg1;
                v0 = v6;
                if (v5 == 1) {
                    let TokenSlice {
                        from : _,
                        to   : _,
                    } = 0x2::table::remove<u64, TokenSlice>(&mut arg0.slices, v2);
                    if (v2 < v1 - 1) {
                        0x2::table::add<u64, TokenSlice>(&mut arg0.slices, v2, 0x2::table::remove<u64, TokenSlice>(&mut arg0.slices, v1 - 1));
                        break
                    } else {
                        break
                    };
                };
                if (v6 == v4.from) {
                    v4.from = v4.from + 1;
                    break
                };
                if (v6 == v4.to) {
                    v4.to = v4.to - 1;
                    break
                } else {
                    v4.to = v6 - 1;
                    let v9 = TokenSlice{
                        from : v6 + 1,
                        to   : v4.to,
                    };
                    0x2::table::add<u64, TokenSlice>(&mut arg0.slices, v1, v9);
                    break
                };
            };
            v3 = v3 + v5;
            arg1 = arg1 - v5;
            v2 = v2 + 1;
        };
        arg0.balance = arg0.balance + 1;
        v0
    }

    public entry fun migrate(arg0: &mut Fixer) {
        assert!(arg0.version < 1, 10002);
        arg0.version = 1;
    }

    public fun modify_fixer(arg0: &mut Fixer, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>) {
        assert_version(arg0);
        arg0.name = 0x1::string::utf8(arg1);
        arg0.description = 0x1::string::utf8(arg2);
        arg0.image_url = 0x1::ascii::string(arg3);
        arg0.project_url = 0x1::string::utf8(arg4);
        arg0.link = 0x1::string::utf8(arg5);
    }

    public fun rand_num(arg0: vector<u8>, arg1: u64) : u64 {
        0x1::vector::append<u8>(&mut arg0, 0x1::bcs::to_bytes<u64>(&arg1));
        let v0 = 0x1::hash::sha3_256(0x1::hash::sha3_256(arg0));
        let v1 = 0x2::bcs::new(0x1::hash::sha3_256(v0));
        let v2 = 0x2::bcs::peel_u64(&mut v1) % arg1;
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u64>(&v2));
        let v3 = 0x2::bcs::new(0x1::hash::sha3_256(v0));
        0x2::bcs::peel_u64(&mut v3) % arg1
    }

    public fun remove_attribute(arg0: &mut Fixer, arg1: bool, arg2: 0x1::ascii::String) {
        assert_version(arg0);
        let (v0, v1) = if (arg1) {
            let v1 = &mut arg0.mystery_box_attributes_names;
            let v0 = &mut arg0.mystery_box_attributes;
            (v0, v1)
        } else {
            let v1 = &mut arg0.attributes_names;
            let v0 = &mut arg0.attributes;
            (v0, v1)
        };
        assert!(0x2::table::contains<0x1::ascii::String, Field>(v0, arg2), 10010);
        let Field {
            id       : v2,
            name     : _,
            gen_mode : _,
            slices   : v5,
        } = 0x2::table::remove<0x1::ascii::String, Field>(v0, arg2);
        0x2::object::delete(v2);
        0x2::table::drop<u64, FieldSlice>(v5);
        let (v6, v7) = 0x1::vector::index_of<0x1::ascii::String>(v1, &arg2);
        if (v6) {
            0x1::vector::remove<0x1::ascii::String>(v1, v7);
        };
    }

    public fun remove_whitelist(arg0: &mut Fixer, arg1: vector<address>) {
        assert_version(arg0);
        let v0 = 0;
        let v1 = 0x1::vector::empty<address>();
        while (v0 < 0x1::vector::length<address>(&arg1)) {
            let v2 = *0x1::vector::borrow<address>(&arg1, v0);
            if (0x2::table::contains<address, bool>(&arg0.whitelists, v2)) {
                0x1::vector::push_back<address>(&mut v1, v2);
                0x2::table::remove<address, bool>(&mut arg0.whitelists, v2);
            };
            v0 = v0 + 1;
        };
        let v3 = RemoveFixerWhitelistEvent{
            fixer : 0x2::object::id<Fixer>(arg0),
            roots : v1,
        };
        0x2::event::emit<RemoveFixerWhitelistEvent>(v3);
    }

    public fun set_token_field(arg0: &mut Fixer, arg1: u8, arg2: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0);
        if (0x1::option::is_some<TokenField>(&arg0.token_id)) {
            let v0 = 0x1::option::borrow_mut<TokenField>(&mut arg0.token_id);
            assert!(arg0.supply > v0.supply, 10004);
            let v1 = &mut v0.slices;
            let v2 = TokenSlice{
                from : v0.supply + 1,
                to   : arg0.supply,
            };
            0x2::table::add<u64, TokenSlice>(v1, 0x2::table::length<u64, TokenSlice>(&v0.slices), v2);
            v0.supply = arg0.supply;
        } else {
            0x1::option::fill<TokenField>(&mut arg0.token_id, init_token_field(arg1, 0, arg0.supply, arg2));
        };
    }

    public fun to_url(arg0: 0x1::ascii::String, arg1: u64) : 0x1::ascii::String {
        let v0 = 46;
        let v1 = 47;
        let v2 = 0x1::string::from_ascii(arg0);
        let v3 = 0x1::string::utf8(b"");
        let v4 = &mut v3;
        let v5 = 0x1::string::length(&v2);
        let v6 = 0x1::string::utf8(b"{");
        let v7 = 0x1::string::utf8(b"}");
        let v8 = 0x1::string::index_of(&v2, &v7);
        if (v8 < v5) {
            0x1::string::append(v4, 0x1::string::sub_string(&v2, 0, 0x1::string::index_of(&v2, &v6)));
            0x1::string::append(v4, 0x1::string::from_ascii(u128_to_string((arg1 as u128))));
            0x1::string::append(v4, 0x1::string::sub_string(&v2, v8 + 1, v5));
        } else if (arg1 == 0) {
            let v9 = *0x1::string::bytes(&v2);
            0x1::vector::reverse<u8>(&mut v9);
            let (v10, v11) = 0x1::vector::index_of<u8>(&v9, &v1);
            if (v10) {
                if (v11 == 0) {
                    0x1::vector::insert<u8>(&mut v9, 48, 0);
                } else {
                    let (_, v13) = 0x1::vector::index_of<u8>(&v9, &v0);
                    if (v13 < v11) {
                        0x1::vector::insert<u8>(&mut v9, v1, v13 + 1);
                        0x1::vector::insert<u8>(&mut v9, 48, v13 + 1);
                    } else {
                        0x1::vector::insert<u8>(&mut v9, v1, 0);
                        0x1::vector::insert<u8>(&mut v9, 48, 0);
                    };
                };
            };
            0x1::vector::reverse<u8>(&mut v9);
            0x1::string::append(v4, 0x1::string::utf8(v9));
        } else {
            0x1::string::append(v4, v2);
        };
        0x1::string::to_ascii(*v4)
    }

    public fun u128_to_string(arg0: u128) : 0x1::ascii::String {
        if (arg0 == 0) {
            return 0x1::ascii::string(b"0")
        };
        let v0 = 0x1::vector::empty<u8>();
        while (arg0 != 0) {
            0x1::vector::push_back<u8>(&mut v0, ((48 + arg0 % 10) as u8));
            arg0 = arg0 / 10;
        };
        0x1::vector::reverse<u8>(&mut v0);
        0x1::ascii::string(v0)
    }

    public fun version() : u64 {
        1
    }

    // decompiled from Move bytecode v6
}

