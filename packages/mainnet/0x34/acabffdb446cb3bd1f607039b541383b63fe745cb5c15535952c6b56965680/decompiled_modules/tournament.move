module 0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::tournament {
    struct Tournament has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        status: 0x1::string::String,
        organizer: address,
        format: u64,
        start_before_ms: u64,
        sui_bps: vector<u64>,
        token_bps: vector<u64>,
        rewards: vector<Reward>,
        sui: 0x2::balance::Balance<0x2::sui::SUI>,
        sui_total: u64,
        kares_pool: 0x1::option::Option<0x2::object::ID>,
        teams: vector<Team>,
        matches: vector<0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::tournament_bracket::Match>,
        fights: vector<0x1::option::Option<0x2::object::ID>>,
    }

    struct Reward has copy, drop, store {
        place: u8,
        template: 0x2::object::ID,
        amount: u32,
    }

    struct Seat has copy, drop, store {
        character: 0x2::object::ID,
        owner: address,
        sui_claimed: bool,
        items_claimed: u64,
    }

    struct Team has copy, drop, store {
        name: 0x1::string::String,
        revision: u64,
        allowed: vector<0x2::object::ID>,
        seats: vector<Seat>,
        place: u8,
    }

    struct TournamentUpdated has copy, drop {
        tournament: 0x2::object::ID,
    }

    struct RulesKey has copy, drop, store {
        dummy_field: bool,
    }

    struct Rules has copy, drop, store {
        entry_fee_mist: u64,
        max_level: 0x1::option::Option<u16>,
    }

    struct KaresPool<phantom T0> has key {
        id: 0x2::object::UID,
        funds: 0x1fbcc2f95306b6db869466c8b2c1461d5102b158584cced9036ee758c4b8cfce::tournament_rewards::Funds<T0>,
    }

    public(friend) fun pay_entry(arg0: &mut Tournament, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = rules(arg0);
        0x1fbcc2f95306b6db869466c8b2c1461d5102b158584cced9036ee758c4b8cfce::tournament_rewards::pay_entry(&mut arg0.sui, arg1, v0.entry_fee_mist, @0x37cf46b499f740e653644bd2f7a8ed97f248e8b3c69d5d12c97d7845a54c0cd8, arg2);
    }

    public(friend) fun ready(arg0: &Tournament, arg1: u64, arg2: &mut 0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::fight::Fight, arg3: vector<u64>, arg4: &mut 0x2::random::RandomGenerator, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        running(arg0);
        assert_fight(arg0, arg1, arg2);
        assert!(0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::tournament_bracket::state(0x1::vector::borrow<0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::tournament_bracket::Match>(&arg0.matches, arg1)) == 1 && 0x2::clock::timestamp_ms(arg5) < 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::tournament_bracket::available_ms(0x1::vector::borrow<0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::tournament_bracket::Match>(&arg0.matches, arg1)) + 1800000, 3204);
        assert!(!0x1::vector::is_empty<u64>(&arg3) && 0x1::vector::length<u64>(&arg3) <= arg0.format, 3203);
        let v0 = false;
        let v1 = 0;
        while (v1 < 0x1::vector::length<u64>(&arg3)) {
            v0 = 0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::fight::ready(arg2, *0x1::vector::borrow<u64>(&arg3, v1), arg6);
            v1 = v1 + 1;
        };
        let v2 = if (v0) {
            if (0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::fight::side_players(arg2, 0) == arg0.format) {
                0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::fight::side_players(arg2, 1) == arg0.format
            } else {
                false
            }
        } else {
            false
        };
        if (v2) {
            0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::fight::start(arg2, arg4, arg5);
        };
    }

    public(friend) fun start(arg0: &mut Tournament, arg1: &mut 0x2::random::RandomGenerator, arg2: &0x2::clock::Clock) {
        assert!(arg0.status == 0x1::string::utf8(b"open"), 3202);
        assert!(0x2::clock::timestamp_ms(arg2) >= arg0.start_before_ms, 3205);
        let v0 = entrants(arg0);
        let v1 = 0x1::vector::length<u64>(&v0);
        assert!(v1 >= minimum_teams(arg0), 3201);
        let v2 = v1;
        while (v2 > 1) {
            let v3 = v2 - 1;
            v2 = v3;
            0x1::vector::swap<u64>(&mut v0, v3, 0x2::random::generate_u64_in_range(arg1, 0, v3));
        };
        arg0.matches = 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::tournament_bracket::new(v0, 0x2::clock::timestamp_ms(arg2));
        v2 = 0;
        while (v2 < 0x1::vector::length<0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::tournament_bracket::Match>(&arg0.matches)) {
            0x1::vector::push_back<0x1::option::Option<0x2::object::ID>>(&mut arg0.fights, 0x1::option::none<0x2::object::ID>());
            v2 = v2 + 1;
        };
        arg0.sui_total = 0x2::balance::value<0x2::sui::SUI>(&arg0.sui);
        arg0.status = 0x1::string::utf8(b"in_progress");
        changed(arg0);
    }

    public fun add_reward(arg0: vector<Reward>, arg1: &0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::item_rows::ItemTemplate, arg2: u8, arg3: u32) : vector<Reward> {
        0x1::vector::push_back<Reward>(&mut arg0, reward(arg1, arg2, arg3));
        arg0
    }

    public(friend) fun admission(arg0: &Tournament, arg1: u64, arg2: 0x2::object::ID, arg3: address, arg4: &0x2::clock::Clock) : (u8, u64) {
        running(arg0);
        let v0 = 0x1::vector::borrow<0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::tournament_bracket::Match>(&arg0.matches, arg1);
        assert!(0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::tournament_bracket::state(v0) == 1 && 0x2::clock::timestamp_ms(arg4) < 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::tournament_bracket::available_ms(v0) + 0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::fight::placement_duration_ms(), 3204);
        let v1 = 0;
        while (v1 < 2) {
            let v2 = 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::tournament_bracket::team(v0, v1);
            let v3 = 0;
            while (v3 < 0x1::vector::length<Seat>(&0x1::vector::borrow<Team>(&arg0.teams, v2).seats)) {
                let v4 = 0x1::vector::borrow<Seat>(&0x1::vector::borrow<Team>(&arg0.teams, v2).seats, v3);
                if (v4.character == arg2 && v4.owner == arg3) {
                    return (v1, 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::tournament_bracket::available_ms(v0))
                };
                v3 = v3 + 1;
            };
            v1 = v1 + 1;
        };
        abort 3203
    }

    public(friend) fun assert_fight(arg0: &Tournament, arg1: u64, arg2: &0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::fight::Fight) {
        assert!(*0x1::vector::borrow<0x1::option::Option<0x2::object::ID>>(&arg0.fights, arg1) == 0x1::option::some<0x2::object::ID>(0x2::object::id<0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::fight::Fight>(arg2)), 3204);
        0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::fight::assert_tournament_controlled(arg2);
    }

    public(friend) fun assert_free_registration(arg0: &Tournament) {
        let v0 = rules(arg0);
        assert!(v0.entry_fee_mist == 0, 3201);
    }

    fun assert_pool<T0>(arg0: &Tournament, arg1: &KaresPool<T0>) {
        assert!(arg0.kares_pool == 0x1::option::some<0x2::object::ID>(0x2::object::id<KaresPool<T0>>(arg1)), 3206);
    }

    public(friend) fun assert_recorded(arg0: &Tournament, arg1: u64, arg2: &0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::fight::Fight) {
        assert_fight(arg0, arg1, arg2);
        assert!(0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::tournament_bracket::state(0x1::vector::borrow<0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::tournament_bracket::Match>(&arg0.matches, arg1)) == 2, 3204);
    }

    public fun cancel(arg0: &mut Tournament, arg1: &0x42b5165ab47d760c38e0158328aba7c960d3f12d129cd2e960bea60e09d9d19b::admin::AdminCap, arg2: &0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::version::assert_latest(arg2);
        0x42b5165ab47d760c38e0158328aba7c960d3f12d129cd2e960bea60e09d9d19b::admin::verify(arg1, arg3);
        cancel_open(arg0, arg3);
    }

    fun cancel_open(arg0: &mut Tournament, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status == 0x1::string::utf8(b"open"), 3202);
        arg0.status = 0x1::string::utf8(b"cancelled");
        let v0 = &mut arg0.sui;
        pay(v0, 0x2::balance::value<0x2::sui::SUI>(&arg0.sui), arg0.organizer, arg1);
        changed(arg0);
    }

    fun changed(arg0: &Tournament) {
        let v0 = TournamentUpdated{tournament: 0x2::object::id<Tournament>(arg0)};
        0x2::event::emit<TournamentUpdated>(v0);
    }

    public(friend) fun claim_item(arg0: &mut Tournament, arg1: u64, arg2: u64, arg3: u64, arg4: 0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::item::PM, arg5: &mut 0x2::kiosk::Kiosk, arg6: &0x2::kiosk::KioskOwnerCap, arg7: &0x2::transfer_policy::TransferPolicy<0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::item::Item>, arg8: &mut 0x2::random::RandomGenerator, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status == 0x1::string::utf8(b"finished"), 3202);
        let v0 = *0x1::vector::borrow<Reward>(&arg0.rewards, arg3);
        let v1 = 0x1::vector::borrow_mut<Team>(&mut arg0.teams, arg1);
        assert!(v1.place == v0.place, 3206);
        let v2 = 0x1::vector::borrow_mut<Seat>(&mut v1.seats, arg2);
        assert!(v2.owner == 0x2::tx_context::sender(arg9) && v2.items_claimed & 1 << (arg3 as u8) == 0, 3206);
        v2.items_claimed = v2.items_claimed | 1 << (arg3 as u8);
        0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::item::deliver_claim(arg4, v0.template, v0.amount, arg5, arg6, arg7, arg8, arg9);
        changed(arg0);
    }

    public fun claim_kares<T0>(arg0: &Tournament, arg1: &mut KaresPool<T0>, arg2: u64, arg3: u64, arg4: &0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::version::Version, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status == 0x1::string::utf8(b"finished"), 3202);
        refund_kares<T0>(arg0, arg1, arg4, arg5);
        let v0 = 0x1::vector::borrow<Team>(&arg0.teams, arg2).place;
        assert!(v0 > 0, 3206);
        let (v1, v2) = placement_seats(arg0, v0, arg2);
        let v3 = 0x1::vector::borrow<Seat>(&0x1::vector::borrow<Team>(&arg0.teams, arg2).seats, arg3);
        0x1fbcc2f95306b6db869466c8b2c1461d5102b158584cced9036ee758c4b8cfce::tournament_rewards::claim<T0>(&mut arg1.funds, v3.character, v3.owner, 0x1fbcc2f95306b6db869466c8b2c1461d5102b158584cced9036ee758c4b8cfce::tournament_rewards::share(0x1fbcc2f95306b6db869466c8b2c1461d5102b158584cced9036ee758c4b8cfce::tournament_rewards::portion(0x1fbcc2f95306b6db869466c8b2c1461d5102b158584cced9036ee758c4b8cfce::tournament_rewards::total<T0>(&arg1.funds), *0x1::vector::borrow<u64>(&arg0.token_bps, ((v0 - 1) as u64))), v1, v2 + arg3), arg5);
        changed(arg0);
    }

    public fun claim_sui(arg0: &mut Tournament, arg1: u64, arg2: u64, arg3: &0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::version::Version, arg4: &mut 0x2::tx_context::TxContext) {
        0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::version::assert_latest(arg3);
        assert!(arg0.status == 0x1::string::utf8(b"finished"), 3202);
        let v0 = 0x1::vector::borrow<Team>(&arg0.teams, arg1).place;
        assert!(v0 > 0, 3206);
        let (v1, v2) = placement_seats(arg0, v0, arg1);
        let v3 = 0x1::vector::borrow_mut<Seat>(&mut 0x1::vector::borrow_mut<Team>(&mut arg0.teams, arg1).seats, arg2);
        assert!(!v3.sui_claimed, 3206);
        v3.sui_claimed = true;
        let v4 = v3.owner;
        let v5 = &mut arg0.sui;
        pay(v5, 0x1fbcc2f95306b6db869466c8b2c1461d5102b158584cced9036ee758c4b8cfce::tournament_rewards::share(0x1fbcc2f95306b6db869466c8b2c1461d5102b158584cced9036ee758c4b8cfce::tournament_rewards::portion(arg0.sui_total, *0x1::vector::borrow<u64>(&arg0.sui_bps, ((v0 - 1) as u64))), v1, v2 + arg2), v4, arg4);
        changed(arg0);
    }

    public(friend) fun crank(arg0: &mut Tournament, arg1: u64, arg2: &mut 0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::fight::Fight, arg3: &mut 0x2::random::RandomGenerator, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert_fight(arg0, arg1, arg2);
        if (0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::tournament_bracket::state(0x1::vector::borrow<0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::tournament_bracket::Match>(&arg0.matches, arg1)) == 2) {
            return
        };
        running(arg0);
        let v0 = 0x1::vector::borrow<0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::tournament_bracket::Match>(&arg0.matches, arg1);
        if (!0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::fight::ended(arg2)) {
            if (0x2::clock::timestamp_ms(arg4) >= 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::tournament_bracket::available_ms(v0) + 1800000) {
                0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::fight::end_tournament(arg2, 0x1::option::none<u8>());
            } else {
                assert!(0x2::clock::timestamp_ms(arg4) >= 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::tournament_bracket::available_ms(v0) + 0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::fight::placement_duration_ms(), 3205);
                let v1 = 0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::fight::side_players(arg2, 0);
                if (v1 > 0 && 0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::fight::side_players(arg2, 1) > 0) {
                    0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::fight::start(arg2, arg3, arg4);
                    return
                };
                let v2 = if (v1 > 0) {
                    0
                } else {
                    1
                };
                0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::fight::end_tournament(arg2, 0x1::option::some<u8>(v2));
            };
        };
        record(arg0, arg1, arg2, arg4, arg5);
    }

    public fun crank_unopened(arg0: &mut Tournament, arg1: u64, arg2: &0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::version::Version, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::version::assert_latest(arg2);
        running(arg0);
        let v0 = 0x1::vector::borrow<0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::tournament_bracket::Match>(&arg0.matches, arg1);
        assert!(0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::tournament_bracket::state(v0) == 1 && 0x1::option::is_none<0x2::object::ID>(0x1::vector::borrow<0x1::option::Option<0x2::object::ID>>(&arg0.fights, arg1)), 3204);
        assert!(0x2::clock::timestamp_ms(arg3) >= 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::tournament_bracket::available_ms(v0) + 0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::fight::placement_duration_ms(), 3205);
        resolve(arg0, arg1, 0x1::option::none<u8>(), false, arg3, arg4);
    }

    public fun create(arg0: &0x42b5165ab47d760c38e0158328aba7c960d3f12d129cd2e960bea60e09d9d19b::admin::AdminCap, arg1: 0x1::string::String, arg2: u64, arg3: u64, arg4: vector<u64>, arg5: vector<u64>, arg6: vector<Reward>, arg7: &0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::version::Version, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        create_with_rules(arg0, arg1, arg2, arg3, arg4, arg5, arg6, 0, 0x1::option::none<u16>(), arg7, arg8, arg9);
    }

    public fun create_kares_pool<T0>(arg0: &mut Tournament, arg1: &0x1fbcc2f95306b6db869466c8b2c1461d5102b158584cced9036ee758c4b8cfce::economy::Economy, arg2: 0x2::coin::Coin<T0>, arg3: &0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::version::Version, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::version::assert_latest(arg3);
        open(arg0, arg4);
        0x1fbcc2f95306b6db869466c8b2c1461d5102b158584cced9036ee758c4b8cfce::economy::assert_token<T0>(arg1);
        assert!(0x1::option::is_none<0x2::object::ID>(&arg0.kares_pool), 3201);
        let v0 = KaresPool<T0>{
            id    : 0x2::object::new(arg5),
            funds : 0x1fbcc2f95306b6db869466c8b2c1461d5102b158584cced9036ee758c4b8cfce::tournament_rewards::new<T0>(arg2),
        };
        arg0.kares_pool = 0x1::option::some<0x2::object::ID>(0x2::object::id<KaresPool<T0>>(&v0));
        0x2::transfer::share_object<KaresPool<T0>>(v0);
        changed(arg0);
    }

    public(friend) fun create_team(arg0: &mut Tournament, arg1: 0x1::string::String, arg2: vector<0x2::object::ID>, arg3: &0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::character::Character, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        open(arg0, arg4);
        let v0 = if (0x1::string::length(&arg1) > 0) {
            if (0x1::string::length(&arg1) <= 40) {
                0x1::vector::length<0x2::object::ID>(&arg2) <= arg0.format
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 3201);
        let v1 = 0;
        while (v1 < 0x1::vector::length<Team>(&arg0.teams) && !0x1::vector::is_empty<Seat>(&0x1::vector::borrow<Team>(&arg0.teams, v1).seats)) {
            v1 = v1 + 1;
        };
        let v2 = if (v1 < 0x1::vector::length<Team>(&arg0.teams)) {
            0x1::vector::borrow<Team>(&arg0.teams, v1).revision + 1
        } else {
            0
        };
        let v3 = Team{
            name     : arg1,
            revision : v2,
            allowed  : arg2,
            seats    : 0x1::vector::empty<Seat>(),
            place    : 0,
        };
        if (v1 < 0x1::vector::length<Team>(&arg0.teams)) {
            *0x1::vector::borrow_mut<Team>(&mut arg0.teams, v1) = v3;
        } else {
            assert!(v1 < 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::tournament_bracket::max_teams(), 3201);
            0x1::vector::push_back<Team>(&mut arg0.teams, v3);
        };
        join_team(arg0, v1, v2, arg3, arg4, arg5);
    }

    public fun create_with_rules(arg0: &0x42b5165ab47d760c38e0158328aba7c960d3f12d129cd2e960bea60e09d9d19b::admin::AdminCap, arg1: 0x1::string::String, arg2: u64, arg3: u64, arg4: vector<u64>, arg5: vector<u64>, arg6: vector<Reward>, arg7: u64, arg8: 0x1::option::Option<u16>, arg9: &0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::version::Version, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::version::assert_latest(arg9);
        0x42b5165ab47d760c38e0158328aba7c960d3f12d129cd2e960bea60e09d9d19b::admin::verify(arg0, arg11);
        assert!(0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::tournament_bracket::valid_settings(arg2, 0x1::string::length(&arg1), 0x1::vector::length<Reward>(&arg6), arg3, 0x2::clock::timestamp_ms(arg10), &arg8), 3201);
        0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::tournament_bracket::validate_bps(&arg4);
        0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::tournament_bracket::validate_bps(&arg5);
        let v0 = Tournament{
            id              : 0x2::object::new(arg11),
            name            : arg1,
            status          : 0x1::string::utf8(b"open"),
            organizer       : 0x2::tx_context::sender(arg11),
            format          : arg2,
            start_before_ms : arg3,
            sui_bps         : arg4,
            token_bps       : arg5,
            rewards         : arg6,
            sui             : 0x2::balance::zero<0x2::sui::SUI>(),
            sui_total       : 0,
            kares_pool      : 0x1::option::none<0x2::object::ID>(),
            teams           : 0x1::vector::empty<Team>(),
            matches         : 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::tournament_bracket::empty(),
            fights          : 0x1::vector::empty<0x1::option::Option<0x2::object::ID>>(),
        };
        let v1 = RulesKey{dummy_field: false};
        let v2 = Rules{
            entry_fee_mist : arg7,
            max_level      : arg8,
        };
        0x2::dynamic_field::add<RulesKey, Rules>(&mut v0.id, v1, v2);
        changed(&v0);
        0x2::transfer::share_object<Tournament>(v0);
    }

    public fun donate_kares<T0>(arg0: &Tournament, arg1: &mut KaresPool<T0>, arg2: 0x2::coin::Coin<T0>, arg3: &0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::version::Version, arg4: &0x2::clock::Clock) {
        0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::version::assert_latest(arg3);
        open(arg0, arg4);
        assert_pool<T0>(arg0, arg1);
        0x1fbcc2f95306b6db869466c8b2c1461d5102b158584cced9036ee758c4b8cfce::tournament_rewards::deposit<T0>(&mut arg1.funds, arg2);
        changed(arg0);
    }

    public fun donate_sui(arg0: &mut Tournament, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::version::Version, arg3: &0x2::clock::Clock) {
        0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::version::assert_latest(arg2);
        open(arg0, arg3);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        changed(arg0);
    }

    fun entrants(arg0: &Tournament) : vector<u64> {
        let v0 = vector[];
        let v1 = 0;
        while (v1 < 0x1::vector::length<Team>(&arg0.teams)) {
            if (0x1::vector::length<Seat>(&0x1::vector::borrow<Team>(&arg0.teams, v1).seats) == arg0.format) {
                0x1::vector::push_back<u64>(&mut v0, v1);
            };
            v1 = v1 + 1;
        };
        v0
    }

    public fun expire(arg0: &mut Tournament, arg1: &0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::version::Version, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::version::assert_latest(arg1);
        assert!(0x2::clock::timestamp_ms(arg2) >= arg0.start_before_ms, 3205);
        let v0 = entrants(arg0);
        assert!(0x1::vector::length<u64>(&v0) < minimum_teams(arg0), 3201);
        cancel_open(arg0, arg3);
    }

    fun finish(arg0: &mut Tournament, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<Team>(&arg0.teams)) {
            0x1::vector::borrow_mut<Team>(&mut arg0.teams, v0).place = 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::tournament_bracket::placement(&arg0.matches, v0);
            v0 = v0 + 1;
        };
        arg0.status = 0x1::string::utf8(b"finished");
        let v1 = &mut arg0.sui;
        pay(v1, unawarded(arg0, &arg0.sui_bps, arg0.sui_total), arg0.organizer, arg1);
    }

    public(friend) fun join_team(arg0: &mut Tournament, arg1: u64, arg2: u64, arg3: &0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::character::Character, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        open(arg0, arg4);
        let v0 = rules(arg0);
        let v1 = v0.max_level;
        assert!(0x1::option::is_none<u16>(&v1) || 0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::character::level(arg3) <= *0x1::option::borrow<u16>(&v1), 3201);
        let v2 = 0x2::object::id<0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::character::Character>(arg3);
        let v3 = 0x2::tx_context::sender(arg5);
        let v4 = 0;
        while (v4 < 0x1::vector::length<Team>(&arg0.teams)) {
            let v5 = 0;
            while (v5 < 0x1::vector::length<Seat>(&0x1::vector::borrow<Team>(&arg0.teams, v4).seats)) {
                let v6 = 0x1::vector::borrow<Seat>(&0x1::vector::borrow<Team>(&arg0.teams, v4).seats, v5);
                assert!(v6.character != v2 && (v4 == arg1 || v6.owner != v3), 3203);
                v5 = v5 + 1;
            };
            v4 = v4 + 1;
        };
        let v7 = 0x1::vector::borrow_mut<Team>(&mut arg0.teams, arg1);
        assert!(v7.revision == arg2 && 0x1::vector::length<Seat>(&v7.seats) < arg0.format, 3203);
        assert!(0x1::vector::is_empty<0x2::object::ID>(&v7.allowed) || 0x1::vector::contains<0x2::object::ID>(&v7.allowed, &v2), 3203);
        let v8 = Seat{
            character     : v2,
            owner         : v3,
            sui_claimed   : false,
            items_claimed : 0,
        };
        0x1::vector::push_back<Seat>(&mut v7.seats, v8);
        changed(arg0);
    }

    public fun leave_team(arg0: &mut Tournament, arg1: u64, arg2: 0x2::object::ID, arg3: &0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::version::Version, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::version::assert_latest(arg3);
        open(arg0, arg4);
        let v0 = &mut 0x1::vector::borrow_mut<Team>(&mut arg0.teams, arg1).seats;
        let v1 = 0;
        while (v1 < 0x1::vector::length<Seat>(v0) && 0x1::vector::borrow<Seat>(v0, v1).character != arg2) {
            v1 = v1 + 1;
        };
        assert!(0x1::vector::borrow<Seat>(v0, v1).owner == 0x2::tx_context::sender(arg5), 3203);
        0x1::vector::remove<Seat>(v0, v1);
        changed(arg0);
    }

    public(friend) fun link_fight(arg0: &mut Tournament, arg1: u64, arg2: 0x2::object::ID) {
        assert!(0x1::option::is_none<0x2::object::ID>(0x1::vector::borrow<0x1::option::Option<0x2::object::ID>>(&arg0.fights, arg1)), 3204);
        *0x1::vector::borrow_mut<0x1::option::Option<0x2::object::ID>>(&mut arg0.fights, arg1) = 0x1::option::some<0x2::object::ID>(arg2);
        changed(arg0);
    }

    fun minimum_teams(arg0: &Tournament) : u64 {
        let v0 = &arg0.rewards;
        let v1 = b"";
        let v2 = 0;
        while (v2 < 0x1::vector::length<Reward>(v0)) {
            0x1::vector::push_back<u8>(&mut v1, 0x1::vector::borrow<Reward>(v0, v2).place);
            v2 = v2 + 1;
        };
        0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::tournament_bracket::minimum_teams(&arg0.sui_bps, &arg0.token_bps, v1)
    }

    fun open(arg0: &Tournament, arg1: &0x2::clock::Clock) {
        assert!(arg0.status == 0x1::string::utf8(b"open") && 0x2::clock::timestamp_ms(arg1) < arg0.start_before_ms, 3202);
    }

    fun pay(arg0: &mut 0x2::balance::Balance<0x2::sui::SUI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        if (arg1 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(arg0, arg1), arg3), arg2);
        };
    }

    fun placement_seats(arg0: &Tournament, arg1: u8, arg2: u64) : (u64, u64) {
        let v0 = 0;
        let v1 = 0;
        let v2 = 0;
        while (v2 < 0x1::vector::length<Team>(&arg0.teams)) {
            if (0x1::vector::borrow<Team>(&arg0.teams, v2).place == arg1) {
                let v3 = v1 + 0x1::vector::length<Seat>(&0x1::vector::borrow<Team>(&arg0.teams, v2).seats);
                v1 = v3;
                if (v2 < arg2) {
                    v0 = v3;
                };
            };
            v2 = v2 + 1;
        };
        (v1, v0)
    }

    public(friend) fun record(arg0: &mut Tournament, arg1: u64, arg2: &0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::fight::Fight, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert_fight(arg0, arg1, arg2);
        if (0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::tournament_bracket::state(0x1::vector::borrow<0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::tournament_bracket::Match>(&arg0.matches, arg1)) == 2) {
            return
        };
        running(arg0);
        assert!(0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::fight::ended(arg2), 3204);
        let (v0, v1) = 0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::fight::tournament_result(arg2);
        resolve(arg0, arg1, v0, v1, arg3, arg4);
    }

    public fun refund_kares<T0>(arg0: &Tournament, arg1: &mut KaresPool<T0>, arg2: &0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::version::assert_latest(arg2);
        assert_pool<T0>(arg0, arg1);
        assert!(arg0.status == 0x1::string::utf8(b"cancelled") || arg0.status == 0x1::string::utf8(b"finished"), 3202);
        let v0 = if (arg0.status == 0x1::string::utf8(b"cancelled")) {
            0x1fbcc2f95306b6db869466c8b2c1461d5102b158584cced9036ee758c4b8cfce::tournament_rewards::total<T0>(&arg1.funds)
        } else {
            unawarded(arg0, &arg0.token_bps, 0x1fbcc2f95306b6db869466c8b2c1461d5102b158584cced9036ee758c4b8cfce::tournament_rewards::total<T0>(&arg1.funds))
        };
        0x1fbcc2f95306b6db869466c8b2c1461d5102b158584cced9036ee758c4b8cfce::tournament_rewards::refund<T0>(&mut arg1.funds, v0, arg0.organizer, arg3);
        changed(arg0);
    }

    fun resolve(arg0: &mut Tournament, arg1: u64, arg2: 0x1::option::Option<u8>, arg3: bool, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::tournament_bracket::resolve(&mut arg0.matches, arg1, arg2, arg3, 0x2::clock::timestamp_ms(arg4));
        if (0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::tournament_bracket::done(&arg0.matches)) {
            finish(arg0, arg5);
        };
        changed(arg0);
    }

    public(friend) fun reward(arg0: &0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::item_rows::ItemTemplate, arg1: u8, arg2: u32) : Reward {
        let v0 = if (arg1 >= 1) {
            if (arg1 <= 5) {
                if (arg2 > 0) {
                    arg2 <= 10
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 3201);
        let v1 = if (arg2 == 1) {
            true
        } else {
            let v2 = 0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::item_rows::template_category(arg0);
            0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::content_rules::is_stackable(&v2)
        };
        assert!(v1, 3201);
        Reward{
            place    : arg1,
            template : 0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::item_rows::template_id(arg0),
            amount   : arg2,
        }
    }

    public fun rewards() : vector<Reward> {
        0x1::vector::empty<Reward>()
    }

    fun rules(arg0: &Tournament) : Rules {
        let v0 = RulesKey{dummy_field: false};
        if (0x2::dynamic_field::exists<RulesKey>(&arg0.id, v0)) {
            let v2 = RulesKey{dummy_field: false};
            *0x2::dynamic_field::borrow<RulesKey, Rules>(&arg0.id, v2)
        } else {
            Rules{entry_fee_mist: 0, max_level: 0x1::option::none<u16>()}
        }
    }

    fun running(arg0: &Tournament) {
        assert!(arg0.status == 0x1::string::utf8(b"in_progress"), 3202);
    }

    fun unawarded(arg0: &Tournament, arg1: &vector<u64>, arg2: u64) : u64 {
        let v0 = 0;
        let v1 = 1;
        while (v1 <= 5) {
            let (v2, _) = placement_seats(arg0, v1, 0);
            if (v2 > 0) {
                v0 = v0 + 0x1fbcc2f95306b6db869466c8b2c1461d5102b158584cced9036ee758c4b8cfce::tournament_rewards::portion(arg2, *0x1::vector::borrow<u64>(arg1, ((v1 - 1) as u64)));
            };
            v1 = v1 + 1;
        };
        arg2 - v0
    }

    // decompiled from Move bytecode v7
}

