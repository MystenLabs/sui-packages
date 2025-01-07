module 0xb1bd3db2664e3d980fa8e6f2a5391cad98bc082f8fec3ed62459b3731983e5e::lootbox {
    struct Deposit<phantom T0> has copy, drop {
        amount: u64,
        pool_size: u64,
    }

    struct RaffleResult has copy, drop {
        epoch: u64,
        winners: vector<address>,
    }

    struct RafflePrize has copy, drop {
        coin_type: 0x1::ascii::String,
        epoch: u64,
        total_prize: u64,
    }

    struct LootboxPool has key {
        id: 0x2::object::UID,
        verifier_pub_key: vector<u8>,
        periods: 0x2::object_table::ObjectTable<u64, RafflePeriod>,
        dev: address,
    }

    struct RafflePeriod has store, key {
        id: 0x2::object::UID,
        pools: 0x2::bag::Bag,
        is_raffled: bool,
        buyers: 0xad70e60e8631f45b6c528bdf054a733c57d6e979bc601b2b8d1c10ce12d39866::big_vector::BigVector<address>,
        winners: vector<address>,
    }

    public(friend) fun add_buyer(arg0: &mut LootboxPool, arg1: &0xb1bd3db2664e3d980fa8e6f2a5391cad98bc082f8fec3ed62459b3731983e5e::game_status::GameStatus, arg2: &0x2::clock::Clock, arg3: address, arg4: u64) {
        let v0 = 0x2::object_table::borrow_mut<u64, RafflePeriod>(&mut arg0.periods, 0xb1bd3db2664e3d980fa8e6f2a5391cad98bc082f8fec3ed62459b3731983e5e::game_status::raffle_epoch(arg1, arg2));
        let v1 = 0;
        while (v1 < arg4) {
            0xad70e60e8631f45b6c528bdf054a733c57d6e979bc601b2b8d1c10ce12d39866::big_vector::push_back<address>(&mut v0.buyers, arg3);
            v1 = v1 + 1;
        };
    }

    public fun buyers(arg0: &LootboxPool, arg1: u64) : &0xad70e60e8631f45b6c528bdf054a733c57d6e979bc601b2b8d1c10ce12d39866::big_vector::BigVector<address> {
        &0x2::object_table::borrow<u64, RafflePeriod>(&arg0.periods, arg1).buyers
    }

    public fun deposit<T0>(arg0: &0xb1bd3db2664e3d980fa8e6f2a5391cad98bc082f8fec3ed62459b3731983e5e::listing::CoinTypeWhitelist, arg1: &mut LootboxPool, arg2: &0xb1bd3db2664e3d980fa8e6f2a5391cad98bc082f8fec3ed62459b3731983e5e::game_status::GameStatus, arg3: &0x2::clock::Clock, arg4: 0x2::coin::Coin<T0>, arg5: &mut 0x2::tx_context::TxContext) {
        0xb1bd3db2664e3d980fa8e6f2a5391cad98bc082f8fec3ed62459b3731983e5e::game_status::assert_game_is_not_ended(arg2, arg3);
        0xb1bd3db2664e3d980fa8e6f2a5391cad98bc082f8fec3ed62459b3731983e5e::game_status::assert_valid_package_version(arg2);
        let v0 = 0xb1bd3db2664e3d980fa8e6f2a5391cad98bc082f8fec3ed62459b3731983e5e::listing::assert_coin_type_is_listed<T0>(arg0);
        let v1 = 0xb1bd3db2664e3d980fa8e6f2a5391cad98bc082f8fec3ed62459b3731983e5e::game_status::raffle_epoch(arg2, arg3);
        if (!0x2::object_table::contains<u64, RafflePeriod>(&arg1.periods, v1)) {
            let v2 = RafflePeriod{
                id         : 0x2::object::new(arg5),
                pools      : 0x2::bag::new(arg5),
                is_raffled : false,
                buyers     : 0xad70e60e8631f45b6c528bdf054a733c57d6e979bc601b2b8d1c10ce12d39866::big_vector::new<address>(1000, arg5),
                winners    : vector[],
            };
            0x2::object_table::add<u64, RafflePeriod>(&mut arg1.periods, v1, v2);
        };
        let v3 = &mut 0x2::object_table::borrow_mut<u64, RafflePeriod>(&mut arg1.periods, v1).pools;
        if (!0x2::bag::contains<0x1::type_name::TypeName>(v3, v0)) {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(v3, v0, 0x2::balance::zero<T0>());
        };
        0x2::coin::put<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(v3, v0), arg4);
        let v4 = Deposit<T0>{
            amount    : 0x2::coin::value<T0>(&arg4),
            pool_size : pool_size<T0>(arg1, v1),
        };
        0x2::event::emit<Deposit<T0>>(v4);
    }

    public fun destroy(arg0: &mut LootboxPool, arg1: u64) {
        if (!0x2::object_table::contains<u64, RafflePeriod>(&arg0.periods, arg1)) {
            return
        };
        let RafflePeriod {
            id         : v0,
            pools      : v1,
            is_raffled : _,
            buyers     : v3,
            winners    : _,
        } = 0x2::object_table::remove<u64, RafflePeriod>(&mut arg0.periods, arg1);
        let v5 = v1;
        if (!0x2::bag::is_empty(&v5)) {
            err_pools_not_empty();
        };
        0x2::object::delete(v0);
        0x2::bag::destroy_empty(v5);
        0xad70e60e8631f45b6c528bdf054a733c57d6e979bc601b2b8d1c10ce12d39866::big_vector::drop<address>(v3);
    }

    fun err_epoch_already_raffled() {
        abort 2
    }

    fun err_epoch_not_ended() {
        abort 1
    }

    fun err_epoch_not_exists() {
        abort 0
    }

    fun err_epoch_not_raffled() {
        abort 3
    }

    fun err_pools_not_empty() {
        abort 4
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = LootboxPool{
            id               : 0x2::object::new(arg0),
            verifier_pub_key : x"b04e14aceb32878f20540c37a7772a0db5fa84fc40d1b534d0f0792ea9715112a7a10ca9884424590b964f340a1d67ac",
            periods          : 0x2::object_table::new<u64, RafflePeriod>(arg0),
            dev              : 0x2::tx_context::sender(arg0),
        };
        0x2::transfer::share_object<LootboxPool>(v0);
    }

    public fun pool_size<T0>(arg0: &LootboxPool, arg1: u64) : u64 {
        let v0 = 0x1::type_name::get<T0>();
        if (!0x2::object_table::contains<u64, RafflePeriod>(&arg0.periods, arg1)) {
            return 0
        };
        let v1 = 0x2::object_table::borrow<u64, RafflePeriod>(&arg0.periods, arg1);
        if (0x2::bag::contains<0x1::type_name::TypeName>(&v1.pools, v0)) {
            0x2::balance::value<T0>(0x2::bag::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&v1.pools, v0))
        } else {
            0
        }
    }

    public fun raffle(arg0: &mut LootboxPool, arg1: &0xb1bd3db2664e3d980fa8e6f2a5391cad98bc082f8fec3ed62459b3731983e5e::game_status::GameStatus, arg2: &0x2::clock::Clock, arg3: u64, arg4: vector<u8>) {
        0xb1bd3db2664e3d980fa8e6f2a5391cad98bc082f8fec3ed62459b3731983e5e::game_status::assert_valid_package_version(arg1);
        if (!0x2::object_table::contains<u64, RafflePeriod>(&arg0.periods, arg3)) {
            err_epoch_not_exists();
        };
        if (arg3 >= 0xb1bd3db2664e3d980fa8e6f2a5391cad98bc082f8fec3ed62459b3731983e5e::game_status::raffle_epoch(arg1, arg2)) {
            err_epoch_not_ended();
        };
        let v0 = arg0.verifier_pub_key;
        let v1 = 0x2::object_table::borrow_mut<u64, RafflePeriod>(&mut arg0.periods, arg3);
        if (v1.is_raffled) {
            err_epoch_already_raffled();
        };
        let v2 = 0x2::object::uid_to_bytes(&v1.id);
        let v3 = 0xb1bd3db2664e3d980fa8e6f2a5391cad98bc082f8fec3ed62459b3731983e5e::math::verify_bls_sig_and_give_results(&mut arg4, &v0, &v2, 0xad70e60e8631f45b6c528bdf054a733c57d6e979bc601b2b8d1c10ce12d39866::big_vector::length<address>(&v1.buyers), 0xb1bd3db2664e3d980fa8e6f2a5391cad98bc082f8fec3ed62459b3731983e5e::config::raffle_winner_count());
        let v4 = vector[];
        while (!0x1::vector::is_empty<u64>(&v3)) {
            0x1::vector::push_back<address>(&mut v4, *0xad70e60e8631f45b6c528bdf054a733c57d6e979bc601b2b8d1c10ce12d39866::big_vector::borrow<address>(&v1.buyers, 0x1::vector::pop_back<u64>(&mut v3)));
        };
        v1.winners = v4;
        v1.is_raffled = true;
        let v5 = RaffleResult{
            epoch   : arg3,
            winners : v4,
        };
        0x2::event::emit<RaffleResult>(v5);
    }

    public fun settle<T0>(arg0: &mut LootboxPool, arg1: &mut 0xb1bd3db2664e3d980fa8e6f2a5391cad98bc082f8fec3ed62459b3731983e5e::trove_manager::TroveManager, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        if (!0x2::object_table::contains<u64, RafflePeriod>(&arg0.periods, arg2)) {
            err_epoch_not_exists();
        };
        let v0 = 0x2::object_table::borrow_mut<u64, RafflePeriod>(&mut arg0.periods, arg2);
        if (!v0.is_raffled) {
            err_epoch_not_raffled();
        };
        let v1 = 0x1::type_name::get<T0>();
        if (!0x2::bag::contains<0x1::type_name::TypeName>(&v0.pools, v1)) {
            return
        };
        let v2 = 0x2::bag::remove<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut v0.pools, v1);
        let v3 = 0x2::balance::value<T0>(&v2);
        let v4 = 0x1::vector::length<address>(&v0.winners);
        let v5 = 0;
        if (v4 > 0) {
            while (v5 < v4) {
                0xb1bd3db2664e3d980fa8e6f2a5391cad98bc082f8fec3ed62459b3731983e5e::trove_manager::put_coin_into_user_trove<T0>(arg1, *0x1::vector::borrow<address>(&v0.winners, v5), 0x2::coin::take<T0>(&mut v2, v3 / v4, arg3), b"raffle", 0x1::option::none<address>(), arg3);
                v5 = v5 + 1;
            };
        };
        0xb1bd3db2664e3d980fa8e6f2a5391cad98bc082f8fec3ed62459b3731983e5e::trove_manager::put_coin_into_user_trove<T0>(arg1, arg0.dev, 0x2::coin::from_balance<T0>(v2, arg3), b"raffle", 0x1::option::none<address>(), arg3);
        let v6 = RafflePrize{
            coin_type   : 0x1::type_name::into_string(v1),
            epoch       : arg2,
            total_prize : v3,
        };
        0x2::event::emit<RafflePrize>(v6);
    }

    // decompiled from Move bytecode v6
}

