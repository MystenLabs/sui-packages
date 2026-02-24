module 0xdee97301ff475f0134d3220c89cef6eddd0ca9f158c0a7473e9245f8e702d8f4::farming_entry {
    public entry fun add_banker(arg0: &mut 0xdee97301ff475f0134d3220c89cef6eddd0ca9f158c0a7473e9245f8e702d8f4::farming_core::Farming, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0xdee97301ff475f0134d3220c89cef6eddd0ca9f158c0a7473e9245f8e702d8f4::farming_core::add_banker(arg0, arg1, arg2);
    }

    public entry fun add_minor(arg0: &mut 0xdee97301ff475f0134d3220c89cef6eddd0ca9f158c0a7473e9245f8e702d8f4::farming_core::Farming, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0xdee97301ff475f0134d3220c89cef6eddd0ca9f158c0a7473e9245f8e702d8f4::farming_core::add_minor(arg0, arg1, arg2);
    }

    public entry fun add_operator(arg0: &mut 0xdee97301ff475f0134d3220c89cef6eddd0ca9f158c0a7473e9245f8e702d8f4::farming_core::Farming, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0xdee97301ff475f0134d3220c89cef6eddd0ca9f158c0a7473e9245f8e702d8f4::farming_core::add_operator(arg0, arg1, arg2);
    }

    public entry fun add_reward_config<T0, T1>(arg0: &0xdee97301ff475f0134d3220c89cef6eddd0ca9f158c0a7473e9245f8e702d8f4::farming_core::Farming, arg1: &mut 0xdee97301ff475f0134d3220c89cef6eddd0ca9f158c0a7473e9245f8e702d8f4::farming_core::Pool<T0>, arg2: u64, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : address {
        0xdee97301ff475f0134d3220c89cef6eddd0ca9f158c0a7473e9245f8e702d8f4::farming_core::add_reward_config<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6)
    }

    public entry fun claim<T0, T1>(arg0: &mut 0xdee97301ff475f0134d3220c89cef6eddd0ca9f158c0a7473e9245f8e702d8f4::farming_core::Farming, arg1: &mut 0xdee97301ff475f0134d3220c89cef6eddd0ca9f158c0a7473e9245f8e702d8f4::farming_core::Pool<T0>, arg2: &mut 0xdee97301ff475f0134d3220c89cef6eddd0ca9f158c0a7473e9245f8e702d8f4::farming_core::RewardBank<T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xdee97301ff475f0134d3220c89cef6eddd0ca9f158c0a7473e9245f8e702d8f4::farming_core::claim<T0, T1>(arg0, arg1, arg2, arg3, arg4);
        if (0x1::option::is_some<0x2::coin::Coin<T1>>(&v0)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x1::option::extract<0x2::coin::Coin<T1>>(&mut v0), 0x2::tx_context::sender(arg4));
        };
        0x1::option::destroy_none<0x2::coin::Coin<T1>>(v0);
    }

    public entry fun create_lend_pool<T0, T1>(arg0: &mut 0xdee97301ff475f0134d3220c89cef6eddd0ca9f158c0a7473e9245f8e702d8f4::farming_core::Farming, arg1: &0xdee97301ff475f0134d3220c89cef6eddd0ca9f158c0a7473e9245f8e702d8f4::market::Hearn, arg2: &0xdee97301ff475f0134d3220c89cef6eddd0ca9f158c0a7473e9245f8e702d8f4::meta_vault_core::Vault<T0, T1>, arg3: &mut 0x2::tx_context::TxContext) : address {
        0xdee97301ff475f0134d3220c89cef6eddd0ca9f158c0a7473e9245f8e702d8f4::farming_core::create_lend_pool<T0, T1>(arg0, arg1, arg2, arg3)
    }

    public entry fun del_banker(arg0: &mut 0xdee97301ff475f0134d3220c89cef6eddd0ca9f158c0a7473e9245f8e702d8f4::farming_core::Farming, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0xdee97301ff475f0134d3220c89cef6eddd0ca9f158c0a7473e9245f8e702d8f4::farming_core::del_banker(arg0, arg1, arg2);
    }

    public entry fun del_minor(arg0: &mut 0xdee97301ff475f0134d3220c89cef6eddd0ca9f158c0a7473e9245f8e702d8f4::farming_core::Farming, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0xdee97301ff475f0134d3220c89cef6eddd0ca9f158c0a7473e9245f8e702d8f4::farming_core::del_minor(arg0, arg1, arg2);
    }

    public entry fun del_operator(arg0: &mut 0xdee97301ff475f0134d3220c89cef6eddd0ca9f158c0a7473e9245f8e702d8f4::farming_core::Farming, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0xdee97301ff475f0134d3220c89cef6eddd0ca9f158c0a7473e9245f8e702d8f4::farming_core::del_operator(arg0, arg1, arg2);
    }

    public entry fun extract_reward_bank<T0, T1>(arg0: &0xdee97301ff475f0134d3220c89cef6eddd0ca9f158c0a7473e9245f8e702d8f4::farming_core::Farming, arg1: &mut 0xdee97301ff475f0134d3220c89cef6eddd0ca9f158c0a7473e9245f8e702d8f4::farming_core::Pool<T0>, arg2: &mut 0xdee97301ff475f0134d3220c89cef6eddd0ca9f158c0a7473e9245f8e702d8f4::farming_core::RewardBank<T1>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0xdee97301ff475f0134d3220c89cef6eddd0ca9f158c0a7473e9245f8e702d8f4::farming_core::extract_reward_bank<T0, T1>(arg0, arg1, arg2, arg3, arg4), 0x2::tx_context::sender(arg4));
    }

    public entry fun fund_reward_bank<T0, T1>(arg0: &0xdee97301ff475f0134d3220c89cef6eddd0ca9f158c0a7473e9245f8e702d8f4::farming_core::Farming, arg1: &mut 0xdee97301ff475f0134d3220c89cef6eddd0ca9f158c0a7473e9245f8e702d8f4::farming_core::Pool<T0>, arg2: &mut 0xdee97301ff475f0134d3220c89cef6eddd0ca9f158c0a7473e9245f8e702d8f4::farming_core::RewardBank<T1>, arg3: 0x2::coin::Coin<T1>, arg4: &mut 0x2::tx_context::TxContext) {
        0xdee97301ff475f0134d3220c89cef6eddd0ca9f158c0a7473e9245f8e702d8f4::farming_core::fund_reward_bank<T0, T1>(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun migrate(arg0: &mut 0xdee97301ff475f0134d3220c89cef6eddd0ca9f158c0a7473e9245f8e702d8f4::farming_core::Farming, arg1: &mut 0x2::tx_context::TxContext) {
        0xdee97301ff475f0134d3220c89cef6eddd0ca9f158c0a7473e9245f8e702d8f4::farming_core::migrate(arg0, arg1);
    }

    public entry fun set_boost<T0>(arg0: &0xdee97301ff475f0134d3220c89cef6eddd0ca9f158c0a7473e9245f8e702d8f4::farming_core::Farming, arg1: &mut 0xdee97301ff475f0134d3220c89cef6eddd0ca9f158c0a7473e9245f8e702d8f4::farming_core::Pool<T0>, arg2: address, arg3: u128, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0xdee97301ff475f0134d3220c89cef6eddd0ca9f158c0a7473e9245f8e702d8f4::farming_core::set_boost<T0>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun set_reward_config<T0, T1>(arg0: &0xdee97301ff475f0134d3220c89cef6eddd0ca9f158c0a7473e9245f8e702d8f4::farming_core::Farming, arg1: &mut 0xdee97301ff475f0134d3220c89cef6eddd0ca9f158c0a7473e9245f8e702d8f4::farming_core::Pool<T0>, arg2: u64, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0xdee97301ff475f0134d3220c89cef6eddd0ca9f158c0a7473e9245f8e702d8f4::farming_core::set_reward_config<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public entry fun stake<T0>(arg0: &mut 0xdee97301ff475f0134d3220c89cef6eddd0ca9f158c0a7473e9245f8e702d8f4::farming_core::Farming, arg1: &mut 0xdee97301ff475f0134d3220c89cef6eddd0ca9f158c0a7473e9245f8e702d8f4::farming_core::Pool<T0>, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xdee97301ff475f0134d3220c89cef6eddd0ca9f158c0a7473e9245f8e702d8f4::farming_core::stake<T0>(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun unstake<T0>(arg0: &mut 0xdee97301ff475f0134d3220c89cef6eddd0ca9f158c0a7473e9245f8e702d8f4::farming_core::Farming, arg1: &mut 0xdee97301ff475f0134d3220c89cef6eddd0ca9f158c0a7473e9245f8e702d8f4::farming_core::Pool<T0>, arg2: u128, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0xdee97301ff475f0134d3220c89cef6eddd0ca9f158c0a7473e9245f8e702d8f4::farming_core::unstake<T0>(arg0, arg1, arg2, arg3, arg4), 0x2::tx_context::sender(arg4));
    }

    public entry fun pause_pool<T0>(arg0: &0xdee97301ff475f0134d3220c89cef6eddd0ca9f158c0a7473e9245f8e702d8f4::farming_core::Farming, arg1: &mut 0xdee97301ff475f0134d3220c89cef6eddd0ca9f158c0a7473e9245f8e702d8f4::farming_core::Pool<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0xdee97301ff475f0134d3220c89cef6eddd0ca9f158c0a7473e9245f8e702d8f4::farming_core::pause<T0>(arg0, arg1, arg2, arg3);
    }

    public entry fun resume_pool<T0>(arg0: &0xdee97301ff475f0134d3220c89cef6eddd0ca9f158c0a7473e9245f8e702d8f4::farming_core::Farming, arg1: &mut 0xdee97301ff475f0134d3220c89cef6eddd0ca9f158c0a7473e9245f8e702d8f4::farming_core::Pool<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0xdee97301ff475f0134d3220c89cef6eddd0ca9f158c0a7473e9245f8e702d8f4::farming_core::resume<T0>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

