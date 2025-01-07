module 0xb5380b5c814ee99a5ad4536a1c329256ed19038eeb64fad2d44fae58e3b47c15::campaign {
    struct Campaign<phantom T0, phantom T1, phantom T2> has store, key {
        id: 0x2::object::UID,
        metadata: 0x1::string::String,
        created_at_ms: u64,
        ended_at_ms: u64,
        offered_coin_amount: u64,
        offered_nft_asset_amount: u64,
        total_token_reward: u64,
        rewards: vector<0xb5380b5c814ee99a5ad4536a1c329256ed19038eeb64fad2d44fae58e3b47c15::reward::Reward<T2>>,
        coin_custodian: 0xb5380b5c814ee99a5ad4536a1c329256ed19038eeb64fad2d44fae58e3b47c15::custodian::Custodian<0x2::coin::Coin<T0>>,
        nft_asset_custodian: 0xb5380b5c814ee99a5ad4536a1c329256ed19038eeb64fad2d44fae58e3b47c15::custodian::Custodian<T1>,
        sponsor: address,
        tickets: 0x2::table::Table<u64, 0xb5380b5c814ee99a5ad4536a1c329256ed19038eeb64fad2d44fae58e3b47c15::ticket::Ticket>,
        owners: 0x2::table::Table<u64, address>,
        owned_tickets: 0x2::table::Table<address, vector<u64>>,
        ticket_number_counter: u64,
        distributed: bool,
    }

    public(friend) fun new<T0: drop, T1: store + key, T2: drop>(arg0: 0x1::string::String, arg1: u64, arg2: u64, arg3: u64, arg4: 0x2::balance::Balance<T2>, arg5: vector<u64>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : Campaign<T0, T1, T2> {
        let v0 = 0x1::vector::empty<0xb5380b5c814ee99a5ad4536a1c329256ed19038eeb64fad2d44fae58e3b47c15::reward::Reward<T2>>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<u64>(&arg5)) {
            0x1::vector::push_back<0xb5380b5c814ee99a5ad4536a1c329256ed19038eeb64fad2d44fae58e3b47c15::reward::Reward<T2>>(&mut v0, 0xb5380b5c814ee99a5ad4536a1c329256ed19038eeb64fad2d44fae58e3b47c15::reward::new<T2>(0x2::balance::split<T2>(&mut arg4, *0x1::vector::borrow<u64>(&arg5, v1))));
            v1 = v1 + 1;
        };
        0x2::balance::destroy_zero<T2>(arg4);
        Campaign<T0, T1, T2>{
            id                       : 0x2::object::new(arg7),
            metadata                 : arg0,
            created_at_ms            : 0x2::clock::timestamp_ms(arg6),
            ended_at_ms              : arg1,
            offered_coin_amount      : arg2,
            offered_nft_asset_amount : arg3,
            total_token_reward       : 0x2::balance::value<T2>(&arg4),
            rewards                  : v0,
            coin_custodian           : 0xb5380b5c814ee99a5ad4536a1c329256ed19038eeb64fad2d44fae58e3b47c15::custodian::new<0x2::coin::Coin<T0>>(arg7),
            nft_asset_custodian      : 0xb5380b5c814ee99a5ad4536a1c329256ed19038eeb64fad2d44fae58e3b47c15::custodian::new<T1>(arg7),
            sponsor                  : 0x2::tx_context::sender(arg7),
            tickets                  : 0x2::table::new<u64, 0xb5380b5c814ee99a5ad4536a1c329256ed19038eeb64fad2d44fae58e3b47c15::ticket::Ticket>(arg7),
            owners                   : 0x2::table::new<u64, address>(arg7),
            owned_tickets            : 0x2::table::new<address, vector<u64>>(arg7),
            ticket_number_counter    : 1,
            distributed              : false,
        }
    }

    public(friend) fun borrow_mut_coin_custodian<T0, T1, T2>(arg0: &mut Campaign<T0, T1, T2>) : &mut 0xb5380b5c814ee99a5ad4536a1c329256ed19038eeb64fad2d44fae58e3b47c15::custodian::Custodian<0x2::coin::Coin<T0>> {
        &mut arg0.coin_custodian
    }

    public(friend) fun borrow_mut_nft_asset_custodian<T0, T1, T2>(arg0: &mut Campaign<T0, T1, T2>) : &mut 0xb5380b5c814ee99a5ad4536a1c329256ed19038eeb64fad2d44fae58e3b47c15::custodian::Custodian<T1> {
        &mut arg0.nft_asset_custodian
    }

    public(friend) fun borrow_mut_owned_tickets<T0, T1, T2>(arg0: &mut Campaign<T0, T1, T2>) : &mut 0x2::table::Table<address, vector<u64>> {
        &mut arg0.owned_tickets
    }

    public(friend) fun borrow_mut_owners<T0, T1, T2>(arg0: &mut Campaign<T0, T1, T2>) : &mut 0x2::table::Table<u64, address> {
        &mut arg0.owners
    }

    public(friend) fun borrow_mut_rewards<T0, T1, T2>(arg0: &mut Campaign<T0, T1, T2>) : &mut vector<0xb5380b5c814ee99a5ad4536a1c329256ed19038eeb64fad2d44fae58e3b47c15::reward::Reward<T2>> {
        &mut arg0.rewards
    }

    public(friend) fun borrow_mut_tickets<T0, T1, T2>(arg0: &mut Campaign<T0, T1, T2>) : &mut 0x2::table::Table<u64, 0xb5380b5c814ee99a5ad4536a1c329256ed19038eeb64fad2d44fae58e3b47c15::ticket::Ticket> {
        &mut arg0.tickets
    }

    public fun borrow_owned_tickets<T0, T1, T2>(arg0: &Campaign<T0, T1, T2>) : &0x2::table::Table<address, vector<u64>> {
        &arg0.owned_tickets
    }

    public fun borrow_owners<T0, T1, T2>(arg0: &Campaign<T0, T1, T2>) : &0x2::table::Table<u64, address> {
        &arg0.owners
    }

    public fun borrow_rewards<T0, T1, T2>(arg0: &Campaign<T0, T1, T2>) : &vector<0xb5380b5c814ee99a5ad4536a1c329256ed19038eeb64fad2d44fae58e3b47c15::reward::Reward<T2>> {
        &arg0.rewards
    }

    public fun borrow_tickets<T0, T1, T2>(arg0: &Campaign<T0, T1, T2>) : &0x2::table::Table<u64, 0xb5380b5c814ee99a5ad4536a1c329256ed19038eeb64fad2d44fae58e3b47c15::ticket::Ticket> {
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

    public fun offered_nft_asset_amount<T0, T1, T2>(arg0: &Campaign<T0, T1, T2>) : u64 {
        arg0.offered_nft_asset_amount
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
        let v1 = 0x2::table::borrow_mut<u64, 0xb5380b5c814ee99a5ad4536a1c329256ed19038eeb64fad2d44fae58e3b47c15::ticket::Ticket>(&mut arg0.tickets, arg1);
        while (!0x1::vector::is_empty<0x2::object::ID>(0xb5380b5c814ee99a5ad4536a1c329256ed19038eeb64fad2d44fae58e3b47c15::ticket::asset_ids(v1))) {
            0x1::vector::push_back<0x2::coin::Coin<T0>>(&mut v0, 0xb5380b5c814ee99a5ad4536a1c329256ed19038eeb64fad2d44fae58e3b47c15::custodian::take<0x2::coin::Coin<T0>>(&mut arg0.coin_custodian, 0x1::vector::pop_back<0x2::object::ID>(0xb5380b5c814ee99a5ad4536a1c329256ed19038eeb64fad2d44fae58e3b47c15::ticket::borrow_mut_asset_ids(v1))));
        };
        v0
    }

    public(friend) fun take_nft_assets<T0: drop, T1: store + key, T2>(arg0: &mut Campaign<T0, T1, T2>, arg1: u64) : vector<T1> {
        let v0 = 0x1::vector::empty<T1>();
        let v1 = 0x2::table::borrow_mut<u64, 0xb5380b5c814ee99a5ad4536a1c329256ed19038eeb64fad2d44fae58e3b47c15::ticket::Ticket>(&mut arg0.tickets, arg1);
        while (!0x1::vector::is_empty<0x2::object::ID>(0xb5380b5c814ee99a5ad4536a1c329256ed19038eeb64fad2d44fae58e3b47c15::ticket::asset_ids(v1))) {
            0x1::vector::push_back<T1>(&mut v0, 0xb5380b5c814ee99a5ad4536a1c329256ed19038eeb64fad2d44fae58e3b47c15::custodian::take<T1>(&mut arg0.nft_asset_custodian, 0x1::vector::pop_back<0x2::object::ID>(0xb5380b5c814ee99a5ad4536a1c329256ed19038eeb64fad2d44fae58e3b47c15::ticket::borrow_mut_asset_ids(v1))));
        };
        v0
    }

    public(friend) fun take_reward<T0, T1, T2>(arg0: &mut Campaign<T0, T1, T2>, arg1: u64) : 0x1::option::Option<0x2::balance::Balance<T2>> {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0xb5380b5c814ee99a5ad4536a1c329256ed19038eeb64fad2d44fae58e3b47c15::reward::Reward<T2>>(&arg0.rewards)) {
            if (arg1 == 0xb5380b5c814ee99a5ad4536a1c329256ed19038eeb64fad2d44fae58e3b47c15::reward::winner<T2>(0x1::vector::borrow<0xb5380b5c814ee99a5ad4536a1c329256ed19038eeb64fad2d44fae58e3b47c15::reward::Reward<T2>>(&arg0.rewards, v0))) {
                return 0x1::option::some<0x2::balance::Balance<T2>>(0xb5380b5c814ee99a5ad4536a1c329256ed19038eeb64fad2d44fae58e3b47c15::reward::take_reward<T2>(0x1::vector::borrow_mut<0xb5380b5c814ee99a5ad4536a1c329256ed19038eeb64fad2d44fae58e3b47c15::reward::Reward<T2>>(&mut arg0.rewards, v0)))
            };
            v0 = v0 + 1;
        };
        0x1::option::none<0x2::balance::Balance<T2>>()
    }

    public(friend) fun withdraw_at<T0, T1, T2>(arg0: &mut Campaign<T0, T1, T2>, arg1: u64) : 0x2::balance::Balance<T2> {
        0xb5380b5c814ee99a5ad4536a1c329256ed19038eeb64fad2d44fae58e3b47c15::reward::take_reward<T2>(0x1::vector::borrow_mut<0xb5380b5c814ee99a5ad4536a1c329256ed19038eeb64fad2d44fae58e3b47c15::reward::Reward<T2>>(&mut arg0.rewards, arg1))
    }

    // decompiled from Move bytecode v6
}

