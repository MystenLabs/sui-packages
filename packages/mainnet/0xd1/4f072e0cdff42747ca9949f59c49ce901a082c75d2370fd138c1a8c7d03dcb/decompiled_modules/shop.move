module 0xd14f072e0cdff42747ca9949f59c49ce901a082c75d2370fd138c1a8c7d03dcb::shop {
    struct Purchase has drop {
        dummy_field: bool,
    }

    struct Piece has copy, drop, store {
        name: 0x1::string::String,
        kind: 0x1::string::String,
        design: 0x1::string::String,
        colourway: 0x1::string::String,
        rarity: 0x1::string::String,
        description: 0x1::string::String,
        key: 0x1::string::String,
    }

    struct Listing has store {
        currency: 0x1::type_name::TypeName,
        price: u64,
        total: u64,
        early: u64,
        sold: u64,
        numbered: bool,
        open: bool,
        drop_edition: 0x1::option::Option<0x1::string::String>,
        pieces: vector<Piece>,
        choices: vector<vector<Piece>>,
    }

    struct Shop has key {
        id: 0x2::object::UID,
        version: u64,
        phase: u8,
        edition: 0x1::string::String,
        allowance: 0x2::table::Table<address, u64>,
        listings: 0x2::table::Table<0x1::string::String, Listing>,
    }

    struct Bought has copy, drop {
        buyer: address,
        listing: 0x1::string::String,
        serial: u64,
        price: u64,
        picks: vector<u64>,
    }

    public fun add_choice(arg0: &mut Shop, arg1: &0xd14f072e0cdff42747ca9949f59c49ce901a082c75d2370fd138c1a8c7d03dcb::universe::AdminCap, arg2: 0x1::string::String, arg3: vector<Piece>) {
        let v0 = 0x2::table::borrow_mut<0x1::string::String, Listing>(&mut arg0.listings, arg2);
        assert!(v0.sold == 0, 13906835342576713763);
        assert!(!0x1::vector::is_empty<Piece>(&arg3), 13906835346871418911);
        0x1::vector::push_back<vector<Piece>>(&mut v0.choices, arg3);
    }

    public fun add_listing<T0>(arg0: &mut Shop, arg1: &0xd14f072e0cdff42747ca9949f59c49ce901a082c75d2370fd138c1a8c7d03dcb::universe::AdminCap, arg2: 0x1::string::String, arg3: u64, arg4: u64, arg5: u64, arg6: bool, arg7: vector<Piece>) {
        assert!(!0x2::table::contains<0x1::string::String, Listing>(&arg0.listings, arg2), 13906835230906777623);
        assert!(!0x1::vector::is_empty<Piece>(&arg7), 13906835235202269215);
        assert!(arg5 <= arg4, 13906835239496450067);
        let v0 = Listing{
            currency     : 0x1::type_name::with_original_ids<T0>(),
            price        : arg3,
            total        : arg4,
            early        : arg5,
            sold         : 0,
            numbered     : arg6,
            open         : true,
            drop_edition : 0x1::option::none<0x1::string::String>(),
            pieces       : arg7,
            choices      : 0x1::vector::empty<vector<Piece>>(),
        };
        0x2::table::add<0x1::string::String, Listing>(&mut arg0.listings, arg2, v0);
    }

    public fun allowance(arg0: &Shop, arg1: address) : u64 {
        if (0x2::table::contains<address, u64>(&arg0.allowance, arg1)) {
            *0x2::table::borrow<address, u64>(&arg0.allowance, arg1)
        } else {
            0
        }
    }

    entry fun buy<T0>(arg0: &mut Shop, arg1: &0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::policy::Policy<0x2::balance::Balance<T0>>, arg2: &mut 0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::account::Account, arg3: &0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::account::Account, arg4: 0x1::string::String, arg5: vector<u64>, arg6: &0x2::random::Random, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 13906834883013246981);
        assert!(0x2::table::contains<0x1::string::String, Listing>(&arg0.listings, arg4), 13906834887308607499);
        assert!(0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::account::owner(arg3) == 0x2::object::uid_to_address(&arg0.id), 13906834891605540905);
        let v0 = 0x2::tx_context::sender(arg7);
        let v1 = is_drop(arg0, arg4);
        if (!v1) {
            assert!(arg0.phase != 0, 13906834913078149127);
        };
        let v2 = !v1 && arg0.phase == 1;
        if (v2) {
            assert!(allowance(arg0, v0) > 0, 13906834925963182089);
            let v3 = 0x2::table::borrow_mut<address, u64>(&mut arg0.allowance, v0);
            *v3 = *v3 - 1;
        };
        let v4 = 0x2::table::borrow_mut<0x1::string::String, Listing>(&mut arg0.listings, arg4);
        assert!(v4.open, 13906834951733248013);
        if (v2) {
            assert!(v4.sold < v4.early, 13906834956028477457);
        };
        assert!(v4.currency == 0x1::type_name::with_original_ids<T0>(), 13906834960323706901);
        assert!(v4.sold < v4.total, 13906834964618280975);
        assert!(0x1::vector::length<u64>(&arg5) == 0x1::vector::length<vector<Piece>>(&v4.choices), 13906834968914427937);
        let v5 = v4.pieces;
        let v6 = &arg5;
        let v7 = &v4.choices;
        let v8 = 0x1::vector::length<u64>(v6);
        assert!(v8 == 0x1::vector::length<vector<Piece>>(v7), 13906834981797232639);
        let v9 = 0;
        while (v9 < v8) {
            let v10 = 0x1::vector::borrow<u64>(v6, v9);
            let v11 = 0x1::vector::borrow<vector<Piece>>(v7, v9);
            assert!(*v10 < 0x1::vector::length<Piece>(v11), 13906834981799329825);
            0x1::vector::push_back<Piece>(&mut v5, *0x1::vector::borrow<Piece>(v11, *v10));
            v9 = v9 + 1;
        };
        v4.sold = v4.sold + 1;
        let v12 = v4.price;
        let v13 = 0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::account::new_auth(arg7);
        let v14 = 0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::account::unlock_balance<T0>(arg2, &v13, v12, arg7);
        let v15 = Purchase{dummy_field: false};
        0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::request::approve<0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::unlock_funds::UnlockFunds<0x2::balance::Balance<T0>>, Purchase>(&mut v14, v15);
        0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::account::deposit_balance<T0>(arg3, 0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::unlock_funds::resolve<0x2::balance::Balance<T0>>(v14, arg1));
        let (v16, v17) = if (v4.numbered) {
            (v4.sold, v4.total)
        } else {
            (0, 0)
        };
        let v18 = 0x2::random::new_generator(arg6, arg7);
        0x1::vector::reverse<Piece>(&mut v5);
        let v19 = 0;
        while (v19 < 0x1::vector::length<Piece>(&v5)) {
            let v20 = 0x1::vector::pop_back<Piece>(&mut v5);
            0xd14f072e0cdff42747ca9949f59c49ce901a082c75d2370fd138c1a8c7d03dcb::universe::deliver(0xd14f072e0cdff42747ca9949f59c49ce901a082c75d2370fd138c1a8c7d03dcb::universe::new(0xd14f072e0cdff42747ca9949f59c49ce901a082c75d2370fd138c1a8c7d03dcb::universe::numbered_name(v20.name, v16, v17), v20.kind, v20.design, v20.colourway, v20.rarity, listing_edition(arg0, arg4), v20.description, v20.key, v16, v17, 0xd14f072e0cdff42747ca9949f59c49ce901a082c75d2370fd138c1a8c7d03dcb::universe::roll_wear(&mut v18), arg7), v0);
            v19 = v19 + 1;
        };
        0x1::vector::destroy_empty<Piece>(v5);
        let v21 = Bought{
            buyer   : v0,
            listing : arg4,
            serial  : v16,
            price   : v12,
            picks   : arg5,
        };
        0x2::event::emit<Bought>(v21);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Shop{
            id        : 0x2::object::new(arg0),
            version   : 1,
            phase     : 0,
            edition   : 0x1::string::utf8(b"Genesis"),
            allowance : 0x2::table::new<address, u64>(arg0),
            listings  : 0x2::table::new<0x1::string::String, Listing>(arg0),
        };
        0x2::transfer::share_object<Shop>(v0);
    }

    public fun is_drop(arg0: &Shop, arg1: 0x1::string::String) : bool {
        0x2::table::contains<0x1::string::String, Listing>(&arg0.listings, arg1) && 0x1::option::is_some<0x1::string::String>(&0x2::table::borrow<0x1::string::String, Listing>(&arg0.listings, arg1).drop_edition)
    }

    public fun listing_choices(arg0: &Shop, arg1: 0x1::string::String) : vector<u64> {
        let v0 = &0x2::table::borrow<0x1::string::String, Listing>(&arg0.listings, arg1).choices;
        let v1 = vector[];
        let v2 = 0;
        while (v2 < 0x1::vector::length<vector<Piece>>(v0)) {
            0x1::vector::push_back<u64>(&mut v1, 0x1::vector::length<Piece>(0x1::vector::borrow<vector<Piece>>(v0, v2)));
            v2 = v2 + 1;
        };
        v1
    }

    public fun listing_early(arg0: &Shop, arg1: 0x1::string::String) : u64 {
        0x2::table::borrow<0x1::string::String, Listing>(&arg0.listings, arg1).early
    }

    public fun listing_edition(arg0: &Shop, arg1: 0x1::string::String) : 0x1::string::String {
        let v0 = 0x2::table::borrow<0x1::string::String, Listing>(&arg0.listings, arg1).drop_edition;
        if (0x1::option::is_some<0x1::string::String>(&v0)) {
            0x1::option::destroy_some<0x1::string::String>(v0)
        } else {
            0x1::option::destroy_none<0x1::string::String>(v0);
            arg0.edition
        }
    }

    public fun listing_price(arg0: &Shop, arg1: 0x1::string::String) : u64 {
        0x2::table::borrow<0x1::string::String, Listing>(&arg0.listings, arg1).price
    }

    public fun listing_sold(arg0: &Shop, arg1: 0x1::string::String) : u64 {
        0x2::table::borrow<0x1::string::String, Listing>(&arg0.listings, arg1).sold
    }

    public fun listing_total(arg0: &Shop, arg1: 0x1::string::String) : u64 {
        0x2::table::borrow<0x1::string::String, Listing>(&arg0.listings, arg1).total
    }

    public fun make_drop(arg0: &mut Shop, arg1: &0xd14f072e0cdff42747ca9949f59c49ce901a082c75d2370fd138c1a8c7d03dcb::universe::AdminCap, arg2: 0x1::string::String, arg3: 0x1::string::String) {
        assert!(arg0.version == 1, 13906835402704289797);
        assert!(0x2::table::contains<0x1::string::String, Listing>(&arg0.listings, arg2), 13906835406999650315);
        let v0 = 0x2::table::borrow_mut<0x1::string::String, Listing>(&mut arg0.listings, arg2);
        assert!(v0.sold == 0, 13906835415591288869);
        v0.drop_edition = 0x1::option::some<0x1::string::String>(arg3);
    }

    public fun migrate(arg0: &mut Shop, arg1: &0xd14f072e0cdff42747ca9949f59c49ce901a082c75d2370fd138c1a8c7d03dcb::universe::AdminCap) {
        assert!(arg0.version < 1, 13906835497195798567);
        arg0.version = 1;
    }

    public fun new_piece(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String) : Piece {
        Piece{
            name        : arg0,
            kind        : arg1,
            design      : arg2,
            colourway   : arg3,
            rarity      : arg4,
            description : arg5,
            key         : arg6,
        }
    }

    public fun phase(arg0: &Shop) : u8 {
        arg0.phase
    }

    public fun remove_listing(arg0: &mut Shop, arg1: &0xd14f072e0cdff42747ca9949f59c49ce901a082c75d2370fd138c1a8c7d03dcb::universe::AdminCap, arg2: 0x1::string::String) {
        let Listing {
            currency     : _,
            price        : _,
            total        : _,
            early        : _,
            sold         : v4,
            numbered     : _,
            open         : _,
            drop_edition : _,
            pieces       : _,
            choices      : _,
        } = 0x2::table::remove<0x1::string::String, Listing>(&mut arg0.listings, arg2);
        assert!(v4 == 0, 13906835376935796761);
    }

    public fun send_payments<T0>(arg0: &mut Shop, arg1: &0xd14f072e0cdff42747ca9949f59c49ce901a082c75d2370fd138c1a8c7d03dcb::universe::AdminCap, arg2: &mut 0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::account::Account, arg3: &0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::account::Account, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : 0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::request::Request<0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::send_funds::SendFunds<0x2::balance::Balance<T0>>> {
        let v0 = 0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::account::new_auth_as_object(&mut arg0.id);
        0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::account::send_balance<T0>(arg2, &v0, arg3, arg4, arg5)
    }

    public fun set_allowance(arg0: &mut Shop, arg1: &0xd14f072e0cdff42747ca9949f59c49ce901a082c75d2370fd138c1a8c7d03dcb::universe::AdminCap, arg2: vector<address>, arg3: vector<u64>) {
        assert!(0x1::vector::length<address>(&arg2) == 0x1::vector::length<u64>(&arg3), 13906835634634096669);
        0x1::vector::reverse<u64>(&mut arg3);
        assert!(0x1::vector::length<address>(&arg2) == 0x1::vector::length<u64>(&arg3), 13906835643222196223);
        0x1::vector::reverse<address>(&mut arg2);
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg2)) {
            let v1 = 0x1::vector::pop_back<address>(&mut arg2);
            if (0x2::table::contains<address, u64>(&arg0.allowance, v1)) {
                *0x2::table::borrow_mut<address, u64>(&mut arg0.allowance, v1) = 0x1::vector::pop_back<u64>(&mut arg3);
            } else {
                0x2::table::add<address, u64>(&mut arg0.allowance, v1, 0x1::vector::pop_back<u64>(&mut arg3));
            };
            v0 = v0 + 1;
        };
        0x1::vector::destroy_empty<address>(arg2);
        0x1::vector::destroy_empty<u64>(arg3);
    }

    public fun set_early(arg0: &mut Shop, arg1: &0xd14f072e0cdff42747ca9949f59c49ce901a082c75d2370fd138c1a8c7d03dcb::universe::AdminCap, arg2: 0x1::string::String, arg3: u64) {
        let v0 = 0x2::table::borrow_mut<0x1::string::String, Listing>(&mut arg0.listings, arg2);
        assert!(arg3 <= v0.total, 13906835544439128083);
        v0.early = arg3;
    }

    public fun set_open(arg0: &mut Shop, arg1: &0xd14f072e0cdff42747ca9949f59c49ce901a082c75d2370fd138c1a8c7d03dcb::universe::AdminCap, arg2: 0x1::string::String, arg3: bool) {
        0x2::table::borrow_mut<0x1::string::String, Listing>(&mut arg0.listings, arg2).open = arg3;
    }

    public fun set_phase(arg0: &mut Shop, arg1: &0xd14f072e0cdff42747ca9949f59c49ce901a082c75d2370fd138c1a8c7d03dcb::universe::AdminCap, arg2: u8) {
        assert!(arg2 <= 2, 13906835587389325339);
        arg0.phase = arg2;
    }

    public fun set_price(arg0: &mut Shop, arg1: &0xd14f072e0cdff42747ca9949f59c49ce901a082c75d2370fd138c1a8c7d03dcb::universe::AdminCap, arg2: 0x1::string::String, arg3: u64) {
        0x2::table::borrow_mut<0x1::string::String, Listing>(&mut arg0.listings, arg2).price = arg3;
    }

    public fun version(arg0: &Shop) : u64 {
        arg0.version
    }

    // decompiled from Move bytecode v7
}

