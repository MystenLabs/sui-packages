module 0xc90ed2fbb74ba735aaaeb86bbe376972a8119c62f4f1d59cf734de6815b9feee::shop {
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

    struct DropKey has copy, drop, store {
        listing_id: 0x1::string::String,
    }

    struct Bought has copy, drop {
        buyer: address,
        listing: 0x1::string::String,
        serial: u64,
        price: u64,
        picks: vector<u64>,
    }

    public fun add_choice(arg0: &mut Shop, arg1: &0xc90ed2fbb74ba735aaaeb86bbe376972a8119c62f4f1d59cf734de6815b9feee::item::AdminCap, arg2: 0x1::string::String, arg3: vector<Piece>) {
        let v0 = 0x2::table::borrow_mut<0x1::string::String, Listing>(&mut arg0.listings, arg2);
        assert!(v0.sold == 0, 13906835346871681059);
        assert!(!0x1::vector::is_empty<Piece>(&arg3), 13906835351166386207);
        0x1::vector::push_back<vector<Piece>>(&mut v0.choices, arg3);
    }

    public fun add_listing<T0>(arg0: &mut Shop, arg1: &0xc90ed2fbb74ba735aaaeb86bbe376972a8119c62f4f1d59cf734de6815b9feee::item::AdminCap, arg2: 0x1::string::String, arg3: u64, arg4: u64, arg5: u64, arg6: bool, arg7: vector<Piece>) {
        assert!(!0x2::table::contains<0x1::string::String, Listing>(&arg0.listings, arg2), 13906835260971548695);
        assert!(!0x1::vector::is_empty<Piece>(&arg7), 13906835265267040287);
        assert!(arg5 <= arg4, 13906835269561221139);
        let v0 = Listing{
            currency : 0x1::type_name::with_original_ids<T0>(),
            price    : arg3,
            total    : arg4,
            early    : arg5,
            sold     : 0,
            numbered : arg6,
            open     : true,
            pieces   : arg7,
            choices  : 0x1::vector::empty<vector<Piece>>(),
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

    entry fun buy<T0>(arg0: &mut Shop, arg1: &mut 0x2::token::TokenPolicy<T0>, arg2: &mut 0x2::token::Token<T0>, arg3: 0x1::string::String, arg4: vector<u64>, arg5: &0x2::random::Random, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 2, 13906834844358541317);
        assert!(0x2::table::contains<0x1::string::String, Listing>(&arg0.listings, arg3), 13906834848653901835);
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = arg0.phase;
        let v2 = DropKey{listing_id: arg3};
        let v3 = 0x2::dynamic_field::exists<DropKey>(&arg0.id, v2);
        let v4 = if (v3) {
            *0x2::dynamic_field::borrow<DropKey, 0x1::string::String>(&arg0.id, v2)
        } else {
            arg0.edition
        };
        if (!v3) {
            assert!(v1 != 0, 13906834883013378055);
            if (v1 == 1) {
                assert!(0x2::table::contains<address, u64>(&arg0.allowance, v0), 13906834891603443721);
                let v5 = 0x2::table::borrow_mut<address, u64>(&mut arg0.allowance, v0);
                assert!(*v5 > 0, 13906834900193378313);
                *v5 = *v5 - 1;
            };
        };
        let v6 = 0x2::table::borrow_mut<0x1::string::String, Listing>(&mut arg0.listings, arg3);
        assert!(v6.open, 13906834925963444237);
        if (!v3 && v1 == 1) {
            assert!(v6.sold < v6.early, 13906834930258673681);
        };
        assert!(v6.currency == 0x1::type_name::with_original_ids<T0>(), 13906834934553903125);
        assert!(v6.sold < v6.total, 13906834938848477199);
        assert!(0x1::vector::length<u64>(&arg4) == 0x1::vector::length<vector<Piece>>(&v6.choices), 13906834943144624161);
        let v7 = v6.pieces;
        let v8 = 0;
        while (v8 < 0x1::vector::length<u64>(&arg4)) {
            let v9 = 0x1::vector::borrow<vector<Piece>>(&v6.choices, v8);
            assert!(*0x1::vector::borrow<u64>(&arg4, v8) < 0x1::vector::length<Piece>(v9), 13906834960324493345);
            0x1::vector::push_back<Piece>(&mut v7, *0x1::vector::borrow<Piece>(v9, *0x1::vector::borrow<u64>(&arg4, v8)));
            v8 = v8 + 1;
        };
        v6.sold = v6.sold + 1;
        let v10 = v6.price;
        let v11 = 0x2::token::spend<T0>(0x2::token::split<T0>(arg2, v10, arg6), arg6);
        let v12 = Purchase{dummy_field: false};
        0x2::token::add_approval<T0, Purchase>(v12, &mut v11, arg6);
        let (_, _, _, _) = 0x2::token::confirm_request_mut<T0>(arg1, v11, arg6);
        let (v17, v18) = if (v6.numbered) {
            (v6.sold, v6.total)
        } else {
            (0, 0)
        };
        let v19 = 0x2::random::new_generator(arg5, arg6);
        let v20 = &v7;
        let v21 = 0;
        while (v21 < 0x1::vector::length<Piece>(v20)) {
            let v22 = 0x1::vector::borrow<Piece>(v20, v21);
            let v23 = if (v17 > 0) {
                numbered_name(v22.name, v17, v18)
            } else {
                v22.name
            };
            0xc90ed2fbb74ba735aaaeb86bbe376972a8119c62f4f1d59cf734de6815b9feee::item::deliver(0xc90ed2fbb74ba735aaaeb86bbe376972a8119c62f4f1d59cf734de6815b9feee::item::new(v23, v22.kind, v22.design, v22.colourway, v22.rarity, v4, v22.description, v22.key, v17, v18, 0x2::random::generate_u64_in_range(&mut v19, 0, 999999), arg6), v0);
            v21 = v21 + 1;
        };
        let v24 = Bought{
            buyer   : v0,
            listing : arg3,
            serial  : v17,
            price   : v10,
            picks   : arg4,
        };
        0x2::event::emit<Bought>(v24);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Shop{
            id        : 0x2::object::new(arg0),
            version   : 2,
            phase     : 0,
            edition   : 0x1::string::utf8(b"Genesis"),
            allowance : 0x2::table::new<address, u64>(arg0),
            listings  : 0x2::table::new<0x1::string::String, Listing>(arg0),
        };
        0x2::transfer::share_object<Shop>(v0);
    }

    public fun is_drop(arg0: &Shop, arg1: 0x1::string::String) : bool {
        let v0 = DropKey{listing_id: arg1};
        0x2::dynamic_field::exists<DropKey>(&arg0.id, v0)
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
        let v0 = DropKey{listing_id: arg1};
        if (0x2::dynamic_field::exists<DropKey>(&arg0.id, v0)) {
            *0x2::dynamic_field::borrow<DropKey, 0x1::string::String>(&arg0.id, v0)
        } else {
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

    public fun make_drop(arg0: &mut Shop, arg1: &0xc90ed2fbb74ba735aaaeb86bbe376972a8119c62f4f1d59cf734de6815b9feee::item::AdminCap, arg2: 0x1::string::String, arg3: 0x1::string::String) {
        assert!(arg0.version == 2, 13906835424179126277);
        assert!(0x2::table::contains<0x1::string::String, Listing>(&arg0.listings, arg2), 13906835428474486795);
        assert!(0x2::table::borrow<0x1::string::String, Listing>(&arg0.listings, arg2).sold == 0, 13906835432771158053);
        let v0 = DropKey{listing_id: arg2};
        if (0x2::dynamic_field::exists<DropKey>(&arg0.id, v0)) {
            *0x2::dynamic_field::borrow_mut<DropKey, 0x1::string::String>(&mut arg0.id, v0) = arg3;
        } else {
            0x2::dynamic_field::add<DropKey, 0x1::string::String>(&mut arg0.id, v0, arg3);
        };
    }

    public fun migrate(arg0: &mut Shop, arg1: &0xc90ed2fbb74ba735aaaeb86bbe376972a8119c62f4f1d59cf734de6815b9feee::item::AdminCap) {
        assert!(arg0.version < 2, 13906835467131027495);
        arg0.version = 2;
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

    fun numbered_name(arg0: 0x1::string::String, arg1: u64, arg2: u64) : 0x1::string::String {
        0x1::string::append(&mut arg0, 0x1::string::utf8(b" #"));
        0x1::string::append(&mut arg0, 0x1::u64::to_string(arg1));
        0x1::string::append(&mut arg0, 0x1::string::utf8(b"/"));
        0x1::string::append(&mut arg0, 0x1::u64::to_string(arg2));
        arg0
    }

    public fun phase(arg0: &Shop) : u8 {
        arg0.phase
    }

    public fun remove_listing(arg0: &mut Shop, arg1: &0xc90ed2fbb74ba735aaaeb86bbe376972a8119c62f4f1d59cf734de6815b9feee::item::AdminCap, arg2: 0x1::string::String) {
        let Listing {
            currency : _,
            price    : _,
            total    : _,
            early    : _,
            sold     : v4,
            numbered : _,
            open     : _,
            pieces   : _,
            choices  : _,
        } = 0x2::table::remove<0x1::string::String, Listing>(&mut arg0.listings, arg2);
        assert!(v4 == 0, 13906835381230764057);
        let v9 = DropKey{listing_id: arg2};
        if (0x2::dynamic_field::exists<DropKey>(&arg0.id, v9)) {
            0x2::dynamic_field::remove<DropKey, 0x1::string::String>(&mut arg0.id, v9);
        };
    }

    public fun set_allowance(arg0: &mut Shop, arg1: &0xc90ed2fbb74ba735aaaeb86bbe376972a8119c62f4f1d59cf734de6815b9feee::item::AdminCap, arg2: vector<address>, arg3: vector<u64>) {
        assert!(0x1::vector::length<address>(&arg2) == 0x1::vector::length<u64>(&arg3), 13906835583094489117);
        0x1::vector::reverse<u64>(&mut arg3);
        assert!(0x1::vector::length<address>(&arg2) == 0x1::vector::length<u64>(&arg3), 13906835591682588671);
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

    public fun set_early(arg0: &mut Shop, arg1: &0xc90ed2fbb74ba735aaaeb86bbe376972a8119c62f4f1d59cf734de6815b9feee::item::AdminCap, arg2: 0x1::string::String, arg3: u64) {
        let v0 = 0x2::table::borrow_mut<0x1::string::String, Listing>(&mut arg0.listings, arg2);
        assert!(arg3 <= v0.total, 13906835514374357011);
        v0.early = arg3;
    }

    public fun set_open(arg0: &mut Shop, arg1: &0xc90ed2fbb74ba735aaaeb86bbe376972a8119c62f4f1d59cf734de6815b9feee::item::AdminCap, arg2: 0x1::string::String, arg3: bool) {
        0x2::table::borrow_mut<0x1::string::String, Listing>(&mut arg0.listings, arg2).open = arg3;
    }

    public fun set_phase(arg0: &mut Shop, arg1: &0xc90ed2fbb74ba735aaaeb86bbe376972a8119c62f4f1d59cf734de6815b9feee::item::AdminCap, arg2: u8) {
        assert!(arg2 <= 2, 13906835557324554267);
        arg0.phase = arg2;
    }

    public fun set_price(arg0: &mut Shop, arg1: &0xc90ed2fbb74ba735aaaeb86bbe376972a8119c62f4f1d59cf734de6815b9feee::item::AdminCap, arg2: 0x1::string::String, arg3: u64) {
        0x2::table::borrow_mut<0x1::string::String, Listing>(&mut arg0.listings, arg2).price = arg3;
    }

    public fun version(arg0: &Shop) : u64 {
        arg0.version
    }

    // decompiled from Move bytecode v7
}

