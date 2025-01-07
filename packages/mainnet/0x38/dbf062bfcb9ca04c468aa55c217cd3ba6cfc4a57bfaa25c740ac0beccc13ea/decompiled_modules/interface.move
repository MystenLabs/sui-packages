module 0x38dbf062bfcb9ca04c468aa55c217cd3ba6cfc4a57bfaa25c740ac0beccc13ea::interface {
    public entry fun burn_ipx(arg0: &mut 0x38dbf062bfcb9ca04c468aa55c217cd3ba6cfc4a57bfaa25c740ac0beccc13ea::sip::SIPStorage, arg1: 0x2::coin::Coin<0x38dbf062bfcb9ca04c468aa55c217cd3ba6cfc4a57bfaa25c740ac0beccc13ea::sip::SIP>) {
        0x38dbf062bfcb9ca04c468aa55c217cd3ba6cfc4a57bfaa25c740ac0beccc13ea::sip::burn(arg0, arg1);
    }

    fun get_farm<T0>(arg0: &0x38dbf062bfcb9ca04c468aa55c217cd3ba6cfc4a57bfaa25c740ac0beccc13ea::master_chef::MasterChefStorage, arg1: &0x38dbf062bfcb9ca04c468aa55c217cd3ba6cfc4a57bfaa25c740ac0beccc13ea::master_chef::AccountStorage, arg2: address, arg3: &mut vector<vector<u64>>) {
        let v0 = 0x1::vector::empty<u64>();
        let (v1, _, _, v4) = 0x38dbf062bfcb9ca04c468aa55c217cd3ba6cfc4a57bfaa25c740ac0beccc13ea::master_chef::get_pool_info<T0>(arg0);
        0x1::vector::push_back<u64>(&mut v0, v1);
        0x1::vector::push_back<u64>(&mut v0, v4);
        if (0x38dbf062bfcb9ca04c468aa55c217cd3ba6cfc4a57bfaa25c740ac0beccc13ea::master_chef::account_exists<T0>(arg0, arg1, arg2)) {
            let (v5, _) = 0x38dbf062bfcb9ca04c468aa55c217cd3ba6cfc4a57bfaa25c740ac0beccc13ea::master_chef::get_account_info(arg0, arg1, arg2);
            0x1::vector::push_back<u64>(&mut v0, v5);
        } else {
            0x1::vector::push_back<u64>(&mut v0, 0);
        };
        0x1::vector::push_back<vector<u64>>(arg3, v0);
    }

    public fun get_farms<T0, T1, T2, T3, T4>(arg0: &0x38dbf062bfcb9ca04c468aa55c217cd3ba6cfc4a57bfaa25c740ac0beccc13ea::master_chef::MasterChefStorage, arg1: &0x38dbf062bfcb9ca04c468aa55c217cd3ba6cfc4a57bfaa25c740ac0beccc13ea::master_chef::AccountStorage, arg2: address, arg3: u64) : vector<vector<u64>> {
        let v0 = 0x1::vector::empty<vector<u64>>();
        let v1 = &mut v0;
        get_farm<T0>(arg0, arg1, arg2, v1);
        if (arg3 == 1) {
            return v0
        };
        let v2 = &mut v0;
        get_farm<T1>(arg0, arg1, arg2, v2);
        if (arg3 == 2) {
            return v0
        };
        let v3 = &mut v0;
        get_farm<T2>(arg0, arg1, arg2, v3);
        if (arg3 == 3) {
            return v0
        };
        let v4 = &mut v0;
        get_farm<T3>(arg0, arg1, arg2, v4);
        if (arg3 == 4) {
            return v0
        };
        let v5 = &mut v0;
        get_farm<T4>(arg0, arg1, arg2, v5);
        if (arg3 == 5) {
            return v0
        };
        v0
    }

    public entry fun get_rewards<T0>(arg0: &mut 0x38dbf062bfcb9ca04c468aa55c217cd3ba6cfc4a57bfaa25c740ac0beccc13ea::master_chef::MasterChefStorage, arg1: &mut 0x38dbf062bfcb9ca04c468aa55c217cd3ba6cfc4a57bfaa25c740ac0beccc13ea::master_chef::AccountStorage, arg2: &mut 0x38dbf062bfcb9ca04c468aa55c217cd3ba6cfc4a57bfaa25c740ac0beccc13ea::sip::SIPStorage, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x38dbf062bfcb9ca04c468aa55c217cd3ba6cfc4a57bfaa25c740ac0beccc13ea::sip::SIP>>(0x38dbf062bfcb9ca04c468aa55c217cd3ba6cfc4a57bfaa25c740ac0beccc13ea::master_chef::get_rewards<T0>(arg0, arg1, arg2, arg3, arg4), 0x2::tx_context::sender(arg4));
    }

    public entry fun stake(arg0: &mut 0x38dbf062bfcb9ca04c468aa55c217cd3ba6cfc4a57bfaa25c740ac0beccc13ea::master_chef::MasterChefStorage, arg1: &mut 0x38dbf062bfcb9ca04c468aa55c217cd3ba6cfc4a57bfaa25c740ac0beccc13ea::master_chef::MasterChefBalanceStorage, arg2: &mut 0x38dbf062bfcb9ca04c468aa55c217cd3ba6cfc4a57bfaa25c740ac0beccc13ea::master_chef::AccountStorage, arg3: &mut 0x38dbf062bfcb9ca04c468aa55c217cd3ba6cfc4a57bfaa25c740ac0beccc13ea::sip::SIPStorage, arg4: address, arg5: &0x2::clock::Clock, arg6: 0x2::coin::Coin<0x2::sui::SUI>, arg7: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x38dbf062bfcb9ca04c468aa55c217cd3ba6cfc4a57bfaa25c740ac0beccc13ea::sip::SIP>>(0x38dbf062bfcb9ca04c468aa55c217cd3ba6cfc4a57bfaa25c740ac0beccc13ea::master_chef::stake(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7), 0x2::tx_context::sender(arg7));
    }

    public entry fun unstake(arg0: &mut 0x38dbf062bfcb9ca04c468aa55c217cd3ba6cfc4a57bfaa25c740ac0beccc13ea::master_chef::MasterChefStorage, arg1: &mut 0x38dbf062bfcb9ca04c468aa55c217cd3ba6cfc4a57bfaa25c740ac0beccc13ea::master_chef::MasterChefBalanceStorage, arg2: &mut 0x38dbf062bfcb9ca04c468aa55c217cd3ba6cfc4a57bfaa25c740ac0beccc13ea::master_chef::AccountStorage, arg3: &mut 0x38dbf062bfcb9ca04c468aa55c217cd3ba6cfc4a57bfaa25c740ac0beccc13ea::sip::SIPStorage, arg4: &0x2::clock::Clock, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        let (v1, v2) = 0x38dbf062bfcb9ca04c468aa55c217cd3ba6cfc4a57bfaa25c740ac0beccc13ea::master_chef::unstake(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x38dbf062bfcb9ca04c468aa55c217cd3ba6cfc4a57bfaa25c740ac0beccc13ea::sip::SIP>>(v1, v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v2, v0);
    }

    public entry fun update_all_pools(arg0: &mut 0x38dbf062bfcb9ca04c468aa55c217cd3ba6cfc4a57bfaa25c740ac0beccc13ea::master_chef::MasterChefStorage, arg1: &0x2::clock::Clock) {
        0x38dbf062bfcb9ca04c468aa55c217cd3ba6cfc4a57bfaa25c740ac0beccc13ea::master_chef::update_all_pools(arg0, arg1);
    }

    public entry fun update_pool<T0>(arg0: &mut 0x38dbf062bfcb9ca04c468aa55c217cd3ba6cfc4a57bfaa25c740ac0beccc13ea::master_chef::MasterChefStorage, arg1: &0x2::clock::Clock) {
        0x38dbf062bfcb9ca04c468aa55c217cd3ba6cfc4a57bfaa25c740ac0beccc13ea::master_chef::update_pool<T0>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

