module 0x5e72424d7b4b7cc561cae7e49b8dfe3671d184702cce2667fb64b7836e5818fb::bounty {
    struct Bounty has store, key {
        id: 0x2::object::UID,
    }

    struct BountyCapV1 has key {
        id: 0x2::object::UID,
        bounty_id: 0x2::object::ID,
    }

    struct BountyDataV1 has store {
        title: 0x1::string::String,
        description: 0x1::string::String,
        requirements: 0x1::string::String,
        reward: u64,
        submissions: 0x2::table::Table<address, 0x1::string::String>,
        created_at: 0x1::string::String,
        deadline: 0x1::string::String,
        winner: 0x1::option::Option<address>,
    }

    struct BountyPostedV1 has copy, drop {
        id: 0x2::object::ID,
    }

    entry fun new(arg0: &mut 0x5e72424d7b4b7cc561cae7e49b8dfe3671d184702cce2667fb64b7836e5818fb::platform::Platform, arg1: 0x2::object::ID, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: u64, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: &mut 0x2::tx_context::TxContext) {
        0x5e72424d7b4b7cc561cae7e49b8dfe3671d184702cce2667fb64b7836e5818fb::platform::assert_current_version(arg0);
        let v0 = Bounty{id: 0x2::object::new(arg8)};
        let v1 = BountyDataV1{
            title        : arg2,
            description  : arg3,
            requirements : arg4,
            reward       : arg5,
            submissions  : 0x2::table::new<address, 0x1::string::String>(arg8),
            created_at   : arg6,
            deadline     : arg7,
            winner       : 0x1::option::none<address>(),
        };
        let v2 = 0x2::object::uid_to_inner(&v0.id);
        let v3 = BountyPostedV1{id: v2};
        0x2::event::emit<BountyPostedV1>(v3);
        0x2::dynamic_field::add<vector<u8>, BountyDataV1>(&mut v0.id, b"data_v1", v1);
        0x2::dynamic_field::add<0x2::object::ID, Bounty>(0x5e72424d7b4b7cc561cae7e49b8dfe3671d184702cce2667fb64b7836e5818fb::company::uid_mut(0x5e72424d7b4b7cc561cae7e49b8dfe3671d184702cce2667fb64b7836e5818fb::company::self_mut(arg0, arg1)), v2, v0);
        let v4 = BountyCapV1{
            id        : 0x2::object::new(arg8),
            bounty_id : v2,
        };
        0x2::transfer::transfer<BountyCapV1>(v4, 0x2::tx_context::sender(arg8));
    }

    fun select_winner_internal<T0>(arg0: &mut 0x5e72424d7b4b7cc561cae7e49b8dfe3671d184702cce2667fb64b7836e5818fb::platform::Platform, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: address, arg4: 0x2::coin::Coin<T0>, arg5: &mut 0x2::tx_context::TxContext) {
        0x5e72424d7b4b7cc561cae7e49b8dfe3671d184702cce2667fb64b7836e5818fb::platform::assert_current_version(arg0);
        0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T0>()));
        let v0 = 0x5e72424d7b4b7cc561cae7e49b8dfe3671d184702cce2667fb64b7836e5818fb::company::self_mut(arg0, arg1);
        0x5e72424d7b4b7cc561cae7e49b8dfe3671d184702cce2667fb64b7836e5818fb::company::update_completed_payouts(v0);
        let v1 = 0x2::dynamic_field::borrow_mut<0x2::object::ID, Bounty>(0x5e72424d7b4b7cc561cae7e49b8dfe3671d184702cce2667fb64b7836e5818fb::company::uid_mut(v0), arg2);
        let v2 = 0x2::dynamic_field::borrow_mut<vector<u8>, BountyDataV1>(uid_mut(v1), b"data_v1");
        v2.winner = 0x1::option::some<address>(arg3);
        0x2::pay::split_and_transfer<T0>(&mut arg4, v2.reward, arg3, arg5);
        0x2::coin::destroy_zero<T0>(arg4);
    }

    public fun select_winner_v1<T0>(arg0: &mut 0x5e72424d7b4b7cc561cae7e49b8dfe3671d184702cce2667fb64b7836e5818fb::platform::Platform, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: address, arg4: 0x2::coin::Coin<T0>, arg5: &mut 0x2::tx_context::TxContext) {
        select_winner_internal<T0>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    entry fun submit(arg0: &mut 0x5e72424d7b4b7cc561cae7e49b8dfe3671d184702cce2667fb64b7836e5818fb::platform::Platform, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: 0x1::string::String, arg4: &0x2::tx_context::TxContext) {
        0x5e72424d7b4b7cc561cae7e49b8dfe3671d184702cce2667fb64b7836e5818fb::platform::assert_current_version(arg0);
        let v0 = 0x2::dynamic_field::borrow_mut<0x2::object::ID, Bounty>(0x5e72424d7b4b7cc561cae7e49b8dfe3671d184702cce2667fb64b7836e5818fb::company::uid_mut(0x5e72424d7b4b7cc561cae7e49b8dfe3671d184702cce2667fb64b7836e5818fb::company::self_mut(arg0, arg1)), arg2);
        0x2::table::add<address, 0x1::string::String>(&mut 0x2::dynamic_field::borrow_mut<vector<u8>, BountyDataV1>(uid_mut(v0), b"data_v1").submissions, 0x2::tx_context::sender(arg4), arg3);
    }

    entry fun transfer_bounty_cap(arg0: BountyCapV1, arg1: address) {
        0x2::transfer::transfer<BountyCapV1>(arg0, arg1);
    }

    public(friend) fun uid(arg0: &Bounty) : &0x2::object::UID {
        &arg0.id
    }

    public(friend) fun uid_mut(arg0: &mut Bounty) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    // decompiled from Move bytecode v6
}

