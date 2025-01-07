module 0xe3a4c2ed36345bfc2207987708660ac9eb434752b0e6a6a4858897ecb50ad792::fetcher {
    struct Reward has copy, drop {
        winner: u64,
        winner_addr: address,
        reward_amount: u64,
    }

    struct RewardList has copy, drop {
        rewards: vector<Reward>,
    }

    struct Ticket has copy, drop {
        number: u64,
        asset_ids: vector<0x2::object::ID>,
        claimed: bool,
        type: u8,
    }

    struct TicketList has copy, drop {
        tickets: vector<Ticket>,
    }

    public entry fun fetch_reward_list<T0: drop, T1: store + key, T2>(arg0: &mut 0xe3a4c2ed36345bfc2207987708660ac9eb434752b0e6a6a4858897ecb50ad792::state::State, arg1: 0x2::object::ID) {
        let v0 = 0x1::vector::empty<Reward>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<0xe3a4c2ed36345bfc2207987708660ac9eb434752b0e6a6a4858897ecb50ad792::reward::Reward<T2>>(0xe3a4c2ed36345bfc2207987708660ac9eb434752b0e6a6a4858897ecb50ad792::campaign::borrow_rewards<T0, T1, T2>(0xe3a4c2ed36345bfc2207987708660ac9eb434752b0e6a6a4858897ecb50ad792::state::borrow_campaign<T0, T1, T2>(arg0, arg1)))) {
            let v2 = 0x1::vector::borrow<0xe3a4c2ed36345bfc2207987708660ac9eb434752b0e6a6a4858897ecb50ad792::reward::Reward<T2>>(0xe3a4c2ed36345bfc2207987708660ac9eb434752b0e6a6a4858897ecb50ad792::campaign::borrow_rewards<T0, T1, T2>(0xe3a4c2ed36345bfc2207987708660ac9eb434752b0e6a6a4858897ecb50ad792::state::borrow_campaign<T0, T1, T2>(arg0, arg1)), v1);
            let v3 = @0x0;
            if (0xe3a4c2ed36345bfc2207987708660ac9eb434752b0e6a6a4858897ecb50ad792::reward::winner<T2>(v2) != 0) {
                v3 = *0x2::table::borrow<u64, address>(0xe3a4c2ed36345bfc2207987708660ac9eb434752b0e6a6a4858897ecb50ad792::campaign::borrow_owners<T0, T1, T2>(0xe3a4c2ed36345bfc2207987708660ac9eb434752b0e6a6a4858897ecb50ad792::state::borrow_campaign<T0, T1, T2>(arg0, arg1)), 0xe3a4c2ed36345bfc2207987708660ac9eb434752b0e6a6a4858897ecb50ad792::reward::winner<T2>(v2));
            };
            let v4 = Reward{
                winner        : 0xe3a4c2ed36345bfc2207987708660ac9eb434752b0e6a6a4858897ecb50ad792::reward::winner<T2>(v2),
                winner_addr   : v3,
                reward_amount : 0xe3a4c2ed36345bfc2207987708660ac9eb434752b0e6a6a4858897ecb50ad792::reward::reward_amount<T2>(v2),
            };
            0x1::vector::push_back<Reward>(&mut v0, v4);
            v1 = v1 + 1;
        };
        let v5 = RewardList{rewards: v0};
        0x2::event::emit<RewardList>(v5);
    }

    public entry fun fetch_ticket_list<T0: drop, T1: store + key, T2>(arg0: &mut 0xe3a4c2ed36345bfc2207987708660ac9eb434752b0e6a6a4858897ecb50ad792::state::State, arg1: 0x2::object::ID, arg2: address) {
        let v0 = 0x1::vector::empty<Ticket>();
        if (0x2::table::contains<address, vector<u64>>(0xe3a4c2ed36345bfc2207987708660ac9eb434752b0e6a6a4858897ecb50ad792::campaign::borrow_owned_tickets<T0, T1, T2>(0xe3a4c2ed36345bfc2207987708660ac9eb434752b0e6a6a4858897ecb50ad792::state::borrow_campaign<T0, T1, T2>(arg0, arg1)), arg2)) {
            let v1 = 0;
            while (v1 < 0x1::vector::length<u64>(0x2::table::borrow<address, vector<u64>>(0xe3a4c2ed36345bfc2207987708660ac9eb434752b0e6a6a4858897ecb50ad792::campaign::borrow_owned_tickets<T0, T1, T2>(0xe3a4c2ed36345bfc2207987708660ac9eb434752b0e6a6a4858897ecb50ad792::state::borrow_campaign<T0, T1, T2>(arg0, arg1)), arg2))) {
                let v2 = 0x2::table::borrow<u64, 0xe3a4c2ed36345bfc2207987708660ac9eb434752b0e6a6a4858897ecb50ad792::ticket::Ticket>(0xe3a4c2ed36345bfc2207987708660ac9eb434752b0e6a6a4858897ecb50ad792::campaign::borrow_tickets<T0, T1, T2>(0xe3a4c2ed36345bfc2207987708660ac9eb434752b0e6a6a4858897ecb50ad792::state::borrow_campaign<T0, T1, T2>(arg0, arg1)), *0x1::vector::borrow<u64>(0x2::table::borrow<address, vector<u64>>(0xe3a4c2ed36345bfc2207987708660ac9eb434752b0e6a6a4858897ecb50ad792::campaign::borrow_owned_tickets<T0, T1, T2>(0xe3a4c2ed36345bfc2207987708660ac9eb434752b0e6a6a4858897ecb50ad792::state::borrow_campaign<T0, T1, T2>(arg0, arg1)), arg2), v1));
                let v3 = Ticket{
                    number    : 0xe3a4c2ed36345bfc2207987708660ac9eb434752b0e6a6a4858897ecb50ad792::ticket::number(v2),
                    asset_ids : *0xe3a4c2ed36345bfc2207987708660ac9eb434752b0e6a6a4858897ecb50ad792::ticket::asset_ids(v2),
                    claimed   : 0xe3a4c2ed36345bfc2207987708660ac9eb434752b0e6a6a4858897ecb50ad792::ticket::is_claimed(v2),
                    type      : 0xe3a4c2ed36345bfc2207987708660ac9eb434752b0e6a6a4858897ecb50ad792::ticket::type(v2),
                };
                0x1::vector::push_back<Ticket>(&mut v0, v3);
                v1 = v1 + 1;
            };
        };
        let v4 = TicketList{tickets: v0};
        0x2::event::emit<TicketList>(v4);
    }

    // decompiled from Move bytecode v6
}

