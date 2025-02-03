module 0xd441d82fa791d7e7fc89eb2a40b0714bd9a6a1aaf0c897d702802d30109c1f7b::red_envelope {
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
        seed: vector<u8>,
    }

    struct RED_ENVELOPE has drop {
        dummy_field: bool,
    }

    struct RedEnvelope<phantom T0> has store, key {
        id: 0x2::object::UID,
        sender: address,
    }

    public fun sender<T0>(arg0: &RedEnvelope<T0>) : address {
        arg0.sender
    }

    public fun burn<T0>(arg0: RedEnvelope<T0>) {
        let RedEnvelope {
            id     : v0,
            sender : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun buy<T0>(arg0: &0x2::clock::Clock, arg1: &0xd441d82fa791d7e7fc89eb2a40b0714bd9a6a1aaf0c897d702802d30109c1f7b::listing::CoinTypeWhitelist, arg2: &0xd441d82fa791d7e7fc89eb2a40b0714bd9a6a1aaf0c897d702802d30109c1f7b::oracle::Oracle, arg3: &mut 0xd441d82fa791d7e7fc89eb2a40b0714bd9a6a1aaf0c897d702802d30109c1f7b::game_status::GameStatus, arg4: &mut 0xd441d82fa791d7e7fc89eb2a40b0714bd9a6a1aaf0c897d702802d30109c1f7b::referral_manager::ReferralManager, arg5: &mut 0xd441d82fa791d7e7fc89eb2a40b0714bd9a6a1aaf0c897d702802d30109c1f7b::trove_manager::TroveManager, arg6: &mut 0xd441d82fa791d7e7fc89eb2a40b0714bd9a6a1aaf0c897d702802d30109c1f7b::final::FinalPool, arg7: &mut 0xd441d82fa791d7e7fc89eb2a40b0714bd9a6a1aaf0c897d702802d30109c1f7b::lootbox::LootboxPool, arg8: &mut 0xd441d82fa791d7e7fc89eb2a40b0714bd9a6a1aaf0c897d702802d30109c1f7b::leaderboard::Leaderboard, arg9: &mut 0x2::coin::Coin<T0>, arg10: u64, arg11: 0x1::option::Option<address>, arg12: address, arg13: &mut 0x2::tx_context::TxContext) : vector<RedEnvelope<T0>> {
        0xd441d82fa791d7e7fc89eb2a40b0714bd9a6a1aaf0c897d702802d30109c1f7b::game_status::assert_game_is_not_ended(arg3, arg0);
        let v0 = 0x2::tx_context::sender(arg13);
        let v1 = 0xd441d82fa791d7e7fc89eb2a40b0714bd9a6a1aaf0c897d702802d30109c1f7b::oracle::red_envelop_price<T0>(arg2, arg0);
        let v2 = arg10 * v1;
        let v3 = 0x2::coin::value<T0>(arg9);
        let v4 = if (v3 == 0) {
            0xd441d82fa791d7e7fc89eb2a40b0714bd9a6a1aaf0c897d702802d30109c1f7b::trove_manager::take_coin_from_trove<T0>(arg5, 0xd441d82fa791d7e7fc89eb2a40b0714bd9a6a1aaf0c897d702802d30109c1f7b::math::mul_and_div(v2, 7, 10), arg13)
        } else {
            assert!(v3 >= v2, 0);
            0x2::coin::split<T0>(arg9, v2, arg13)
        };
        if (0x1::option::is_some<address>(&arg11)) {
            0xd441d82fa791d7e7fc89eb2a40b0714bd9a6a1aaf0c897d702802d30109c1f7b::referral_manager::set_referrer<T0>(arg4, v0, 0x1::option::destroy_some<address>(arg11), false);
        };
        let v5 = 0xd441d82fa791d7e7fc89eb2a40b0714bd9a6a1aaf0c897d702802d30109c1f7b::referral_manager::try_get_referrer(arg4, v0);
        let v6 = 0x1::option::is_some<address>(&v5);
        let (v7, v8, v9, v10) = 0xd441d82fa791d7e7fc89eb2a40b0714bd9a6a1aaf0c897d702802d30109c1f7b::splitter::split_the_coin<T0>(v4, v6, arg13);
        0xd441d82fa791d7e7fc89eb2a40b0714bd9a6a1aaf0c897d702802d30109c1f7b::final::deposit<T0>(arg1, arg6, v7, arg13);
        0xd441d82fa791d7e7fc89eb2a40b0714bd9a6a1aaf0c897d702802d30109c1f7b::lootbox::deposit<T0>(arg1, arg7, v8, arg13);
        0xd441d82fa791d7e7fc89eb2a40b0714bd9a6a1aaf0c897d702802d30109c1f7b::leaderboard::deposit<T0>(arg1, arg8, arg5, v9, arg13);
        if (v6) {
            0xd441d82fa791d7e7fc89eb2a40b0714bd9a6a1aaf0c897d702802d30109c1f7b::trove_manager::put_coin_into_user_trove<T0>(arg5, 0x1::option::destroy_some<address>(v5), v10, b"referee", 0x1::option::some<address>(v0), arg13);
        } else {
            0x2::coin::destroy_zero<T0>(v10);
        };
        let v11 = 0x1::vector::empty<RedEnvelope<T0>>();
        let v12 = 0;
        while (v12 < arg10) {
            0xd441d82fa791d7e7fc89eb2a40b0714bd9a6a1aaf0c897d702802d30109c1f7b::game_status::add_buyer(arg3, v0);
            let v13 = RedEnvelope<T0>{
                id     : 0x2::object::new(arg13),
                sender : arg12,
            };
            let v14 = Mint<T0>{
                id       : 0x2::object::id<RedEnvelope<T0>>(&v13),
                buyer    : v0,
                sender   : arg12,
                referrer : v5,
                cost     : v1,
            };
            0x2::event::emit<Mint<T0>>(v14);
            0x1::vector::push_back<RedEnvelope<T0>>(&mut v11, v13);
            v12 = v12 + 1;
        };
        let v15 = Buy{
            coin_type : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            buyer     : v0,
            sender    : arg12,
            referrer  : v5,
            count     : arg10,
            payment   : v2,
        };
        0x2::event::emit<Buy>(v15);
        v11
    }

    fun init(arg0: RED_ENVELOPE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"BuckYou Red Envelope (SUI)"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Get a Red Envelope in the Year of the Dragon for a ticket to good fortune and prosperity. Buy and open your Envelopes at https://cny.buckyou.io/ to share in the prosperity!"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://ipfs.io/ipfs/Qmeyz3FijdgyR9AMqg84nzpQR4sXbZd1M4UBhQ9Dz99sYE"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://cny.buckyou.io/"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"BuckYou"));
        let v4 = 0x2::tx_context::sender(arg1);
        let v5 = 0x2::package::claim<RED_ENVELOPE>(arg0, arg1);
        let v6 = 0x2::display::new_with_fields<RedEnvelope<0x2::sui::SUI>>(&v5, v0, v2, arg1);
        0x2::display::update_version<RedEnvelope<0x2::sui::SUI>>(&mut v6);
        0x2::transfer::public_transfer<0x2::display::Display<RedEnvelope<0x2::sui::SUI>>>(v6, v4);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v5, v4);
    }

    public fun open<T0>(arg0: &0x2::clock::Clock, arg1: &mut 0xd441d82fa791d7e7fc89eb2a40b0714bd9a6a1aaf0c897d702802d30109c1f7b::game_status::GameStatus, arg2: &mut 0xd441d82fa791d7e7fc89eb2a40b0714bd9a6a1aaf0c897d702802d30109c1f7b::referral_manager::ReferralManager, arg3: &mut 0xd441d82fa791d7e7fc89eb2a40b0714bd9a6a1aaf0c897d702802d30109c1f7b::lootbox::LootboxPool, arg4: &mut 0xd441d82fa791d7e7fc89eb2a40b0714bd9a6a1aaf0c897d702802d30109c1f7b::leaderboard::Leaderboard, arg5: RedEnvelope<T0>, arg6: &mut 0x2::tx_context::TxContext) {
        0xd441d82fa791d7e7fc89eb2a40b0714bd9a6a1aaf0c897d702802d30109c1f7b::game_status::assert_game_is_started(arg1, arg0);
        0xd441d82fa791d7e7fc89eb2a40b0714bd9a6a1aaf0c897d702802d30109c1f7b::game_status::assert_game_is_not_ended(arg1, arg0);
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = 0xd441d82fa791d7e7fc89eb2a40b0714bd9a6a1aaf0c897d702802d30109c1f7b::referral_manager::try_get_referrer(arg2, v0);
        if (0x1::option::is_none<address>(&v1)) {
            0xd441d82fa791d7e7fc89eb2a40b0714bd9a6a1aaf0c897d702802d30109c1f7b::referral_manager::set_referrer<T0>(arg2, v0, arg5.sender, true);
        };
        0xd441d82fa791d7e7fc89eb2a40b0714bd9a6a1aaf0c897d702802d30109c1f7b::leaderboard::add_score<T0>(arg4, v0);
        0xd441d82fa791d7e7fc89eb2a40b0714bd9a6a1aaf0c897d702802d30109c1f7b::game_status::increase_end_time(arg1, arg0);
        0xd441d82fa791d7e7fc89eb2a40b0714bd9a6a1aaf0c897d702802d30109c1f7b::game_status::add_opener(arg1, v0);
        let v2 = 0x1::bcs::to_bytes<RedEnvelope<T0>>(&arg5);
        let RedEnvelope {
            id     : v3,
            sender : v4,
        } = arg5;
        let v5 = v3;
        0x1::vector::append<u8>(&mut v2, 0x2::object::uid_to_bytes(&v5));
        0x2::object::delete(v5);
        0xd441d82fa791d7e7fc89eb2a40b0714bd9a6a1aaf0c897d702802d30109c1f7b::lootbox::add_ticket<T0>(arg3, v2, v0);
        let v6 = Open<T0>{
            opener : v0,
            sender : v4,
            seed   : v2,
        };
        0x2::event::emit<Open<T0>>(v6);
    }

    public fun redeem<T0>(arg0: 0x1::option::Option<0xd441d82fa791d7e7fc89eb2a40b0714bd9a6a1aaf0c897d702802d30109c1f7b::lootbox::RedEnvelopeVoucher<T0>>, arg1: &mut 0x2::tx_context::TxContext) {
        if (0x1::option::is_some<0xd441d82fa791d7e7fc89eb2a40b0714bd9a6a1aaf0c897d702802d30109c1f7b::lootbox::RedEnvelopeVoucher<T0>>(&arg0)) {
            let v0 = 0xd441d82fa791d7e7fc89eb2a40b0714bd9a6a1aaf0c897d702802d30109c1f7b::lootbox::destroy_voucher<T0>(0x1::option::destroy_some<0xd441d82fa791d7e7fc89eb2a40b0714bd9a6a1aaf0c897d702802d30109c1f7b::lootbox::RedEnvelopeVoucher<T0>>(arg0));
            let v1 = RedEnvelope<T0>{
                id     : 0x2::object::new(arg1),
                sender : v0,
            };
            0x2::transfer::transfer<RedEnvelope<T0>>(v1, v0);
        } else {
            0x1::option::destroy_none<0xd441d82fa791d7e7fc89eb2a40b0714bd9a6a1aaf0c897d702802d30109c1f7b::lootbox::RedEnvelopeVoucher<T0>>(arg0);
        };
    }

    // decompiled from Move bytecode v6
}

