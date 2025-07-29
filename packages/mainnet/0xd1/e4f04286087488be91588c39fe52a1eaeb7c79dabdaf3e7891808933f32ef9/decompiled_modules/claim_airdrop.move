module 0xd1e4f04286087488be91588c39fe52a1eaeb7c79dabdaf3e7891808933f32ef9::claim_airdrop {
    struct CLAIM_AIRDROP has drop {
        dummy_field: bool,
    }

    struct ClaimConfig has store, key {
        id: 0x2::object::UID,
        signer_pk: 0x1::option::Option<vector<u8>>,
        claimable: 0x2::balance::Balance<0x25775538ca79a4cb55682e9613c86e7e6df5d5537b9e68f6cb265830cc35c794::test_token::TEST_TOKEN>,
        chain_id: u64,
        latest_airdrop_round: u64,
        blacks: 0x2::table::Table<address, bool>,
        claimed: 0x2::table::Table<address, bool>,
        version: u64,
        paused: bool,
    }

    struct UserAirdropPosition has key {
        id: 0x2::object::UID,
        total_allocation: u64,
        claimed: u64,
        airdrop_rounds: 0x2::vec_set::VecSet<u64>,
        messages: 0x2::vec_set::VecSet<vector<u8>>,
    }

    struct ClaimMessage has store {
        airdrop_round: u64,
        receiver: address,
        total_allocation: u64,
        amount: u64,
        valid_until: u64,
        chain_id: u64,
    }

    struct InitClaimEvent has copy, drop {
        receiver: address,
        total_allocation: u64,
        claimed_amount: u64,
        airdrop_round: u64,
        user_position_id: 0x2::object::ID,
    }

    struct ClaimEvent has copy, drop {
        receiver: address,
        claimed_amount: u64,
        total_claimed: u64,
        airdrop_round: u64,
    }

    struct AddClaimableBalanceEvent has copy, drop {
        amount: u64,
    }

    struct SetSignerPkEvent has copy, drop {
        signer_pk: vector<u8>,
    }

    struct SetChainIdEvent has copy, drop {
        chain_id: u64,
    }

    struct UpdateLatestRoundEvent has copy, drop {
        round: u64,
    }

    struct AddToBlacklistEvent has copy, drop {
        addr: address,
    }

    struct RemoveFromBlacklistEvent has copy, drop {
        addr: address,
    }

    struct PauseEvent has copy, drop {
        paused: bool,
    }

    struct UnpauseEvent has copy, drop {
        paused: bool,
    }

    public fun claim_airdrop(arg0: &mut ClaimConfig, arg1: &mut UserAirdropPosition, arg2: vector<u8>, arg3: vector<u8>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(arg2);
        let v1 = ClaimMessage{
            airdrop_round    : 0x2::bcs::peel_u64(&mut v0),
            receiver         : 0x2::bcs::peel_address(&mut v0),
            total_allocation : 0x2::bcs::peel_u64(&mut v0),
            amount           : 0x2::bcs::peel_u64(&mut v0),
            valid_until      : 0x2::bcs::peel_u64(&mut v0),
            chain_id         : 0x2::bcs::peel_u64(&mut v0),
        };
        assert!(0x1::option::is_some<vector<u8>>(&arg0.signer_pk), 11);
        check_signature(arg2, arg3, *0x1::option::borrow<vector<u8>>(&arg0.signer_pk));
        assert!(arg0.version == 1, 1);
        assert!(!arg0.paused, 14);
        assert!(v1.chain_id == arg0.chain_id, 2);
        assert!(v1.valid_until > 0x2::clock::timestamp_ms(arg4), 3);
        assert!(v1.receiver == 0x2::tx_context::sender(arg5), 4);
        assert!(v1.airdrop_round > 0, 5);
        assert!(v1.airdrop_round <= arg0.latest_airdrop_round, 5);
        assert!(!0x2::table::contains<address, bool>(&arg0.blacks, v1.receiver), 6);
        assert!(0x2::balance::value<0x25775538ca79a4cb55682e9613c86e7e6df5d5537b9e68f6cb265830cc35c794::test_token::TEST_TOKEN>(&arg0.claimable) >= v1.amount, 8);
        assert!(arg1.claimed + v1.amount <= arg1.total_allocation, 9);
        let v2 = 0x2::hash::keccak256(&arg2);
        assert!(!0x2::vec_set::contains<vector<u8>>(&arg1.messages, &v2), 12);
        0x2::vec_set::insert<vector<u8>>(&mut arg1.messages, v2);
        assert!(!0x2::vec_set::contains<u64>(&arg1.airdrop_rounds, &v1.airdrop_round), 13);
        0x2::vec_set::insert<u64>(&mut arg1.airdrop_rounds, v1.airdrop_round);
        arg1.claimed = arg1.claimed + v1.amount;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x25775538ca79a4cb55682e9613c86e7e6df5d5537b9e68f6cb265830cc35c794::test_token::TEST_TOKEN>>(0x2::coin::from_balance<0x25775538ca79a4cb55682e9613c86e7e6df5d5537b9e68f6cb265830cc35c794::test_token::TEST_TOKEN>(0x2::balance::split<0x25775538ca79a4cb55682e9613c86e7e6df5d5537b9e68f6cb265830cc35c794::test_token::TEST_TOKEN>(&mut arg0.claimable, v1.amount), arg5), v1.receiver);
        let v3 = ClaimEvent{
            receiver       : v1.receiver,
            claimed_amount : v1.amount,
            total_claimed  : arg1.claimed,
            airdrop_round  : v1.airdrop_round,
        };
        0x2::event::emit<ClaimEvent>(v3);
        let ClaimMessage {
            airdrop_round    : _,
            receiver         : _,
            total_allocation : _,
            amount           : _,
            valid_until      : _,
            chain_id         : _,
        } = v1;
    }

    public fun add_claimable_balance(arg0: &mut ClaimConfig, arg1: 0x2::coin::Coin<0x25775538ca79a4cb55682e9613c86e7e6df5d5537b9e68f6cb265830cc35c794::test_token::TEST_TOKEN>) {
        0x2::balance::join<0x25775538ca79a4cb55682e9613c86e7e6df5d5537b9e68f6cb265830cc35c794::test_token::TEST_TOKEN>(&mut arg0.claimable, 0x2::coin::into_balance<0x25775538ca79a4cb55682e9613c86e7e6df5d5537b9e68f6cb265830cc35c794::test_token::TEST_TOKEN>(arg1));
        let v0 = AddClaimableBalanceEvent{amount: 0x2::coin::value<0x25775538ca79a4cb55682e9613c86e7e6df5d5537b9e68f6cb265830cc35c794::test_token::TEST_TOKEN>(&arg1)};
        0x2::event::emit<AddClaimableBalanceEvent>(v0);
    }

    public(friend) fun add_to_blacklist(arg0: &mut ClaimConfig, arg1: address) {
        assert!(arg0.version == 1, 1);
        if (!0x2::table::contains<address, bool>(&arg0.blacks, arg1)) {
            0x2::table::add<address, bool>(&mut arg0.blacks, arg1, true);
            let v0 = AddToBlacklistEvent{addr: arg1};
            0x2::event::emit<AddToBlacklistEvent>(v0);
        };
    }

    fun check_signature(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>) {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 1;
        loop {
            if (v1 == 33) {
                break
            };
            0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(&arg2, v1));
            v1 = v1 + 1;
        };
        assert!(0x2::ed25519::ed25519_verify(&arg1, &v0, &arg0), 10);
    }

    public fun get_chain_id(arg0: &ClaimConfig) : u64 {
        arg0.chain_id
    }

    public fun get_claimed_amount(arg0: &UserAirdropPosition) : u64 {
        arg0.claimed
    }

    public fun get_latest_round(arg0: &ClaimConfig) : u64 {
        arg0.latest_airdrop_round
    }

    public fun get_remaining_claimable(arg0: &UserAirdropPosition) : u64 {
        arg0.total_allocation - arg0.claimed
    }

    public fun get_user_allocation(arg0: &UserAirdropPosition) : u64 {
        arg0.total_allocation
    }

    public fun get_version(arg0: &ClaimConfig) : u64 {
        arg0.version
    }

    fun init(arg0: CLAIM_AIRDROP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = ClaimConfig{
            id                   : 0x2::object::new(arg1),
            signer_pk            : 0x1::option::none<vector<u8>>(),
            claimable            : 0x2::balance::zero<0x25775538ca79a4cb55682e9613c86e7e6df5d5537b9e68f6cb265830cc35c794::test_token::TEST_TOKEN>(),
            chain_id             : 0,
            latest_airdrop_round : 0,
            blacks               : 0x2::table::new<address, bool>(arg1),
            claimed              : 0x2::table::new<address, bool>(arg1),
            version              : 1,
            paused               : false,
        };
        0x2::transfer::public_share_object<ClaimConfig>(v0);
    }

    public fun init_airdrop(arg0: &mut ClaimConfig, arg1: vector<u8>, arg2: vector<u8>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(arg1);
        let v1 = ClaimMessage{
            airdrop_round    : 0x2::bcs::peel_u64(&mut v0),
            receiver         : 0x2::bcs::peel_address(&mut v0),
            total_allocation : 0x2::bcs::peel_u64(&mut v0),
            amount           : 0x2::bcs::peel_u64(&mut v0),
            valid_until      : 0x2::bcs::peel_u64(&mut v0),
            chain_id         : 0x2::bcs::peel_u64(&mut v0),
        };
        assert!(0x1::option::is_some<vector<u8>>(&arg0.signer_pk), 11);
        check_signature(arg1, arg2, *0x1::option::borrow<vector<u8>>(&arg0.signer_pk));
        assert!(arg0.version == 1, 1);
        assert!(!arg0.paused, 14);
        assert!(v1.chain_id == arg0.chain_id, 2);
        assert!(v1.valid_until > 0x2::clock::timestamp_ms(arg3), 3);
        assert!(v1.receiver == 0x2::tx_context::sender(arg4), 4);
        assert!(v1.airdrop_round == 0, 5);
        assert!(!0x2::table::contains<address, bool>(&arg0.blacks, v1.receiver), 6);
        assert!(!0x2::table::contains<address, bool>(&arg0.claimed, v1.receiver), 7);
        assert!(0x2::balance::value<0x25775538ca79a4cb55682e9613c86e7e6df5d5537b9e68f6cb265830cc35c794::test_token::TEST_TOKEN>(&arg0.claimable) >= v1.amount, 8);
        assert!(v1.amount <= v1.total_allocation, 9);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x25775538ca79a4cb55682e9613c86e7e6df5d5537b9e68f6cb265830cc35c794::test_token::TEST_TOKEN>>(0x2::coin::from_balance<0x25775538ca79a4cb55682e9613c86e7e6df5d5537b9e68f6cb265830cc35c794::test_token::TEST_TOKEN>(0x2::balance::split<0x25775538ca79a4cb55682e9613c86e7e6df5d5537b9e68f6cb265830cc35c794::test_token::TEST_TOKEN>(&mut arg0.claimable, v1.amount), arg4), v1.receiver);
        0x2::table::add<address, bool>(&mut arg0.claimed, v1.receiver, true);
        let v2 = UserAirdropPosition{
            id               : 0x2::object::new(arg4),
            total_allocation : v1.total_allocation,
            claimed          : v1.amount,
            airdrop_rounds   : 0x2::vec_set::empty<u64>(),
            messages         : 0x2::vec_set::empty<vector<u8>>(),
        };
        0x2::vec_set::insert<u64>(&mut v2.airdrop_rounds, v1.airdrop_round);
        0x2::vec_set::insert<vector<u8>>(&mut v2.messages, 0x2::hash::keccak256(&arg1));
        0x2::transfer::transfer<UserAirdropPosition>(v2, v1.receiver);
        let v3 = InitClaimEvent{
            receiver         : v1.receiver,
            total_allocation : v1.total_allocation,
            claimed_amount   : v1.amount,
            airdrop_round    : 0,
            user_position_id : 0x2::object::id<UserAirdropPosition>(&v2),
        };
        0x2::event::emit<InitClaimEvent>(v3);
        let ClaimMessage {
            airdrop_round    : _,
            receiver         : _,
            total_allocation : _,
            amount           : _,
            valid_until      : _,
            chain_id         : _,
        } = v1;
    }

    public fun is_blacklisted(arg0: &ClaimConfig, arg1: address) : bool {
        0x2::table::contains<address, bool>(&arg0.blacks, arg1)
    }

    public fun is_claimed(arg0: &ClaimConfig, arg1: address) : bool {
        0x2::table::contains<address, bool>(&arg0.claimed, arg1)
    }

    public fun is_round_claimed(arg0: &UserAirdropPosition, arg1: u64) : bool {
        0x2::vec_set::contains<u64>(&arg0.airdrop_rounds, &arg1)
    }

    public(friend) fun pause(arg0: &mut ClaimConfig) {
        assert!(arg0.version == 1, 1);
        arg0.paused = true;
        let v0 = PauseEvent{paused: true};
        0x2::event::emit<PauseEvent>(v0);
    }

    public(friend) fun remove_from_blacklist(arg0: &mut ClaimConfig, arg1: address) {
        assert!(arg0.version == 1, 1);
        if (0x2::table::contains<address, bool>(&arg0.blacks, arg1)) {
            0x2::table::remove<address, bool>(&mut arg0.blacks, arg1);
            let v0 = RemoveFromBlacklistEvent{addr: arg1};
            0x2::event::emit<RemoveFromBlacklistEvent>(v0);
        };
    }

    public(friend) fun set_chain_id(arg0: &mut ClaimConfig, arg1: u64) {
        assert!(arg0.version == 1, 1);
        arg0.chain_id = arg1;
        let v0 = SetChainIdEvent{chain_id: arg1};
        0x2::event::emit<SetChainIdEvent>(v0);
    }

    public(friend) fun set_signer_pk(arg0: &mut ClaimConfig, arg1: vector<u8>) {
        assert!(arg0.version == 1, 1);
        arg0.signer_pk = 0x1::option::some<vector<u8>>(arg1);
        let v0 = SetSignerPkEvent{signer_pk: arg1};
        0x2::event::emit<SetSignerPkEvent>(v0);
    }

    public(friend) fun unpause(arg0: &mut ClaimConfig) {
        assert!(arg0.version == 1, 1);
        arg0.paused = false;
        let v0 = UnpauseEvent{paused: false};
        0x2::event::emit<UnpauseEvent>(v0);
    }

    public(friend) fun update_latest_round(arg0: &mut ClaimConfig, arg1: u64) {
        assert!(arg0.version == 1, 1);
        arg0.latest_airdrop_round = arg1;
        let v0 = UpdateLatestRoundEvent{round: arg1};
        0x2::event::emit<UpdateLatestRoundEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

