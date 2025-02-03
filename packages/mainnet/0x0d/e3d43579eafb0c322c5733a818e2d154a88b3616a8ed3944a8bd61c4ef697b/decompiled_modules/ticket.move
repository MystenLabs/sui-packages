module 0xb1bd3db2664e3d980fa8e6f2a5391cad98bc082f8fec3ed62459b3731983e5e::ticket {
    struct Mint<phantom T0> has copy, drop {
        id: 0x2::object::ID,
        buyer: address,
        sender: address,
        referrer: 0x1::option::Option<address>,
        cost: u64,
    }

    struct Buy has copy, drop {
        coin_type: 0x1::ascii::String,
        buyer: address,
        sender: address,
        referrer: 0x1::option::Option<address>,
        count: u64,
        payment: u64,
    }

    struct Open<phantom T0> has copy, drop {
        opener: address,
        sender: address,
    }

    struct TICKET has drop {
        dummy_field: bool,
    }

    struct Ticket<phantom T0> has store, key {
        id: 0x2::object::UID,
        sender: address,
    }

    public fun sender<T0>(arg0: &Ticket<T0>) : address {
        arg0.sender
    }

    public fun buy<T0>(arg0: &0x2::clock::Clock, arg1: &0xb1bd3db2664e3d980fa8e6f2a5391cad98bc082f8fec3ed62459b3731983e5e::listing::CoinTypeWhitelist, arg2: &0xb1bd3db2664e3d980fa8e6f2a5391cad98bc082f8fec3ed62459b3731983e5e::oracle::Oracle, arg3: &mut 0xb1bd3db2664e3d980fa8e6f2a5391cad98bc082f8fec3ed62459b3731983e5e::game_status::GameStatus, arg4: &mut 0xb1bd3db2664e3d980fa8e6f2a5391cad98bc082f8fec3ed62459b3731983e5e::profile_manager::ProfileManager, arg5: &mut 0xb1bd3db2664e3d980fa8e6f2a5391cad98bc082f8fec3ed62459b3731983e5e::trove_manager::TroveManager, arg6: &mut 0xb1bd3db2664e3d980fa8e6f2a5391cad98bc082f8fec3ed62459b3731983e5e::final::FinalPool, arg7: &mut 0xb1bd3db2664e3d980fa8e6f2a5391cad98bc082f8fec3ed62459b3731983e5e::lootbox::LootboxPool, arg8: &mut 0x2::coin::Coin<T0>, arg9: u64, arg10: 0x1::option::Option<address>, arg11: address, arg12: &mut 0x2::tx_context::TxContext) : vector<Ticket<T0>> {
        0xb1bd3db2664e3d980fa8e6f2a5391cad98bc082f8fec3ed62459b3731983e5e::game_status::assert_valid_package_version(arg3);
        0xb1bd3db2664e3d980fa8e6f2a5391cad98bc082f8fec3ed62459b3731983e5e::game_status::assert_game_is_not_ended(arg3, arg0);
        let v0 = 0x2::tx_context::sender(arg12);
        let v1 = 0xb1bd3db2664e3d980fa8e6f2a5391cad98bc082f8fec3ed62459b3731983e5e::oracle::ticket_price<T0>(arg2, arg0, 0xb1bd3db2664e3d980fa8e6f2a5391cad98bc082f8fec3ed62459b3731983e5e::game_status::cliff_time(arg3));
        let v2 = arg9 * v1;
        let v3 = 0x2::coin::value<T0>(arg8);
        let v4 = if (v3 == 0) {
            0xb1bd3db2664e3d980fa8e6f2a5391cad98bc082f8fec3ed62459b3731983e5e::trove_manager::take_coin_from_trove<T0>(arg5, 0xb1bd3db2664e3d980fa8e6f2a5391cad98bc082f8fec3ed62459b3731983e5e::math::mul_and_div(v2, 7, 10), arg12)
        } else {
            if (v3 < v2) {
                err_payment_not_enough();
            };
            0x2::coin::split<T0>(arg8, v2, arg12)
        };
        0xb1bd3db2664e3d980fa8e6f2a5391cad98bc082f8fec3ed62459b3731983e5e::profile_manager::create_profile<T0>(arg4, v0, arg10, false, arg12);
        0xb1bd3db2664e3d980fa8e6f2a5391cad98bc082f8fec3ed62459b3731983e5e::profile_manager::extend_team_size(arg4, v0, arg9);
        if (0xb1bd3db2664e3d980fa8e6f2a5391cad98bc082f8fec3ed62459b3731983e5e::listing::coin_type_is_listed<T0>(arg1)) {
            let (v5, v6, v7, v8) = 0xb1bd3db2664e3d980fa8e6f2a5391cad98bc082f8fec3ed62459b3731983e5e::splitter::split_the_coin<T0>(v4, arg12);
            let v9 = v8;
            0xb1bd3db2664e3d980fa8e6f2a5391cad98bc082f8fec3ed62459b3731983e5e::final::deposit<T0>(arg1, arg6, arg3, arg0, v5, arg12);
            0xb1bd3db2664e3d980fa8e6f2a5391cad98bc082f8fec3ed62459b3731983e5e::lootbox::deposit<T0>(arg1, arg7, arg3, arg0, v6, arg12);
            0xb1bd3db2664e3d980fa8e6f2a5391cad98bc082f8fec3ed62459b3731983e5e::lootbox::add_buyer(arg7, arg3, arg0, v0, arg9);
            let (v10, v11) = 0xb1bd3db2664e3d980fa8e6f2a5391cad98bc082f8fec3ed62459b3731983e5e::profile_manager::get_seniors(arg4, v0);
            let v12 = v11;
            let v13 = v10;
            if (0x1::option::is_some<address>(&v13)) {
                0xb1bd3db2664e3d980fa8e6f2a5391cad98bc082f8fec3ed62459b3731983e5e::trove_manager::put_coin_into_user_trove<T0>(arg5, 0x1::option::destroy_some<address>(v13), v7, b"direct_from_ticket", 0x1::option::some<address>(v0), arg12);
            } else {
                0xb1bd3db2664e3d980fa8e6f2a5391cad98bc082f8fec3ed62459b3731983e5e::final::deposit<T0>(arg1, arg6, arg3, arg0, v7, arg12);
            };
            let v14 = 0x1::vector::length<address>(&v12);
            if (v14 > 0) {
                while (!0x1::vector::is_empty<address>(&v12)) {
                    let v15 = 0x1::vector::pop_back<address>(&mut v12);
                    let v16 = if (0xb1bd3db2664e3d980fa8e6f2a5391cad98bc082f8fec3ed62459b3731983e5e::profile_manager::get_score(arg4, v15) >= 0xb1bd3db2664e3d980fa8e6f2a5391cad98bc082f8fec3ed62459b3731983e5e::config::score_threshold()) {
                        0x2::coin::value<T0>(&v9) / v14
                    } else {
                        0x2::coin::value<T0>(&v9) / v14 / 2
                    };
                    0xb1bd3db2664e3d980fa8e6f2a5391cad98bc082f8fec3ed62459b3731983e5e::trove_manager::put_coin_into_user_trove<T0>(arg5, v15, 0x2::coin::split<T0>(&mut v9, v16, arg12), b"indirect_from_ticket", 0x1::option::some<address>(v0), arg12);
                };
            };
            0xb1bd3db2664e3d980fa8e6f2a5391cad98bc082f8fec3ed62459b3731983e5e::final::deposit<T0>(arg1, arg6, arg3, arg0, v9, arg12);
        } else {
            0xb1bd3db2664e3d980fa8e6f2a5391cad98bc082f8fec3ed62459b3731983e5e::final::lock<T0>(arg6, v4, arg12);
        };
        let v17 = 0x1::vector::empty<Ticket<T0>>();
        let v18 = 0;
        while (v18 < arg9) {
            let v19 = Ticket<T0>{
                id     : 0x2::object::new(arg12),
                sender : arg11,
            };
            let v20 = Mint<T0>{
                id       : 0x2::object::id<Ticket<T0>>(&v19),
                buyer    : v0,
                sender   : arg11,
                referrer : arg10,
                cost     : v1,
            };
            0x2::event::emit<Mint<T0>>(v20);
            0x1::vector::push_back<Ticket<T0>>(&mut v17, v19);
            v18 = v18 + 1;
        };
        let v21 = Buy{
            coin_type : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            buyer     : v0,
            sender    : arg11,
            referrer  : arg10,
            count     : arg9,
            payment   : v2,
        };
        0x2::event::emit<Buy>(v21);
        v17
    }

    fun err_payment_not_enough() {
        abort 0
    }

    fun init(arg0: TICKET, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"BuckYou BlastOff! Boarding Pass"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Destination: The moon. Your rocket ship ticket to a brighter tomorrow!"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://dweb.link/ipfs/bafybeidjoulhiwjj57c7skjoypmqxieafna3llkljgxbr6lmgplfu5mkye"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://www.doubleup.fun/blastoff"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"DoubleUp X Bucket"));
        let v4 = 0x2::tx_context::sender(arg1);
        let v5 = 0x2::package::claim<TICKET>(arg0, arg1);
        let v6 = 0x2::display::new_with_fields<Ticket<0x2::sui::SUI>>(&v5, v0, v2, arg1);
        0x2::display::update_version<Ticket<0x2::sui::SUI>>(&mut v6);
        0x2::transfer::public_transfer<0x2::display::Display<Ticket<0x2::sui::SUI>>>(v6, v4);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v5, v4);
    }

    public fun open<T0>(arg0: &0x2::clock::Clock, arg1: &mut 0xb1bd3db2664e3d980fa8e6f2a5391cad98bc082f8fec3ed62459b3731983e5e::game_status::GameStatus, arg2: &mut 0xb1bd3db2664e3d980fa8e6f2a5391cad98bc082f8fec3ed62459b3731983e5e::profile_manager::ProfileManager, arg3: &mut 0xb1bd3db2664e3d980fa8e6f2a5391cad98bc082f8fec3ed62459b3731983e5e::final::FinalPool, arg4: Ticket<T0>, arg5: &mut 0x2::tx_context::TxContext) {
        0xb1bd3db2664e3d980fa8e6f2a5391cad98bc082f8fec3ed62459b3731983e5e::game_status::assert_valid_package_version(arg1);
        0xb1bd3db2664e3d980fa8e6f2a5391cad98bc082f8fec3ed62459b3731983e5e::game_status::assert_game_is_started(arg1, arg0);
        0xb1bd3db2664e3d980fa8e6f2a5391cad98bc082f8fec3ed62459b3731983e5e::game_status::assert_game_is_not_ended(arg1, arg0);
        let v0 = 0x2::tx_context::sender(arg5);
        0xb1bd3db2664e3d980fa8e6f2a5391cad98bc082f8fec3ed62459b3731983e5e::profile_manager::create_profile<T0>(arg2, v0, 0x1::option::some<address>(arg4.sender), true, arg5);
        0xb1bd3db2664e3d980fa8e6f2a5391cad98bc082f8fec3ed62459b3731983e5e::game_status::increase_end_time(arg1, arg0);
        0xb1bd3db2664e3d980fa8e6f2a5391cad98bc082f8fec3ed62459b3731983e5e::final::add_opener(arg3, v0);
        let Ticket {
            id     : v1,
            sender : v2,
        } = arg4;
        0x2::object::delete(v1);
        let v3 = Open<T0>{
            opener : v0,
            sender : v2,
        };
        0x2::event::emit<Open<T0>>(v3);
    }

    public fun redeem<T0: store + key>(arg0: &0x2::clock::Clock, arg1: &0xb1bd3db2664e3d980fa8e6f2a5391cad98bc082f8fec3ed62459b3731983e5e::listing::ObjectTypeWhitelist, arg2: &mut 0xb1bd3db2664e3d980fa8e6f2a5391cad98bc082f8fec3ed62459b3731983e5e::game_status::GameStatus, arg3: &mut 0xb1bd3db2664e3d980fa8e6f2a5391cad98bc082f8fec3ed62459b3731983e5e::profile_manager::ProfileManager, arg4: &0xb1bd3db2664e3d980fa8e6f2a5391cad98bc082f8fec3ed62459b3731983e5e::final::FinalPool, arg5: T0, arg6: 0x1::option::Option<address>, arg7: address, arg8: &mut 0x2::tx_context::TxContext) : Ticket<T0> {
        0xb1bd3db2664e3d980fa8e6f2a5391cad98bc082f8fec3ed62459b3731983e5e::game_status::assert_valid_package_version(arg2);
        0xb1bd3db2664e3d980fa8e6f2a5391cad98bc082f8fec3ed62459b3731983e5e::game_status::assert_game_is_not_ended(arg2, arg0);
        0xb1bd3db2664e3d980fa8e6f2a5391cad98bc082f8fec3ed62459b3731983e5e::listing::assert_object_type_is_listed<T0>(arg1);
        let v0 = 0x2::tx_context::sender(arg8);
        0xb1bd3db2664e3d980fa8e6f2a5391cad98bc082f8fec3ed62459b3731983e5e::profile_manager::create_profile<T0>(arg3, v0, arg6, false, arg8);
        0xb1bd3db2664e3d980fa8e6f2a5391cad98bc082f8fec3ed62459b3731983e5e::profile_manager::extend_team_size(arg3, v0, 1);
        0x2::transfer::public_transfer<T0>(arg5, 0xb1bd3db2664e3d980fa8e6f2a5391cad98bc082f8fec3ed62459b3731983e5e::final::dev(arg4));
        let v1 = Ticket<T0>{
            id     : 0x2::object::new(arg8),
            sender : arg7,
        };
        let v2 = Mint<T0>{
            id       : 0x2::object::id<Ticket<T0>>(&v1),
            buyer    : v0,
            sender   : arg7,
            referrer : arg6,
            cost     : 0,
        };
        0x2::event::emit<Mint<T0>>(v2);
        v1
    }

    // decompiled from Move bytecode v6
}

