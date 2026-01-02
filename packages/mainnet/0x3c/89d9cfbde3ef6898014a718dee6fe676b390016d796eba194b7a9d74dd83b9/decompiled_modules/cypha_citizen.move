module 0x3c89d9cfbde3ef6898014a718dee6fe676b390016d796eba194b7a9d74dd83b9::cypha_citizen {
    struct CYPHA_CITIZEN has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct PointsBook has store {
        totals: 0x2::table::Table<address, u64>,
        total_points_distributed: u64,
    }

    struct ReferralBook has store {
        code_to_owner: 0x2::table::Table<0x1::string::String, address>,
        owner_to_code: 0x2::table::Table<address, 0x1::string::String>,
        invite_counts: 0x2::table::Table<address, u64>,
        total_passes: u64,
    }

    struct Registry has key {
        id: 0x2::object::UID,
        treasury: address,
        mint_price: u64,
        version: u64,
        points_book: PointsBook,
        referral_book: ReferralBook,
        sequence_number: u128,
    }

    struct CitizenPass has key {
        id: 0x2::object::UID,
        owner: address,
        referral_code: 0x1::string::String,
        invited_by: 0x1::option::Option<address>,
        minted_by: address,
        created_at_ms: u64,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
    }

    struct CitizenPassMintedEvent has copy, drop {
        pass_id: 0x2::object::ID,
        owner: address,
        invited_by: 0x1::option::Option<0x1::string::String>,
        referral_code: 0x1::string::String,
        minted_by: address,
        created_at_ms: u64,
    }

    struct PointsAddedEvent has copy, drop {
        recipient: address,
        points_added: u64,
        new_total: u64,
        admin: address,
        created_at_ms: u64,
    }

    public fun batch_add_points(arg0: &AdminCap, arg1: &mut Registry, arg2: vector<address>, arg3: vector<u64>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<address>(&arg2);
        assert!(v0 == 0x1::vector::length<u64>(&arg3), 3);
        assert!(v0 <= 100, 4);
        let v1 = 0;
        while (v1 < v0) {
            let v2 = *0x1::vector::borrow<address>(&arg2, v1);
            let v3 = *0x1::vector::borrow<u64>(&arg3, v1);
            if (0x2::table::contains<address, u64>(&arg1.points_book.totals, v2)) {
                let v4 = *0x2::table::borrow<address, u64>(&arg1.points_book.totals, v2) + v3;
                *0x2::table::borrow_mut<address, u64>(&mut arg1.points_book.totals, v2) = v4;
                arg1.points_book.total_points_distributed = arg1.points_book.total_points_distributed + v3;
                let v5 = PointsAddedEvent{
                    recipient     : v2,
                    points_added  : v3,
                    new_total     : v4,
                    admin         : 0x2::tx_context::sender(arg5),
                    created_at_ms : 0x2::clock::timestamp_ms(arg4),
                };
                0x2::event::emit<PointsAddedEvent>(v5);
            };
            v1 = v1 + 1;
        };
    }

    public fun get_points(arg0: &Registry, arg1: address) : u64 {
        if (0x2::table::contains<address, u64>(&arg0.points_book.totals, arg1)) {
            *0x2::table::borrow<address, u64>(&arg0.points_book.totals, arg1)
        } else {
            0
        }
    }

    public fun get_referral_code(arg0: &Registry, arg1: address) : 0x1::string::String {
        if (0x2::table::contains<address, 0x1::string::String>(&arg0.referral_book.owner_to_code, arg1)) {
            *0x2::table::borrow<address, 0x1::string::String>(&arg0.referral_book.owner_to_code, arg1)
        } else {
            0x1::string::utf8(b"")
        }
    }

    public fun has_pass(arg0: &Registry, arg1: address) : bool {
        0x2::table::contains<address, 0x1::string::String>(&arg0.referral_book.owner_to_code, arg1)
    }

    fun init(arg0: CYPHA_CITIZEN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = PointsBook{
            totals                   : 0x2::table::new<address, u64>(arg1),
            total_points_distributed : 0,
        };
        let v1 = ReferralBook{
            code_to_owner : 0x2::table::new<0x1::string::String, address>(arg1),
            owner_to_code : 0x2::table::new<address, 0x1::string::String>(arg1),
            invite_counts : 0x2::table::new<address, u64>(arg1),
            total_passes  : 0,
        };
        let v2 = Registry{
            id              : 0x2::object::new(arg1),
            treasury        : 0x2::tx_context::sender(arg1),
            mint_price      : 3000,
            version         : 1,
            points_book     : v0,
            referral_book   : v1,
            sequence_number : 1,
        };
        0x2::transfer::share_object<Registry>(v2);
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"referral_code"));
        let v5 = 0x1::vector::empty<0x1::string::String>();
        let v6 = &mut v5;
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"{referral_code}"));
        let v7 = 0x2::package::claim<CYPHA_CITIZEN>(arg0, arg1);
        let v8 = 0x2::display::new_with_fields<CitizenPass>(&v7, v3, v5, arg1);
        0x2::display::update_version<CitizenPass>(&mut v8);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v7, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<CitizenPass>>(v8, 0x2::tx_context::sender(arg1));
        let v9 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v9, 0x2::tx_context::sender(arg1));
    }

    public fun invite_count(arg0: &Registry, arg1: address) : u64 {
        if (0x2::table::contains<address, u64>(&arg0.referral_book.invite_counts, arg1)) {
            *0x2::table::borrow<address, u64>(&arg0.referral_book.invite_counts, arg1)
        } else {
            0
        }
    }

    public fun is_referral_code_available(arg0: &Registry, arg1: 0x1::string::String) : bool {
        !0x2::table::contains<0x1::string::String, address>(&arg0.referral_book.code_to_owner, arg1)
    }

    public fun mint_pass(arg0: &mut Registry, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: 0x1::string::String, arg3: 0x1::option::Option<0x1::string::String>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(arg0.version == 1, 7);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) >= arg0.mint_price, 6);
        assert!(!0x2::table::contains<address, 0x1::string::String>(&arg0.referral_book.owner_to_code, v0), 0);
        assert!(!0x2::table::contains<0x1::string::String, address>(&arg0.referral_book.code_to_owner, arg2), 2);
        let v1 = 0x1::string::length(&arg2);
        assert!(v1 >= 3 && v1 <= 64, 1);
        let v2 = 0x1::option::none<address>();
        if (0x1::option::is_some<0x1::string::String>(&arg3)) {
            let v3 = *0x1::option::borrow<0x1::string::String>(&arg3);
            assert!(0x2::table::contains<0x1::string::String, address>(&arg0.referral_book.code_to_owner, v3), 8);
            let v4 = *0x2::table::borrow<0x1::string::String, address>(&arg0.referral_book.code_to_owner, v3);
            if (!0x2::table::contains<address, u64>(&arg0.referral_book.invite_counts, v4)) {
                0x2::table::add<address, u64>(&mut arg0.referral_book.invite_counts, v4, 0);
            };
            *0x2::table::borrow_mut<address, u64>(&mut arg0.referral_book.invite_counts, v4) = *0x2::table::borrow<address, u64>(&arg0.referral_book.invite_counts, v4) + 1;
            v2 = 0x1::option::some<address>(v4);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, arg0.treasury);
        0x2::table::add<0x1::string::String, address>(&mut arg0.referral_book.code_to_owner, arg2, v0);
        0x2::table::add<address, 0x1::string::String>(&mut arg0.referral_book.owner_to_code, v0, arg2);
        arg0.referral_book.total_passes = arg0.referral_book.total_passes + 1;
        let v5 = 0x1::string::utf8(b"Citizen Pass #");
        0x1::string::append(&mut v5, 0x1::u128::to_string(arg0.sequence_number));
        let v6 = 0x2::clock::timestamp_ms(arg4);
        let v7 = CitizenPass{
            id            : 0x2::object::new(arg5),
            owner         : v0,
            referral_code : arg2,
            invited_by    : v2,
            minted_by     : v0,
            created_at_ms : v6,
            name          : v5,
            image_url     : 0x1::string::utf8(b"https://citizen-pass.s3.ap-northeast-1.amazonaws.com/citizen.jpg"),
        };
        0x2::table::add<address, u64>(&mut arg0.points_book.totals, v0, 0);
        arg0.sequence_number = arg0.sequence_number + 1;
        0x2::transfer::transfer<CitizenPass>(v7, v0);
        let v8 = CitizenPassMintedEvent{
            pass_id       : 0x2::object::id<CitizenPass>(&v7),
            owner         : v0,
            invited_by    : arg3,
            referral_code : arg2,
            minted_by     : v0,
            created_at_ms : v6,
        };
        0x2::event::emit<CitizenPassMintedEvent>(v8);
    }

    public fun mint_price(arg0: &Registry) : u64 {
        arg0.mint_price
    }

    public fun total_passes(arg0: &Registry) : u64 {
        arg0.referral_book.total_passes
    }

    public fun total_points_distributed(arg0: &Registry) : u64 {
        arg0.points_book.total_points_distributed
    }

    public fun update_mint_price(arg0: &AdminCap, arg1: &mut Registry, arg2: u64) {
        assert!(arg1.version == 1, 7);
        arg1.mint_price = arg2;
    }

    public fun update_treasury(arg0: &AdminCap, arg1: &mut Registry, arg2: address) {
        assert!(arg1.version == 1, 7);
        arg1.treasury = arg2;
    }

    // decompiled from Move bytecode v6
}

