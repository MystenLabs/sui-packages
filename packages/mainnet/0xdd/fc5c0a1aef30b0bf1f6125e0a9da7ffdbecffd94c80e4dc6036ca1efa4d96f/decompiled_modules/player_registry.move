module 0xddfc5c0a1aef30b0bf1f6125e0a9da7ffdbecffd94c80e4dc6036ca1efa4d96f::player_registry {
    struct Registry has key {
        id: 0x2::object::UID,
        next_player_id: u64,
    }

    struct PlayerInfo has store {
        id: u64,
        address: address,
        referrer_id: u64,
        registration_time: u64,
        referral_count: u64,
        total_deposit: u64,
        referral_rewards: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct AddressToId has copy, drop, store {
        address: address,
    }

    struct IdToAddress has copy, drop, store {
        id: u64,
    }

    struct ReferralRewardAdded has copy, drop {
        referrer: address,
        amount: u64,
        timestamp: u64,
    }

    public fun add_referral_reward(arg0: &mut Registry, arg1: address, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x2::clock::Clock) {
        assert!(0x2::dynamic_field::exists_<address>(&arg0.id, arg1), 0);
        0x2::balance::join<0x2::sui::SUI>(&mut 0x2::dynamic_field::borrow_mut<address, PlayerInfo>(&mut arg0.id, arg1).referral_rewards, 0x2::coin::into_balance<0x2::sui::SUI>(arg2));
        let v0 = ReferralRewardAdded{
            referrer  : arg1,
            amount    : 0x2::coin::value<0x2::sui::SUI>(&arg2),
            timestamp : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<ReferralRewardAdded>(v0);
    }

    public entry fun claim_referral_rewards(arg0: &mut Registry, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0x2::dynamic_field::exists_<address>(&arg0.id, v0), 0);
        let v1 = 0x2::dynamic_field::borrow_mut<address, PlayerInfo>(&mut arg0.id, v0);
        let v2 = 0x2::balance::value<0x2::sui::SUI>(&v1.referral_rewards);
        assert!(v2 > 0, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut v1.referral_rewards, v2), arg1), v0);
    }

    public fun get_player_address(arg0: &Registry, arg1: u64) : address {
        let v0 = IdToAddress{id: arg1};
        *0x2::dynamic_field::borrow<IdToAddress, address>(&arg0.id, v0)
    }

    public fun get_player_count(arg0: &Registry) : u64 {
        arg0.next_player_id - 1
    }

    public fun get_player_id(arg0: &Registry, arg1: address) : u64 {
        let v0 = AddressToId{address: arg1};
        *0x2::dynamic_field::borrow<AddressToId, u64>(&arg0.id, v0)
    }

    public fun get_player_info_full(arg0: &Registry, arg1: address) : (u64, address, u64, u64, u64, u64, u64) {
        let v0 = 0x2::dynamic_field::borrow<address, PlayerInfo>(&arg0.id, arg1);
        (v0.id, v0.address, v0.referrer_id, v0.registration_time, v0.referral_count, v0.total_deposit, 0x2::balance::value<0x2::sui::SUI>(&v0.referral_rewards))
    }

    public fun get_referral_balance(arg0: &Registry, arg1: address) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&0x2::dynamic_field::borrow<address, PlayerInfo>(&arg0.id, arg1).referral_rewards)
    }

    public fun get_referral_count(arg0: &Registry, arg1: address) : u64 {
        0x2::dynamic_field::borrow<address, PlayerInfo>(&arg0.id, arg1).referral_count
    }

    public fun get_referrer_id(arg0: &Registry, arg1: address) : u64 {
        0x2::dynamic_field::borrow<address, PlayerInfo>(&arg0.id, arg1).referrer_id
    }

    public fun get_total_deposit(arg0: &Registry, arg1: address) : u64 {
        0x2::dynamic_field::borrow<address, PlayerInfo>(&arg0.id, arg1).total_deposit
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Registry{
            id             : 0x2::object::new(arg0),
            next_player_id : 1,
        };
        0x2::transfer::share_object<Registry>(v0);
    }

    public fun is_player_registered(arg0: &Registry, arg1: address) : bool {
        let v0 = AddressToId{address: arg1};
        0x2::dynamic_field::exists_<AddressToId>(&arg0.id, v0)
    }

    public fun is_valid_referrer(arg0: &Registry, arg1: u64) : bool {
        verify_referrer(arg0, arg1)
    }

    public fun register_player(arg0: &mut Registry, arg1: address, arg2: u64, arg3: &0x2::clock::Clock) : u64 {
        if (!0x2::dynamic_field::exists_<address>(&arg0.id, arg1)) {
            let v1 = arg0.next_player_id;
            arg0.next_player_id = arg0.next_player_id + 1;
            let v2 = PlayerInfo{
                id                : v1,
                address           : arg1,
                referrer_id       : arg2,
                registration_time : 0x2::clock::timestamp_ms(arg3),
                referral_count    : 0,
                total_deposit     : 0,
                referral_rewards  : 0x2::balance::zero<0x2::sui::SUI>(),
            };
            let v3 = AddressToId{address: arg1};
            0x2::dynamic_field::add<AddressToId, u64>(&mut arg0.id, v3, v1);
            let v4 = IdToAddress{id: v1};
            0x2::dynamic_field::add<IdToAddress, address>(&mut arg0.id, v4, arg1);
            0x2::dynamic_field::add<address, PlayerInfo>(&mut arg0.id, arg1, v2);
            if (arg2 != 0 && verify_referrer(arg0, arg2)) {
                let v5 = get_player_address(arg0, arg2);
                if (v5 != arg1) {
                    update_referral_count(arg0, v5);
                };
            };
            v1
        } else {
            0x2::dynamic_field::borrow<address, PlayerInfo>(&arg0.id, arg1).id
        }
    }

    public fun update_deposit(arg0: &mut Registry, arg1: address, arg2: u64) {
        let v0 = 0x2::dynamic_field::borrow_mut<address, PlayerInfo>(&mut arg0.id, arg1);
        v0.total_deposit = v0.total_deposit + arg2;
    }

    public fun update_referral_count(arg0: &mut Registry, arg1: address) {
        if (0x2::dynamic_field::exists_<address>(&arg0.id, arg1)) {
            let v0 = 0x2::dynamic_field::borrow_mut<address, PlayerInfo>(&mut arg0.id, arg1);
            v0.referral_count = v0.referral_count + 1;
        };
    }

    public fun verify_referrer(arg0: &Registry, arg1: u64) : bool {
        let v0 = IdToAddress{id: arg1};
        0x2::dynamic_field::exists_<IdToAddress>(&arg0.id, v0)
    }

    // decompiled from Move bytecode v6
}

