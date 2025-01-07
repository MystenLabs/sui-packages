module 0x19d1ef8ca93685979877113a5839a10885b7d44437ff90e389a963b68ec0ab30::tocen_stake_token {
    struct Flexible<phantom T0> has store, key {
        id: 0x2::object::UID,
        total_stake: u64,
        annual_rewards: u64,
        bal_rewards: 0x2::balance::Balance<T0>,
        timestamp_created_pool: u64,
        key: vector<u8>,
        sig_time: u64,
    }

    struct PoolStake<phantom T0> has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        total_stake: u64,
        annual_rewards: u64,
        bal_rewards: 0x2::balance::Balance<T0>,
        type_pool: u64,
        timestamp_created_pool: u64,
        key: vector<u8>,
        sig_time: u64,
    }

    struct InfoUserStake<phantom T0> has store, key {
        id: 0x2::object::UID,
        user_total_stake: u64,
        balance_deposit: 0x2::balance::Balance<T0>,
        timestamp_created: u64,
        timestamp_claim: u64,
    }

    struct EventStakePool has copy, drop {
        object_id: 0x2::object::ID,
        info_user: 0x2::object::ID,
        owner_stake: address,
        balance_stake: u64,
        timestamp_stake: u64,
        timestamp_claim: u64,
    }

    struct EventAddStakePool has copy, drop {
        object_id: 0x2::object::ID,
        info_user: 0x2::object::ID,
        owner_stake: address,
        balance_stake: u64,
        timestamp_stake: u64,
        timestamp_claim: u64,
        check_renew: bool,
    }

    struct EventClaimPool has copy, drop {
        object_id: 0x2::object::ID,
        owner_claim: address,
        balance_claim: u64,
        balance_interest: u64,
        timestamp_claim: u64,
        balance_remaining: u64,
    }

    public entry fun add_pool_and_renew<T0>(arg0: &mut PoolStake<T0>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg4);
        let v1 = 0x2::dynamic_object_field::borrow_mut<address, InfoUserStake<T0>>(&mut arg0.id, 0x2::tx_context::sender(arg5));
        let v2 = &mut v1.id;
        let v3 = &mut v1.user_total_stake;
        let v4 = &mut v1.balance_deposit;
        let v5 = &mut v1.timestamp_claim;
        assert!(*v5 >= 0x2::clock::timestamp_ms(arg4), 5);
        transferToce<T0>(v4, arg1, arg2, arg5);
        arg0.total_stake = arg0.total_stake + arg2;
        *v3 = *v3 + arg2;
        let v6 = false;
        if (arg3 == 1) {
            v6 = true;
            *v5 = 0x19d1ef8ca93685979877113a5839a10885b7d44437ff90e389a963b68ec0ab30::utils::math_time_claim(v0, arg0.type_pool);
        };
        let v7 = EventAddStakePool{
            object_id       : 0x2::object::id<PoolStake<T0>>(arg0),
            info_user       : 0x2::object::uid_to_inner(v2),
            owner_stake     : 0x2::tx_context::sender(arg5),
            balance_stake   : arg2,
            timestamp_stake : v0,
            timestamp_claim : *v5,
            check_renew     : v6,
        };
        0x2::event::emit<EventAddStakePool>(v7);
    }

    fun check_sign_claim(arg0: vector<u8>, arg1: address, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : bool {
        let v0 = 0x1::string::utf8(b"0x");
        0x1::string::append(&mut v0, 0x2::address::to_string(arg1));
        0x1::string::append(&mut v0, 0x1::string::utf8(b".0x"));
        0x1::string::append(&mut v0, 0x2::address::to_string(0x2::tx_context::sender(arg4)));
        0x1::string::append(&mut v0, 0x1::string::utf8(b"."));
        0x1::string::append_utf8(&mut v0, numberToStr(arg2));
        0x1::string::append(&mut v0, 0x1::string::utf8(b"."));
        0x1::string::append_utf8(&mut v0, numberToStr(arg3));
        0x1::string::utf8(arg0) == v0
    }

    public entry fun claim_pool_flexible<T0>(arg0: &mut Flexible<T0>, arg1: vector<u8>, arg2: vector<u8>, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg7);
        let v1 = 0x19d1ef8ca93685979877113a5839a10885b7d44437ff90e389a963b68ec0ab30::utils::get_key();
        assert!(0x2::ed25519::ed25519_verify(&arg1, &v1, &arg2), 9);
        assert!(check_sign_claim(arg2, 0x2::object::id_address<Flexible<T0>>(arg0), arg3, arg6, arg8), 10);
        assert!(arg6 + arg0.sig_time >= v0, 12);
        assert!(arg5 <= arg4 + arg3, 13);
        let v2 = 0x2::dynamic_field::borrow_mut<address, 0x2::balance::Balance<T0>>(&mut arg0.id, 0x2::tx_context::sender(arg8));
        assert!(arg4 == 0x2::balance::value<T0>(v2), 11);
        arg0.total_stake = arg0.total_stake + arg3 - arg5;
        0x2::balance::join<T0>(v2, 0x2::balance::split<T0>(&mut arg0.bal_rewards, arg3));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(v2, arg5), arg8), 0x2::tx_context::sender(arg8));
        let v3 = EventClaimPool{
            object_id         : 0x2::object::id<Flexible<T0>>(arg0),
            owner_claim       : 0x2::tx_context::sender(arg8),
            balance_claim     : arg5,
            balance_interest  : arg3,
            timestamp_claim   : v0,
            balance_remaining : 0x2::balance::value<T0>(v2),
        };
        0x2::event::emit<EventClaimPool>(v3);
    }

    public entry fun claim_pool_month<T0>(arg0: &mut PoolStake<T0>, arg1: vector<u8>, arg2: vector<u8>, arg3: u64, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x19d1ef8ca93685979877113a5839a10885b7d44437ff90e389a963b68ec0ab30::utils::get_key();
        assert!(0x2::ed25519::ed25519_verify(&arg1, &v0, &arg2), 9);
        assert!(check_sign_claim(arg2, 0x2::object::id_address<PoolStake<T0>>(arg0), arg3, arg5, arg7), 10);
        let InfoUserStake {
            id                : v1,
            user_total_stake  : v2,
            balance_deposit   : v3,
            timestamp_created : _,
            timestamp_claim   : v5,
        } = 0x2::dynamic_object_field::remove<address, InfoUserStake<T0>>(&mut arg0.id, 0x2::tx_context::sender(arg7));
        arg0.total_stake = arg0.total_stake - arg4;
        assert!(v5 <= 0x2::clock::timestamp_ms(arg6), 5);
        assert!(arg4 == v2, 11);
        assert!(arg5 + arg0.sig_time >= 0x2::clock::timestamp_ms(arg6), 12);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.bal_rewards, arg3), arg7), 0x2::tx_context::sender(arg7));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v3, arg7), 0x2::tx_context::sender(arg7));
        0x2::object::delete(v1);
        let v6 = EventClaimPool{
            object_id         : 0x2::object::id<PoolStake<T0>>(arg0),
            owner_claim       : 0x2::tx_context::sender(arg7),
            balance_claim     : arg4 + arg3,
            balance_interest  : arg3,
            timestamp_claim   : 0x2::clock::timestamp_ms(arg6),
            balance_remaining : 0,
        };
        0x2::event::emit<EventClaimPool>(v6);
    }

    public entry fun create_poolStake<T0>(arg0: u64, arg1: vector<u8>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x19d1ef8ca93685979877113a5839a10885b7d44437ff90e389a963b68ec0ab30::witness::check_owner(arg4), 1);
        let v0 = PoolStake<T0>{
            id                     : 0x2::object::new(arg4),
            name                   : 0x1::string::utf8(arg1),
            total_stake            : 0,
            annual_rewards         : arg0,
            bal_rewards            : 0x2::balance::zero<T0>(),
            type_pool              : arg2,
            timestamp_created_pool : 0x2::clock::timestamp_ms(arg3),
            key                    : 0x19d1ef8ca93685979877113a5839a10885b7d44437ff90e389a963b68ec0ab30::utils::get_key(),
            sig_time               : 5 * 0x19d1ef8ca93685979877113a5839a10885b7d44437ff90e389a963b68ec0ab30::utils::get_time_phut(),
        };
        0x2::transfer::share_object<PoolStake<T0>>(v0);
    }

    public entry fun create_pool_flexible<T0>(arg0: u64, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x19d1ef8ca93685979877113a5839a10885b7d44437ff90e389a963b68ec0ab30::witness::check_owner(arg2), 1);
        let v0 = Flexible<T0>{
            id                     : 0x2::object::new(arg2),
            total_stake            : 0,
            annual_rewards         : arg0,
            bal_rewards            : 0x2::balance::zero<T0>(),
            timestamp_created_pool : 0x2::clock::timestamp_ms(arg1),
            key                    : 0x19d1ef8ca93685979877113a5839a10885b7d44437ff90e389a963b68ec0ab30::utils::get_key(),
            sig_time               : 2 * 0x19d1ef8ca93685979877113a5839a10885b7d44437ff90e389a963b68ec0ab30::utils::get_time_phut(),
        };
        0x2::transfer::share_object<Flexible<T0>>(v0);
    }

    public fun numberToStr(arg0: u64) : vector<u8> {
        let v0 = b"";
        if (arg0 == 0) {
            v0 = b"0";
        };
        while (arg0 % 10 >= 0 && arg0 > 0) {
            let v1 = b"0123456789";
            0x1::vector::insert<u8>(&mut v0, *0x1::vector::borrow<u8>(&v1, arg0 % 10), 0);
            arg0 = arg0 / 10;
        };
        v0
    }

    public entry fun stake_pool_flexible<T0>(arg0: &mut Flexible<T0>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        if (!0x2::dynamic_field::exists_<address>(&arg0.id, 0x2::tx_context::sender(arg4))) {
            0x2::dynamic_field::add<address, 0x2::balance::Balance<T0>>(&mut arg0.id, 0x2::tx_context::sender(arg4), 0x2::balance::zero<T0>());
        };
        let v0 = 0x2::dynamic_field::borrow_mut<address, 0x2::balance::Balance<T0>>(&mut arg0.id, 0x2::tx_context::sender(arg4));
        transferToce<T0>(v0, arg1, arg2, arg4);
        arg0.total_stake = arg0.total_stake + arg2;
        let v1 = EventStakePool{
            object_id       : 0x2::object::id<Flexible<T0>>(arg0),
            info_user       : 0x2::object::id<Flexible<T0>>(arg0),
            owner_stake     : 0x2::tx_context::sender(arg4),
            balance_stake   : arg2,
            timestamp_stake : 0x2::clock::timestamp_ms(arg3),
            timestamp_claim : 0,
        };
        0x2::event::emit<EventStakePool>(v1);
    }

    public entry fun stake_pool_month<T0>(arg0: &mut PoolStake<T0>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg3);
        let v1 = InfoUserStake<T0>{
            id                : 0x2::object::new(arg4),
            user_total_stake  : arg2,
            balance_deposit   : 0x2::balance::zero<T0>(),
            timestamp_created : v0,
            timestamp_claim   : 0x19d1ef8ca93685979877113a5839a10885b7d44437ff90e389a963b68ec0ab30::utils::math_time_claim(v0, arg0.type_pool),
        };
        arg0.total_stake = arg0.total_stake + arg2;
        let v2 = &mut v1.balance_deposit;
        transferToce<T0>(v2, arg1, arg2, arg4);
        let v3 = EventStakePool{
            object_id       : 0x2::object::id<PoolStake<T0>>(arg0),
            info_user       : 0x2::object::id<InfoUserStake<T0>>(&v1),
            owner_stake     : 0x2::tx_context::sender(arg4),
            balance_stake   : arg2,
            timestamp_stake : v0,
            timestamp_claim : 0x19d1ef8ca93685979877113a5839a10885b7d44437ff90e389a963b68ec0ab30::utils::math_time_claim(v0, arg0.type_pool),
        };
        0x2::event::emit<EventStakePool>(v3);
        0x2::dynamic_object_field::add<address, InfoUserStake<T0>>(&mut arg0.id, 0x2::tx_context::sender(arg4), v1);
    }

    public entry fun token_poolStake<T0>(arg0: &mut PoolStake<T0>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x19d1ef8ca93685979877113a5839a10885b7d44437ff90e389a963b68ec0ab30::witness::check_owner(arg3), 1);
        let v0 = &mut arg0.bal_rewards;
        transferToce<T0>(v0, arg1, arg2, arg3);
    }

    public entry fun token_pool_flexible<T0>(arg0: &mut Flexible<T0>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x19d1ef8ca93685979877113a5839a10885b7d44437ff90e389a963b68ec0ab30::witness::check_owner(arg3), 1);
        let v0 = &mut arg0.bal_rewards;
        transferToce<T0>(v0, arg1, arg2, arg3);
    }

    fun transferToce<T0>(arg0: &mut 0x2::balance::Balance<T0>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<T0>(&arg1) >= arg2, 6);
        0x2::balance::join<T0>(arg0, 0x2::balance::split<T0>(0x2::coin::balance_mut<T0>(&mut arg1), arg2));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, 0x2::tx_context::sender(arg3));
    }

    public entry fun up_key_flexible<T0>(arg0: &mut Flexible<T0>, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x19d1ef8ca93685979877113a5839a10885b7d44437ff90e389a963b68ec0ab30::witness::check_owner(arg2), 1);
        arg0.key = arg1;
    }

    public entry fun up_key_pool_month<T0>(arg0: &mut PoolStake<T0>, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x19d1ef8ca93685979877113a5839a10885b7d44437ff90e389a963b68ec0ab30::witness::check_owner(arg2), 1);
        arg0.key = arg1;
    }

    public entry fun up_rewards_flexible<T0>(arg0: &mut Flexible<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x19d1ef8ca93685979877113a5839a10885b7d44437ff90e389a963b68ec0ab30::witness::check_owner(arg2), 1);
        arg0.annual_rewards = arg1;
    }

    public entry fun up_rewards_poolstake<T0>(arg0: &mut PoolStake<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x19d1ef8ca93685979877113a5839a10885b7d44437ff90e389a963b68ec0ab30::witness::check_owner(arg2), 1);
        arg0.annual_rewards = arg1;
    }

    public entry fun up_sig_time_flexible<T0>(arg0: &mut Flexible<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x19d1ef8ca93685979877113a5839a10885b7d44437ff90e389a963b68ec0ab30::witness::check_owner(arg2), 1);
        arg0.sig_time = arg1;
    }

    public entry fun up_sig_time_poolstake<T0>(arg0: &mut PoolStake<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x19d1ef8ca93685979877113a5839a10885b7d44437ff90e389a963b68ec0ab30::witness::check_owner(arg2), 1);
        arg0.sig_time = arg1;
    }

    public entry fun with_flexible<T0>(arg0: &mut Flexible<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x19d1ef8ca93685979877113a5839a10885b7d44437ff90e389a963b68ec0ab30::witness::check_owner(arg2), 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.bal_rewards, arg1), arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun with_pool_month<T0>(arg0: &mut PoolStake<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x19d1ef8ca93685979877113a5839a10885b7d44437ff90e389a963b68ec0ab30::witness::check_owner(arg2), 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.bal_rewards, arg1), arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

