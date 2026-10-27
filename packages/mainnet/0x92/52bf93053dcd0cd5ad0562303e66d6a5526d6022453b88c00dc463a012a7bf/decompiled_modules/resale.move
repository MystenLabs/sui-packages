module 0x9252bf93053dcd0cd5ad0562303e66d6a5526d6022453b88c00dc463a012a7bf::resale {
    struct RESALE has drop {
        dummy_field: bool,
    }

    struct Rule has drop {
        dummy_field: bool,
    }

    struct Config has drop, store {
        dummy_field: bool,
    }

    fun init(arg0: RESALE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<RESALE>(arg0, arg1);
        let (v1, v2) = 0x2::transfer_policy::new<0x9252bf93053dcd0cd5ad0562303e66d6a5526d6022453b88c00dc463a012a7bf::licence::ResaleLicence>(&v0, arg1);
        let v3 = v2;
        let v4 = v1;
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::add<0x9252bf93053dcd0cd5ad0562303e66d6a5526d6022453b88c00dc463a012a7bf::licence::ResaleLicence>(&mut v4, &v3);
        let v5 = Rule{dummy_field: false};
        let v6 = Config{dummy_field: false};
        0x2::transfer_policy::add_rule<0x9252bf93053dcd0cd5ad0562303e66d6a5526d6022453b88c00dc463a012a7bf::licence::ResaleLicence, Rule, Config>(v5, &mut v4, &v3, v6);
        let v7 = 0x1::vector::empty<0x1::string::String>();
        let v8 = &mut v7;
        0x1::vector::push_back<0x1::string::String>(v8, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v8, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v8, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v8, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(v8, 0x1::string::utf8(b"project_url"));
        let v9 = 0x1::vector::empty<0x1::string::String>();
        let v10 = &mut v9;
        0x1::vector::push_back<0x1::string::String>(v10, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v10, 0x1::string::utf8(b"Game licence for {name} on Rare Store."));
        0x1::vector::push_back<0x1::string::String>(v10, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v10, 0x1::string::utf8(b"https://rare.market/store/{slug}"));
        0x1::vector::push_back<0x1::string::String>(v10, 0x1::string::utf8(b"https://rare.market/store"));
        let v11 = 0x2::display::new_with_fields<0x9252bf93053dcd0cd5ad0562303e66d6a5526d6022453b88c00dc463a012a7bf::licence::Licence>(&v0, v7, v9, arg1);
        0x2::display::update_version<0x9252bf93053dcd0cd5ad0562303e66d6a5526d6022453b88c00dc463a012a7bf::licence::Licence>(&mut v11);
        let v12 = 0x2::display::new_with_fields<0x9252bf93053dcd0cd5ad0562303e66d6a5526d6022453b88c00dc463a012a7bf::licence::ResaleLicence>(&v0, v7, v9, arg1);
        0x2::display::update_version<0x9252bf93053dcd0cd5ad0562303e66d6a5526d6022453b88c00dc463a012a7bf::licence::ResaleLicence>(&mut v12);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<0x9252bf93053dcd0cd5ad0562303e66d6a5526d6022453b88c00dc463a012a7bf::licence::ResaleLicence>>(v4);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<0x9252bf93053dcd0cd5ad0562303e66d6a5526d6022453b88c00dc463a012a7bf::licence::ResaleLicence>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<0x9252bf93053dcd0cd5ad0562303e66d6a5526d6022453b88c00dc463a012a7bf::licence::Licence>>(v11, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<0x9252bf93053dcd0cd5ad0562303e66d6a5526d6022453b88c00dc463a012a7bf::licence::ResaleLicence>>(v12, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun make_tradable<T0>(arg0: &0x9252bf93053dcd0cd5ad0562303e66d6a5526d6022453b88c00dc463a012a7bf::store::Store, arg1: &mut 0x9252bf93053dcd0cd5ad0562303e66d6a5526d6022453b88c00dc463a012a7bf::game::Game, arg2: 0x9252bf93053dcd0cd5ad0562303e66d6a5526d6022453b88c00dc463a012a7bf::licence::Licence, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x2::kiosk::KioskOwnerCap, arg5: &0x2::transfer_policy::TransferPolicy<0x9252bf93053dcd0cd5ad0562303e66d6a5526d6022453b88c00dc463a012a7bf::licence::ResaleLicence>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        0x9252bf93053dcd0cd5ad0562303e66d6a5526d6022453b88c00dc463a012a7bf::store::assert_live(arg0);
        0x9252bf93053dcd0cd5ad0562303e66d6a5526d6022453b88c00dc463a012a7bf::store::assert_usdc<T0>(arg0);
        0x9252bf93053dcd0cd5ad0562303e66d6a5526d6022453b88c00dc463a012a7bf::game::assert_current(arg1);
        let v0 = 0x2::object::id<0x9252bf93053dcd0cd5ad0562303e66d6a5526d6022453b88c00dc463a012a7bf::game::Game>(arg1);
        assert!(0x9252bf93053dcd0cd5ad0562303e66d6a5526d6022453b88c00dc463a012a7bf::licence::game(&arg2) == v0, 502);
        let v1 = 0x9252bf93053dcd0cd5ad0562303e66d6a5526d6022453b88c00dc463a012a7bf::game::resale_terms(arg1);
        assert!(0x9252bf93053dcd0cd5ad0562303e66d6a5526d6022453b88c00dc463a012a7bf::game::resale_enabled(&v1), 501);
        assert!(0x2::clock::timestamp_ms(arg6) >= 0x9252bf93053dcd0cd5ad0562303e66d6a5526d6022453b88c00dc463a012a7bf::licence::purchased_at_ms(&arg2) + 0x9252bf93053dcd0cd5ad0562303e66d6a5526d6022453b88c00dc463a012a7bf::game::min_hold_ms(&v1), 503);
        let v2 = 0x2::object::id<0x9252bf93053dcd0cd5ad0562303e66d6a5526d6022453b88c00dc463a012a7bf::licence::Licence>(&arg2);
        0x9252bf93053dcd0cd5ad0562303e66d6a5526d6022453b88c00dc463a012a7bf::game::finalize<T0>(arg1, arg0, v2, arg7);
        let v3 = 0x9252bf93053dcd0cd5ad0562303e66d6a5526d6022453b88c00dc463a012a7bf::licence::into_resale(arg2, arg7);
        let v4 = 0x2::object::id<0x9252bf93053dcd0cd5ad0562303e66d6a5526d6022453b88c00dc463a012a7bf::licence::ResaleLicence>(&v3);
        0x2::kiosk::lock<0x9252bf93053dcd0cd5ad0562303e66d6a5526d6022453b88c00dc463a012a7bf::licence::ResaleLicence>(arg3, arg4, arg5, v3);
        0x9252bf93053dcd0cd5ad0562303e66d6a5526d6022453b88c00dc463a012a7bf::events::made_tradable(v2, v4, v0, 0x2::tx_context::sender(arg7), 0x2::object::id<0x2::kiosk::Kiosk>(arg3));
        v4
    }

    public fun prove(arg0: &0x9252bf93053dcd0cd5ad0562303e66d6a5526d6022453b88c00dc463a012a7bf::game::Game, arg1: &mut 0x2::transfer_policy::TransferRequest<0x9252bf93053dcd0cd5ad0562303e66d6a5526d6022453b88c00dc463a012a7bf::licence::ResaleLicence>, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : u64 {
        0x9252bf93053dcd0cd5ad0562303e66d6a5526d6022453b88c00dc463a012a7bf::game::assert_current(arg0);
        let v0 = 0x2::transfer_policy::item<0x9252bf93053dcd0cd5ad0562303e66d6a5526d6022453b88c00dc463a012a7bf::licence::ResaleLicence>(arg1);
        let v1 = 0x2::clock::timestamp_ms(arg5);
        let v2 = 0x9252bf93053dcd0cd5ad0562303e66d6a5526d6022453b88c00dc463a012a7bf::game::resale_terms(arg0);
        let v3 = 0x2::kiosk::borrow_mut<0x9252bf93053dcd0cd5ad0562303e66d6a5526d6022453b88c00dc463a012a7bf::licence::ResaleLicence>(arg2, arg3, v0);
        assert!(0x9252bf93053dcd0cd5ad0562303e66d6a5526d6022453b88c00dc463a012a7bf::licence::resale_game(v3) == 0x2::object::id<0x9252bf93053dcd0cd5ad0562303e66d6a5526d6022453b88c00dc463a012a7bf::game::Game>(arg0), 502);
        let v4 = v1 - 0x9252bf93053dcd0cd5ad0562303e66d6a5526d6022453b88c00dc463a012a7bf::licence::held_since_ms(v3);
        assert!(v4 >= 0x9252bf93053dcd0cd5ad0562303e66d6a5526d6022453b88c00dc463a012a7bf::game::min_hold_ms(&v2), 503);
        0x9252bf93053dcd0cd5ad0562303e66d6a5526d6022453b88c00dc463a012a7bf::licence::set_held_since(v3, v1);
        let v5 = 0x2::transfer_policy::paid<0x9252bf93053dcd0cd5ad0562303e66d6a5526d6022453b88c00dc463a012a7bf::licence::ResaleLicence>(arg1);
        let v6 = 0x9252bf93053dcd0cd5ad0562303e66d6a5526d6022453b88c00dc463a012a7bf::game::royalty_due(&v2, v5);
        if (v6 > 0) {
            assert!(0x2::coin::value<0x2::sui::SUI>(arg4) >= v6, 504);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(arg4, v6, arg6), 0x9252bf93053dcd0cd5ad0562303e66d6a5526d6022453b88c00dc463a012a7bf::game::royalty_to(&v2));
        };
        let v7 = Rule{dummy_field: false};
        0x2::transfer_policy::add_receipt<0x9252bf93053dcd0cd5ad0562303e66d6a5526d6022453b88c00dc463a012a7bf::licence::ResaleLicence, Rule>(v7, arg1);
        0x9252bf93053dcd0cd5ad0562303e66d6a5526d6022453b88c00dc463a012a7bf::events::resold(v0, 0x2::object::id<0x9252bf93053dcd0cd5ad0562303e66d6a5526d6022453b88c00dc463a012a7bf::game::Game>(arg0), v5, v6, 0x9252bf93053dcd0cd5ad0562303e66d6a5526d6022453b88c00dc463a012a7bf::game::royalty_to(&v2), 0x2::object::id<0x2::kiosk::Kiosk>(arg2), v4);
        v6
    }

    public fun royalty_for(arg0: &0x9252bf93053dcd0cd5ad0562303e66d6a5526d6022453b88c00dc463a012a7bf::game::Game, arg1: u64) : u64 {
        let v0 = 0x9252bf93053dcd0cd5ad0562303e66d6a5526d6022453b88c00dc463a012a7bf::game::resale_terms(arg0);
        0x9252bf93053dcd0cd5ad0562303e66d6a5526d6022453b88c00dc463a012a7bf::game::royalty_due(&v0, arg1)
    }

    public fun sellable_at(arg0: &0x9252bf93053dcd0cd5ad0562303e66d6a5526d6022453b88c00dc463a012a7bf::game::Game, arg1: &0x9252bf93053dcd0cd5ad0562303e66d6a5526d6022453b88c00dc463a012a7bf::licence::ResaleLicence) : u64 {
        let v0 = 0x9252bf93053dcd0cd5ad0562303e66d6a5526d6022453b88c00dc463a012a7bf::game::resale_terms(arg0);
        0x9252bf93053dcd0cd5ad0562303e66d6a5526d6022453b88c00dc463a012a7bf::licence::held_since_ms(arg1) + 0x9252bf93053dcd0cd5ad0562303e66d6a5526d6022453b88c00dc463a012a7bf::game::min_hold_ms(&v0)
    }

    // decompiled from Move bytecode v7
}

