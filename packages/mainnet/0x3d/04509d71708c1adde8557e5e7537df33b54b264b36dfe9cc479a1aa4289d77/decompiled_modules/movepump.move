module 0x3d04509d71708c1adde8557e5e7537df33b54b264b36dfe9cc479a1aa4289d77::movepump {
    struct SuiFeeCollectedEvent has copy, drop {
        amount: u64,
        order_id: 0x1::string::String,
    }

    public entry fun pay_fee_sui(arg0: &mut 0x3d04509d71708c1adde8557e5e7537df33b54b264b36dfe9cc479a1aa4289d77::fee::FeeObject, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) >= arg2, 2);
        0x2::balance::join<0x2::sui::SUI>(0x3d04509d71708c1adde8557e5e7537df33b54b264b36dfe9cc479a1aa4289d77::fee::get_mut_balance_sui(arg0), 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut arg1, arg2, arg4)));
        0x3d04509d71708c1adde8557e5e7537df33b54b264b36dfe9cc479a1aa4289d77::utils::send_coin<0x2::sui::SUI>(arg1, 0x2::tx_context::sender(arg4));
        let v0 = SuiFeeCollectedEvent{
            amount   : arg2,
            order_id : arg3,
        };
        0x2::event::emit<SuiFeeCollectedEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

