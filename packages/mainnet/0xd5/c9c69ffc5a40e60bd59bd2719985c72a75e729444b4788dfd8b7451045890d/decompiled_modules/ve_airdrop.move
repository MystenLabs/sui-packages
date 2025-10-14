module 0xd5c9c69ffc5a40e60bd59bd2719985c72a75e729444b4788dfd8b7451045890d::ve_airdrop {
    struct EventVeAirdropCreated has copy, drop, store {
        airdrop_id: 0x2::object::ID,
        amount: u64,
        root: vector<u8>,
        start: u64,
    }

    struct EventVeAirdropClaimed has copy, drop, store {
        airdrop_id: 0x2::object::ID,
        amount: u64,
        user: address,
    }

    struct EventVeAirdropWithdrawn has copy, drop, store {
        airdrop_id: 0x2::object::ID,
        amount: u64,
    }

    struct VeAirdrop<phantom T0> has store, key {
        id: 0x2::object::UID,
        airdrop: 0xd5c9c69ffc5a40e60bd59bd2719985c72a75e729444b4788dfd8b7451045890d::airdrop::Airdrop<T0>,
    }

    struct WithdrawCap has store, key {
        id: 0x2::object::UID,
        airdrop_id: 0x2::object::ID,
    }

    public fun new<T0>(arg0: 0x2::coin::Coin<T0>, arg1: vector<u8>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (VeAirdrop<T0>, WithdrawCap) {
        let v0 = 0x2::object::new(arg4);
        let v1 = 0x2::object::uid_to_inner(&v0);
        let v2 = EventVeAirdropCreated{
            airdrop_id : v1,
            amount     : 0x2::coin::value<T0>(&arg0),
            root       : arg1,
            start      : arg2,
        };
        0x2::event::emit<EventVeAirdropCreated>(v2);
        let v3 = VeAirdrop<T0>{
            id      : v0,
            airdrop : 0xd5c9c69ffc5a40e60bd59bd2719985c72a75e729444b4788dfd8b7451045890d::airdrop::new<T0>(arg0, arg1, arg2, arg3, arg4),
        };
        let v4 = WithdrawCap{
            id         : 0x2::object::new(arg4),
            airdrop_id : v1,
        };
        (v3, v4)
    }

    public fun balance<T0>(arg0: &VeAirdrop<T0>) : u64 {
        0xd5c9c69ffc5a40e60bd59bd2719985c72a75e729444b4788dfd8b7451045890d::airdrop::balance<T0>(&arg0.airdrop)
    }

    public fun borrow_map<T0>(arg0: &VeAirdrop<T0>) : &0xf7334947a5037552a94cee15fc471dbda71bf24d46c97ee24e1fdac38e26644c::bitmap::Bitmap {
        0xd5c9c69ffc5a40e60bd59bd2719985c72a75e729444b4788dfd8b7451045890d::airdrop::borrow_map<T0>(&arg0.airdrop)
    }

    public fun get_airdrop<T0>(arg0: &mut VeAirdrop<T0>, arg1: &mut 0x65a0317036d4b666a15c8f56ec2d58e1c617566bedd50b4677fb31d2e49b12d2::voting_escrow::VotingEscrow<T0>, arg2: vector<vector<u8>>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = EventVeAirdropClaimed{
            airdrop_id : 0x2::object::id<VeAirdrop<T0>>(arg0),
            amount     : arg3,
            user       : 0x2::tx_context::sender(arg5),
        };
        0x2::event::emit<EventVeAirdropClaimed>(v0);
        0x65a0317036d4b666a15c8f56ec2d58e1c617566bedd50b4677fb31d2e49b12d2::voting_escrow::create_lock<T0>(arg1, 0xd5c9c69ffc5a40e60bd59bd2719985c72a75e729444b4788dfd8b7451045890d::airdrop::get_airdrop<T0>(&mut arg0.airdrop, arg2, arg4, arg3, arg5), 1456, true, arg4, arg5);
    }

    public fun has_account_claimed<T0>(arg0: &VeAirdrop<T0>, arg1: vector<vector<u8>>, arg2: u64, arg3: address) : bool {
        0xd5c9c69ffc5a40e60bd59bd2719985c72a75e729444b4788dfd8b7451045890d::airdrop::has_account_claimed<T0>(&arg0.airdrop, arg1, arg2, arg3)
    }

    public fun root<T0>(arg0: &VeAirdrop<T0>) : vector<u8> {
        0xd5c9c69ffc5a40e60bd59bd2719985c72a75e729444b4788dfd8b7451045890d::airdrop::root<T0>(&arg0.airdrop)
    }

    public fun start<T0>(arg0: &VeAirdrop<T0>) : u64 {
        0xd5c9c69ffc5a40e60bd59bd2719985c72a75e729444b4788dfd8b7451045890d::airdrop::start<T0>(&arg0.airdrop)
    }

    public fun get_airdrop_v2<T0>(arg0: &mut VeAirdrop<T0>, arg1: &mut 0x61d3c07c67f6ebcc46c950a731dd263a0325fdfe03382e1bd50e4aba964f9e1c::voting_escrow::VotingEscrow<T0>, arg2: vector<vector<u8>>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = EventVeAirdropClaimed{
            airdrop_id : 0x2::object::id<VeAirdrop<T0>>(arg0),
            amount     : arg3,
            user       : 0x2::tx_context::sender(arg5),
        };
        0x2::event::emit<EventVeAirdropClaimed>(v0);
        0x61d3c07c67f6ebcc46c950a731dd263a0325fdfe03382e1bd50e4aba964f9e1c::voting_escrow::create_lock<T0>(arg1, 0xd5c9c69ffc5a40e60bd59bd2719985c72a75e729444b4788dfd8b7451045890d::airdrop::get_airdrop<T0>(&mut arg0.airdrop, arg2, arg4, arg3, arg5), 1456, true, arg4, arg5);
    }

    public fun withdraw_and_destroy<T0>(arg0: VeAirdrop<T0>, arg1: &WithdrawCap, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg1.airdrop_id == 0x2::object::id<VeAirdrop<T0>>(&arg0), 486723797964389060);
        let VeAirdrop {
            id      : v0,
            airdrop : v1,
        } = arg0;
        0x2::object::delete(v0);
        let v2 = 0xd5c9c69ffc5a40e60bd59bd2719985c72a75e729444b4788dfd8b7451045890d::airdrop::destroy<T0>(v1, arg2);
        let v3 = EventVeAirdropWithdrawn{
            airdrop_id : 0x2::object::id<VeAirdrop<T0>>(&arg0),
            amount     : 0x2::coin::value<T0>(&v2),
        };
        0x2::event::emit<EventVeAirdropWithdrawn>(v3);
        v2
    }

    // decompiled from Move bytecode v6
}

