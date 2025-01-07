module 0xd441d82fa791d7e7fc89eb2a40b0714bd9a6a1aaf0c897d702802d30109c1f7b::lootbox {
    struct Deposit<phantom T0> has copy, drop {
        amount: u64,
    }

    struct RafflePrize<phantom T0> has copy, drop {
        opener: address,
        reward_amount: u64,
        free_one: bool,
    }

    struct LootboxPool has key {
        id: 0x2::object::UID,
        is_ended: bool,
        verifier_pub_key: vector<u8>,
        raffle_center: 0x2::table::Table<RaffleTicket, address>,
    }

    struct RaffleTicket has copy, drop, store {
        coin_type: 0x1::ascii::String,
        seed: vector<u8>,
    }

    struct RedEnvelopeVoucher<phantom T0> {
        opener: address,
    }

    public(friend) fun add_ticket<T0>(arg0: &mut LootboxPool, arg1: vector<u8>, arg2: address) {
        0x2::table::add<RaffleTicket, address>(&mut arg0.raffle_center, new_ticket<T0>(arg1), arg2);
    }

    public fun deposit<T0>(arg0: &0xd441d82fa791d7e7fc89eb2a40b0714bd9a6a1aaf0c897d702802d30109c1f7b::listing::CoinTypeWhitelist, arg1: &mut LootboxPool, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg1.is_ended, 0);
        let v0 = 0xd441d82fa791d7e7fc89eb2a40b0714bd9a6a1aaf0c897d702802d30109c1f7b::listing::assert_coin_type_is_listed<T0>(arg0);
        let v1 = &mut arg1.id;
        if (!0x2::dynamic_object_field::exists_with_type<0x1::type_name::TypeName, 0x2::coin::Coin<T0>>(v1, v0)) {
            0x2::dynamic_object_field::add<0x1::type_name::TypeName, 0x2::coin::Coin<T0>>(v1, v0, 0x2::coin::zero<T0>(arg3));
        };
        let v2 = Deposit<T0>{amount: 0x2::coin::value<T0>(&arg2)};
        0x2::event::emit<Deposit<T0>>(v2);
        0x2::coin::join<T0>(0x2::dynamic_object_field::borrow_mut<0x1::type_name::TypeName, 0x2::coin::Coin<T0>>(v1, v0), arg2);
    }

    public(friend) fun destroy_voucher<T0>(arg0: RedEnvelopeVoucher<T0>) : address {
        let RedEnvelopeVoucher { opener: v0 } = arg0;
        v0
    }

    fun get_the_prize<T0>(arg0: u64, arg1: address) : (0x1::option::Option<u64>, 0x1::option::Option<RedEnvelopeVoucher<T0>>) {
        if (arg0 < 200) {
            let v2 = RedEnvelopeVoucher<T0>{opener: arg1};
            (0x1::option::none<u64>(), 0x1::option::some<RedEnvelopeVoucher<T0>>(v2))
        } else if (arg0 >= 200 && arg0 < 500) {
            (0x1::option::some<u64>(1), 0x1::option::none<RedEnvelopeVoucher<T0>>())
        } else if (arg0 >= 500 && arg0 < 650) {
            (0x1::option::some<u64>(5), 0x1::option::none<RedEnvelopeVoucher<T0>>())
        } else if (arg0 >= 650 && arg0 < 750) {
            (0x1::option::some<u64>(10), 0x1::option::none<RedEnvelopeVoucher<T0>>())
        } else if (arg0 >= 750 && arg0 < 800) {
            (0x1::option::some<u64>(20), 0x1::option::none<RedEnvelopeVoucher<T0>>())
        } else if (arg0 >= 800 && arg0 < 810) {
            (0x1::option::some<u64>(100), 0x1::option::none<RedEnvelopeVoucher<T0>>())
        } else {
            let (v3, v4) = if (arg0 >= 810 && arg0 < 815) {
                (0x1::option::none<RedEnvelopeVoucher<T0>>(), 0x1::option::some<u64>(200))
            } else {
                let (v5, v6) = if (arg0 == 816) {
                    (0x1::option::some<u64>(500), 0x1::option::none<RedEnvelopeVoucher<T0>>())
                } else {
                    (0x1::option::none<u64>(), 0x1::option::none<RedEnvelopeVoucher<T0>>())
                };
                (v6, v5)
            };
            (v4, v3)
        }
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = LootboxPool{
            id               : 0x2::object::new(arg0),
            is_ended         : false,
            verifier_pub_key : x"b04e14aceb32878f20540c37a7772a0db5fa84fc40d1b534d0f0792ea9715112a7a10ca9884424590b964f340a1d67ac",
            raffle_center    : 0x2::table::new<RaffleTicket, address>(arg0),
        };
        0x2::transfer::share_object<LootboxPool>(v0);
    }

    public fun is_ended(arg0: &LootboxPool) : bool {
        arg0.is_ended
    }

    fun new_ticket<T0>(arg0: vector<u8>) : RaffleTicket {
        RaffleTicket{
            coin_type : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            seed      : arg0,
        }
    }

    public fun pool_balance<T0>(arg0: &LootboxPool) : u64 {
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::dynamic_object_field::exists_with_type<0x1::type_name::TypeName, 0x2::coin::Coin<T0>>(&arg0.id, v0), 2);
        0x2::coin::value<T0>(0x2::dynamic_object_field::borrow<0x1::type_name::TypeName, 0x2::coin::Coin<T0>>(&arg0.id, v0))
    }

    public(friend) fun set_ended(arg0: &mut LootboxPool) {
        arg0.is_ended = true;
    }

    public fun settle<T0>(arg0: &mut LootboxPool, arg1: &mut 0xd441d82fa791d7e7fc89eb2a40b0714bd9a6a1aaf0c897d702802d30109c1f7b::trove_manager::TroveManager, arg2: vector<u8>, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<RedEnvelopeVoucher<T0>> {
        let v0 = new_ticket<T0>(arg2);
        let v1 = arg0.verifier_pub_key;
        let v2 = &mut arg0.raffle_center;
        if (!0x2::table::contains<RaffleTicket, address>(v2, v0)) {
            return 0x1::option::none<RedEnvelopeVoucher<T0>>()
        };
        let v3 = 0x2::table::remove<RaffleTicket, address>(v2, v0);
        let (v4, v5) = get_the_prize<T0>(0xd441d82fa791d7e7fc89eb2a40b0714bd9a6a1aaf0c897d702802d30109c1f7b::math::verify_bls_sig_and_give_result(&arg3, &v1, &arg2, 1000), v3);
        let v6 = v5;
        let v7 = v4;
        let v8 = if (0x1::option::is_some<u64>(&v7)) {
            let v9 = 0x2::dynamic_object_field::borrow_mut<0x1::type_name::TypeName, 0x2::coin::Coin<T0>>(&mut arg0.id, 0x1::type_name::get<T0>());
            let v10 = 0xd441d82fa791d7e7fc89eb2a40b0714bd9a6a1aaf0c897d702802d30109c1f7b::math::mul_and_div(0x2::coin::value<T0>(v9), 0x1::option::destroy_some<u64>(v7), 1000);
            0xd441d82fa791d7e7fc89eb2a40b0714bd9a6a1aaf0c897d702802d30109c1f7b::trove_manager::put_coin_into_user_trove<T0>(arg1, v3, 0x2::coin::split<T0>(v9, v10, arg4), b"raffle", 0x1::option::none<address>(), arg4);
            v10
        } else {
            0
        };
        let v11 = RafflePrize<T0>{
            opener        : v3,
            reward_amount : v8,
            free_one      : 0x1::option::is_some<RedEnvelopeVoucher<T0>>(&v6),
        };
        0x2::event::emit<RafflePrize<T0>>(v11);
        v6
    }

    public(friend) fun withdraw_all_after_game_ended<T0>(arg0: &mut LootboxPool) : 0x2::balance::Balance<T0> {
        assert!(arg0.is_ended, 1);
        let v0 = 0x1::type_name::get<T0>();
        if (0x2::dynamic_object_field::exists_with_type<0x1::type_name::TypeName, 0x2::coin::Coin<T0>>(&arg0.id, v0)) {
            0x2::balance::withdraw_all<T0>(0x2::coin::balance_mut<T0>(0x2::dynamic_object_field::borrow_mut<0x1::type_name::TypeName, 0x2::coin::Coin<T0>>(&mut arg0.id, v0)))
        } else {
            0x2::balance::zero<T0>()
        }
    }

    // decompiled from Move bytecode v6
}

