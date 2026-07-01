module 0x1191ac127b43f1a76ce9e1b8c5a8f29c0900cbb34eae69045e81edec2511d609::llv_farming_entry {
    public entry fun add_farming_reward_config<T0, T1>(arg0: &0x1191ac127b43f1a76ce9e1b8c5a8f29c0900cbb34eae69045e81edec2511d609::llv_admin::LLVGlobal, arg1: &0xa6fcafa282e9a5ecd882bfe6177bec029bb0ebc639f1d54ad3199c2c8684fc3e::farming::Farming, arg2: &mut 0xa6fcafa282e9a5ecd882bfe6177bec029bb0ebc639f1d54ad3199c2c8684fc3e::farming::Pool<T0>, arg3: u64, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0x1191ac127b43f1a76ce9e1b8c5a8f29c0900cbb34eae69045e81edec2511d609::llv_admin::assert_version(arg0);
        0xa6fcafa282e9a5ecd882bfe6177bec029bb0ebc639f1d54ad3199c2c8684fc3e::farming::add_reward_config<T0, T1>(arg1, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    public entry fun claim_farming_reward<T0, T1>(arg0: &mut 0xa6fcafa282e9a5ecd882bfe6177bec029bb0ebc639f1d54ad3199c2c8684fc3e::farming::Farming, arg1: &mut 0xa6fcafa282e9a5ecd882bfe6177bec029bb0ebc639f1d54ad3199c2c8684fc3e::farming::Pool<T0>, arg2: &mut 0xa6fcafa282e9a5ecd882bfe6177bec029bb0ebc639f1d54ad3199c2c8684fc3e::farming::RewardBank<T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xa6fcafa282e9a5ecd882bfe6177bec029bb0ebc639f1d54ad3199c2c8684fc3e::farming::claim<T0, T1>(arg0, arg1, arg2, arg3, arg4);
        if (0x1::option::is_some<0x2::coin::Coin<T1>>(&v0)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x1::option::destroy_some<0x2::coin::Coin<T1>>(v0), 0x2::tx_context::sender(arg4));
        } else {
            0x1::option::destroy_none<0x2::coin::Coin<T1>>(v0);
        };
    }

    public entry fun create_llv_farming_pool<T0, T1>(arg0: &0x1191ac127b43f1a76ce9e1b8c5a8f29c0900cbb34eae69045e81edec2511d609::llv_admin::LLVGlobal, arg1: &0x1191ac127b43f1a76ce9e1b8c5a8f29c0900cbb34eae69045e81edec2511d609::llv_pool::LLVPool<T0, T1>, arg2: &mut 0xa6fcafa282e9a5ecd882bfe6177bec029bb0ebc639f1d54ad3199c2c8684fc3e::farming::Farming, arg3: &mut 0x2::tx_context::TxContext) {
        0x1191ac127b43f1a76ce9e1b8c5a8f29c0900cbb34eae69045e81edec2511d609::llv_admin::assert_version(arg0);
        0xa6fcafa282e9a5ecd882bfe6177bec029bb0ebc639f1d54ad3199c2c8684fc3e::farming::create_lend_pool<T1>(arg2, 0x2::object::id_address<0x1191ac127b43f1a76ce9e1b8c5a8f29c0900cbb34eae69045e81edec2511d609::llv_pool::LLVPool<T0, T1>>(arg1), arg3);
    }

    public entry fun fund_farming_reward_bank<T0, T1>(arg0: &0x1191ac127b43f1a76ce9e1b8c5a8f29c0900cbb34eae69045e81edec2511d609::llv_admin::LLVGlobal, arg1: &0xa6fcafa282e9a5ecd882bfe6177bec029bb0ebc639f1d54ad3199c2c8684fc3e::farming::Farming, arg2: &0xa6fcafa282e9a5ecd882bfe6177bec029bb0ebc639f1d54ad3199c2c8684fc3e::farming::Pool<T0>, arg3: &mut 0xa6fcafa282e9a5ecd882bfe6177bec029bb0ebc639f1d54ad3199c2c8684fc3e::farming::RewardBank<T1>, arg4: 0x2::coin::Coin<T1>, arg5: &mut 0x2::tx_context::TxContext) {
        0x1191ac127b43f1a76ce9e1b8c5a8f29c0900cbb34eae69045e81edec2511d609::llv_admin::assert_version(arg0);
        0xa6fcafa282e9a5ecd882bfe6177bec029bb0ebc639f1d54ad3199c2c8684fc3e::farming::fund_reward_bank<T0, T1>(arg1, arg2, arg3, arg4, arg5);
    }

    public fun get_claimable_rewards<T0>(arg0: &0xa6fcafa282e9a5ecd882bfe6177bec029bb0ebc639f1d54ad3199c2c8684fc3e::farming::Pool<T0>, arg1: address, arg2: &0x2::clock::Clock) : vector<0xa6fcafa282e9a5ecd882bfe6177bec029bb0ebc639f1d54ad3199c2c8684fc3e::farming::ClaimableReward> {
        0xa6fcafa282e9a5ecd882bfe6177bec029bb0ebc639f1d54ad3199c2c8684fc3e::farming::get_claimable_rewards<T0>(arg0, arg1, arg2)
    }

    public fun get_reward_bank_reserve<T0>(arg0: &0xa6fcafa282e9a5ecd882bfe6177bec029bb0ebc639f1d54ad3199c2c8684fc3e::farming::RewardBank<T0>) : u64 {
        0xa6fcafa282e9a5ecd882bfe6177bec029bb0ebc639f1d54ad3199c2c8684fc3e::farming::reward_bank_reserve<T0>(arg0)
    }

    public entry fun set_farming_boost<T0>(arg0: &0x1191ac127b43f1a76ce9e1b8c5a8f29c0900cbb34eae69045e81edec2511d609::llv_admin::LLVGlobal, arg1: &0xa6fcafa282e9a5ecd882bfe6177bec029bb0ebc639f1d54ad3199c2c8684fc3e::farming::Farming, arg2: &mut 0xa6fcafa282e9a5ecd882bfe6177bec029bb0ebc639f1d54ad3199c2c8684fc3e::farming::Pool<T0>, arg3: address, arg4: u128, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x1191ac127b43f1a76ce9e1b8c5a8f29c0900cbb34eae69045e81edec2511d609::llv_admin::assert_version(arg0);
        0xa6fcafa282e9a5ecd882bfe6177bec029bb0ebc639f1d54ad3199c2c8684fc3e::farming::set_boost<T0>(arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public entry fun set_farming_reward_config<T0, T1>(arg0: &0x1191ac127b43f1a76ce9e1b8c5a8f29c0900cbb34eae69045e81edec2511d609::llv_admin::LLVGlobal, arg1: &0xa6fcafa282e9a5ecd882bfe6177bec029bb0ebc639f1d54ad3199c2c8684fc3e::farming::Farming, arg2: &mut 0xa6fcafa282e9a5ecd882bfe6177bec029bb0ebc639f1d54ad3199c2c8684fc3e::farming::Pool<T0>, arg3: &0xa6fcafa282e9a5ecd882bfe6177bec029bb0ebc639f1d54ad3199c2c8684fc3e::farming::RewardBank<T1>, arg4: u64, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0x1191ac127b43f1a76ce9e1b8c5a8f29c0900cbb34eae69045e81edec2511d609::llv_admin::assert_version(arg0);
        0xa6fcafa282e9a5ecd882bfe6177bec029bb0ebc639f1d54ad3199c2c8684fc3e::farming::set_reward_config<T0, T1>(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
    }

    public entry fun stake_after_deposit<T0>(arg0: &mut 0xa6fcafa282e9a5ecd882bfe6177bec029bb0ebc639f1d54ad3199c2c8684fc3e::farming::Farming, arg1: &mut 0xa6fcafa282e9a5ecd882bfe6177bec029bb0ebc639f1d54ad3199c2c8684fc3e::farming::Pool<T0>, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xa6fcafa282e9a5ecd882bfe6177bec029bb0ebc639f1d54ad3199c2c8684fc3e::farming::stake<T0>(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun unstake_for_withdraw<T0>(arg0: &mut 0xa6fcafa282e9a5ecd882bfe6177bec029bb0ebc639f1d54ad3199c2c8684fc3e::farming::Farming, arg1: &mut 0xa6fcafa282e9a5ecd882bfe6177bec029bb0ebc639f1d54ad3199c2c8684fc3e::farming::Pool<T0>, arg2: u128, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0xa6fcafa282e9a5ecd882bfe6177bec029bb0ebc639f1d54ad3199c2c8684fc3e::farming::unstake<T0>(arg0, arg1, arg2, arg3, arg4), 0x2::tx_context::sender(arg4));
    }

    // decompiled from Move bytecode v7
}

