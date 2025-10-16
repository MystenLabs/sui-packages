module 0x2c3d6cc35c62c33d202f206938ffbba397695c63fa463d2cd58bf49a1a56f837::pool {
    struct Pool<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        reward_manager: RewardManager,
    }

    struct RewardManager has store {
        is_public: bool,
        vault: 0x2::bag::Bag,
        rewards: vector<Reward>,
        last_updated_time: u64,
        emergency_reward_pause: bool,
    }

    struct Reward has store {
        reward_coin: 0x1::type_name::TypeName,
        current_emission_rate: u128,
        reward_released: u256,
        reward_refunded: u128,
        reward_harvested: u128,
    }

    public fun add_reward<T0, T1, T2>(arg0: &mut Pool<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Reward{
            reward_coin           : 0x1::type_name::get<T2>(),
            current_emission_rate : 0,
            reward_released       : 0,
            reward_refunded       : 0,
            reward_harvested      : 0,
        };
        0x1::vector::push_back<Reward>(&mut arg0.reward_manager.rewards, v0);
    }

    public fun new_pool<T0, T1>(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg0);
        let v1 = Pool<T0, T1>{
            id             : v0,
            reward_manager : new_reward_manager(arg0),
        };
        0x2::transfer::share_object<Pool<T0, T1>>(v1);
    }

    public(friend) fun new_reward_manager(arg0: &mut 0x2::tx_context::TxContext) : RewardManager {
        RewardManager{
            is_public              : true,
            vault                  : 0x2::bag::new(arg0),
            rewards                : 0x1::vector::empty<Reward>(),
            last_updated_time      : 0,
            emergency_reward_pause : false,
        }
    }

    // decompiled from Move bytecode v6
}

