module 0xe5beebecbc63dd0552da2af0e6c773a6f1873ec25954d6db6320e853786e713e::campaign {
    struct Campaign<phantom T0, phantom T1, phantom T2> has store, key {
        id: 0x2::object::UID,
        metadata: 0x1::string::String,
        created_at_ms: u64,
        ended_at_ms: u64,
        offered_coin_amount: u64,
        total_token_reward: u64,
        rewards: vector<0xe5beebecbc63dd0552da2af0e6c773a6f1873ec25954d6db6320e853786e713e::reward::Reward<T2>>,
        coin_custodian: 0xe5beebecbc63dd0552da2af0e6c773a6f1873ec25954d6db6320e853786e713e::custodian::Custodian<0x2::coin::Coin<T0>>,
        nft_asset_custodian: 0xe5beebecbc63dd0552da2af0e6c773a6f1873ec25954d6db6320e853786e713e::custodian::Custodian<T1>,
        ob_kiosks: 0x2::table::Table<address, 0x2::kiosk::Kiosk>,
        sponsor: address,
        tickets: 0x2::table::Table<u64, 0xe5beebecbc63dd0552da2af0e6c773a6f1873ec25954d6db6320e853786e713e::ticket::Ticket>,
        owners: 0x2::table::Table<u64, address>,
        owned_tickets: 0x2::table::Table<address, vector<u64>>,
        ticket_number_counter: u64,
        distributed: bool,
    }

    public(friend) fun new<T0: drop, T1: store + key, T2: drop>(arg0: 0x1::string::String, arg1: u64, arg2: u64, arg3: 0x2::balance::Balance<T2>, arg4: vector<u64>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : Campaign<T0, T1, T2> {
        let v0 = 0x1::vector::empty<0xe5beebecbc63dd0552da2af0e6c773a6f1873ec25954d6db6320e853786e713e::reward::Reward<T2>>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<u64>(&arg4)) {
            0x1::vector::push_back<0xe5beebecbc63dd0552da2af0e6c773a6f1873ec25954d6db6320e853786e713e::reward::Reward<T2>>(&mut v0, 0xe5beebecbc63dd0552da2af0e6c773a6f1873ec25954d6db6320e853786e713e::reward::new<T2>(0x2::balance::split<T2>(&mut arg3, *0x1::vector::borrow<u64>(&arg4, v1))));
            v1 = v1 + 1;
        };
        0x2::balance::destroy_zero<T2>(arg3);
        Campaign<T0, T1, T2>{
            id                    : 0x2::object::new(arg6),
            metadata              : arg0,
            created_at_ms         : 0x2::clock::timestamp_ms(arg5),
            ended_at_ms           : arg1,
            offered_coin_amount   : arg2,
            total_token_reward    : 0x2::balance::value<T2>(&arg3),
            rewards               : v0,
            coin_custodian        : 0xe5beebecbc63dd0552da2af0e6c773a6f1873ec25954d6db6320e853786e713e::custodian::new<0x2::coin::Coin<T0>>(arg6),
            nft_asset_custodian   : 0xe5beebecbc63dd0552da2af0e6c773a6f1873ec25954d6db6320e853786e713e::custodian::new<T1>(arg6),
            ob_kiosks             : 0x2::table::new<address, 0x2::kiosk::Kiosk>(arg6),
            sponsor               : 0x2::tx_context::sender(arg6),
            tickets               : 0x2::table::new<u64, 0xe5beebecbc63dd0552da2af0e6c773a6f1873ec25954d6db6320e853786e713e::ticket::Ticket>(arg6),
            owners                : 0x2::table::new<u64, address>(arg6),
            owned_tickets         : 0x2::table::new<address, vector<u64>>(arg6),
            ticket_number_counter : 1,
            distributed           : false,
        }
    }

    public(friend) fun borrow_mut_coin_custodian<T0, T1, T2>(arg0: &mut Campaign<T0, T1, T2>) : &mut 0xe5beebecbc63dd0552da2af0e6c773a6f1873ec25954d6db6320e853786e713e::custodian::Custodian<0x2::coin::Coin<T0>> {
        &mut arg0.coin_custodian
    }

    public(friend) fun borrow_mut_nft_asset_custodian<T0, T1, T2>(arg0: &mut Campaign<T0, T1, T2>) : &mut 0xe5beebecbc63dd0552da2af0e6c773a6f1873ec25954d6db6320e853786e713e::custodian::Custodian<T1> {
        &mut arg0.nft_asset_custodian
    }

    public(friend) fun borrow_mut_ob_kiosks<T0, T1, T2>(arg0: &mut Campaign<T0, T1, T2>) : &mut 0x2::table::Table<address, 0x2::kiosk::Kiosk> {
        &mut arg0.ob_kiosks
    }

    public(friend) fun borrow_mut_owned_tickets<T0, T1, T2>(arg0: &mut Campaign<T0, T1, T2>) : &mut 0x2::table::Table<address, vector<u64>> {
        &mut arg0.owned_tickets
    }

    public(friend) fun borrow_mut_owners<T0, T1, T2>(arg0: &mut Campaign<T0, T1, T2>) : &mut 0x2::table::Table<u64, address> {
        &mut arg0.owners
    }

    public(friend) fun borrow_mut_rewards<T0, T1, T2>(arg0: &mut Campaign<T0, T1, T2>) : &mut vector<0xe5beebecbc63dd0552da2af0e6c773a6f1873ec25954d6db6320e853786e713e::reward::Reward<T2>> {
        &mut arg0.rewards
    }

    public(friend) fun borrow_mut_tickets<T0, T1, T2>(arg0: &mut Campaign<T0, T1, T2>) : &mut 0x2::table::Table<u64, 0xe5beebecbc63dd0552da2af0e6c773a6f1873ec25954d6db6320e853786e713e::ticket::Ticket> {
        &mut arg0.tickets
    }

    public fun borrow_nft_asset_custodian<T0, T1, T2>(arg0: &mut Campaign<T0, T1, T2>) : &0xe5beebecbc63dd0552da2af0e6c773a6f1873ec25954d6db6320e853786e713e::custodian::Custodian<T1> {
        &arg0.nft_asset_custodian
    }

    public fun borrow_ob_kiosks<T0, T1, T2>(arg0: &Campaign<T0, T1, T2>) : &0x2::table::Table<address, 0x2::kiosk::Kiosk> {
        &arg0.ob_kiosks
    }

    public fun borrow_owned_tickets<T0, T1, T2>(arg0: &Campaign<T0, T1, T2>) : &0x2::table::Table<address, vector<u64>> {
        &arg0.owned_tickets
    }

    public fun borrow_owners<T0, T1, T2>(arg0: &Campaign<T0, T1, T2>) : &0x2::table::Table<u64, address> {
        &arg0.owners
    }

    public fun borrow_rewards<T0, T1, T2>(arg0: &Campaign<T0, T1, T2>) : &vector<0xe5beebecbc63dd0552da2af0e6c773a6f1873ec25954d6db6320e853786e713e::reward::Reward<T2>> {
        &arg0.rewards
    }

    public fun borrow_tickets<T0, T1, T2>(arg0: &Campaign<T0, T1, T2>) : &0x2::table::Table<u64, 0xe5beebecbc63dd0552da2af0e6c773a6f1873ec25954d6db6320e853786e713e::ticket::Ticket> {
        &arg0.tickets
    }

    public fun current_ticket_id<T0, T1, T2>(arg0: &Campaign<T0, T1, T2>) : u64 {
        arg0.ticket_number_counter
    }

    public fun ended_at<T0, T1, T2>(arg0: &Campaign<T0, T1, T2>) : u64 {
        arg0.ended_at_ms
    }

    public(friend) fun increase_ticket_counter<T0, T1, T2>(arg0: &mut Campaign<T0, T1, T2>) {
        arg0.ticket_number_counter = arg0.ticket_number_counter + 1;
    }

    public fun is_distributed<T0, T1, T2>(arg0: &Campaign<T0, T1, T2>) : bool {
        arg0.distributed
    }

    public fun is_ended<T0, T1, T2>(arg0: &Campaign<T0, T1, T2>, arg1: &0x2::clock::Clock) : bool {
        0x2::clock::timestamp_ms(arg1) >= arg0.ended_at_ms
    }

    public fun metadata<T0, T1, T2>(arg0: &Campaign<T0, T1, T2>) : 0x1::string::String {
        arg0.metadata
    }

    public fun offered_coin_amount<T0, T1, T2>(arg0: &Campaign<T0, T1, T2>) : u64 {
        arg0.offered_coin_amount
    }

    public(friend) fun set_distributed<T0, T1, T2>(arg0: &mut Campaign<T0, T1, T2>) {
        arg0.distributed = true;
    }

    public(friend) fun set_ended_at<T0, T1, T2>(arg0: &mut Campaign<T0, T1, T2>, arg1: u64) {
        arg0.ended_at_ms = arg1;
    }

    public(friend) fun set_metadata<T0, T1, T2>(arg0: &mut Campaign<T0, T1, T2>, arg1: 0x1::string::String) {
        arg0.metadata = arg1;
    }

    public(friend) fun take_coin_assets<T0: drop, T1: store + key, T2>(arg0: &mut Campaign<T0, T1, T2>, arg1: u64) : vector<0x2::coin::Coin<T0>> {
        let v0 = 0x1::vector::empty<0x2::coin::Coin<T0>>();
        let v1 = 0x2::table::borrow_mut<u64, 0xe5beebecbc63dd0552da2af0e6c773a6f1873ec25954d6db6320e853786e713e::ticket::Ticket>(&mut arg0.tickets, arg1);
        while (!0x1::vector::is_empty<0x2::object::ID>(0xe5beebecbc63dd0552da2af0e6c773a6f1873ec25954d6db6320e853786e713e::ticket::asset_ids(v1))) {
            0x1::vector::push_back<0x2::coin::Coin<T0>>(&mut v0, 0xe5beebecbc63dd0552da2af0e6c773a6f1873ec25954d6db6320e853786e713e::custodian::take<0x2::coin::Coin<T0>>(&mut arg0.coin_custodian, 0x1::vector::pop_back<0x2::object::ID>(0xe5beebecbc63dd0552da2af0e6c773a6f1873ec25954d6db6320e853786e713e::ticket::borrow_mut_asset_ids(v1))));
        };
        v0
    }

    public(friend) fun take_nft_assets<T0: drop, T1: store + key, T2>(arg0: &mut Campaign<T0, T1, T2>, arg1: u64) : vector<T1> {
        let v0 = 0x1::vector::empty<T1>();
        let v1 = 0x2::table::borrow_mut<u64, 0xe5beebecbc63dd0552da2af0e6c773a6f1873ec25954d6db6320e853786e713e::ticket::Ticket>(&mut arg0.tickets, arg1);
        while (!0x1::vector::is_empty<0x2::object::ID>(0xe5beebecbc63dd0552da2af0e6c773a6f1873ec25954d6db6320e853786e713e::ticket::asset_ids(v1))) {
            0x1::vector::push_back<T1>(&mut v0, 0xe5beebecbc63dd0552da2af0e6c773a6f1873ec25954d6db6320e853786e713e::custodian::take<T1>(&mut arg0.nft_asset_custodian, 0x1::vector::pop_back<0x2::object::ID>(0xe5beebecbc63dd0552da2af0e6c773a6f1873ec25954d6db6320e853786e713e::ticket::borrow_mut_asset_ids(v1))));
        };
        v0
    }

    public(friend) fun take_nft_assets_v2<T0: drop, T1: store + key, T2>(arg0: &mut Campaign<T0, T1, T2>, arg1: &mut 0x2::kiosk::Kiosk, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::table::borrow_mut<u64, 0xe5beebecbc63dd0552da2af0e6c773a6f1873ec25954d6db6320e853786e713e::ticket::Ticket>(&mut arg0.tickets, arg2);
        while (!0x1::vector::is_empty<0x2::object::ID>(0xe5beebecbc63dd0552da2af0e6c773a6f1873ec25954d6db6320e853786e713e::ticket::asset_ids(v0))) {
            0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::transfer_between_owned<T1>(0x2::table::borrow_mut<address, 0x2::kiosk::Kiosk>(&mut arg0.ob_kiosks, 0x2::tx_context::sender(arg3)), arg1, 0x1::vector::pop_back<0x2::object::ID>(0xe5beebecbc63dd0552da2af0e6c773a6f1873ec25954d6db6320e853786e713e::ticket::borrow_mut_asset_ids(v0)), arg3);
        };
    }

    public(friend) fun take_reward<T0, T1, T2>(arg0: &mut Campaign<T0, T1, T2>, arg1: u64) : 0x1::option::Option<0x2::balance::Balance<T2>> {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0xe5beebecbc63dd0552da2af0e6c773a6f1873ec25954d6db6320e853786e713e::reward::Reward<T2>>(&arg0.rewards)) {
            if (arg1 == 0xe5beebecbc63dd0552da2af0e6c773a6f1873ec25954d6db6320e853786e713e::reward::winner<T2>(0x1::vector::borrow<0xe5beebecbc63dd0552da2af0e6c773a6f1873ec25954d6db6320e853786e713e::reward::Reward<T2>>(&arg0.rewards, v0))) {
                return 0x1::option::some<0x2::balance::Balance<T2>>(0xe5beebecbc63dd0552da2af0e6c773a6f1873ec25954d6db6320e853786e713e::reward::take_reward<T2>(0x1::vector::borrow_mut<0xe5beebecbc63dd0552da2af0e6c773a6f1873ec25954d6db6320e853786e713e::reward::Reward<T2>>(&mut arg0.rewards, v0)))
            };
            v0 = v0 + 1;
        };
        0x1::option::none<0x2::balance::Balance<T2>>()
    }

    public(friend) fun withdraw_at<T0, T1, T2>(arg0: &mut Campaign<T0, T1, T2>, arg1: u64) : 0x2::balance::Balance<T2> {
        0xe5beebecbc63dd0552da2af0e6c773a6f1873ec25954d6db6320e853786e713e::reward::take_reward<T2>(0x1::vector::borrow_mut<0xe5beebecbc63dd0552da2af0e6c773a6f1873ec25954d6db6320e853786e713e::reward::Reward<T2>>(&mut arg0.rewards, arg1))
    }

    // decompiled from Move bytecode v6
}

