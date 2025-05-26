module 0x5ad9249f064e2af09d4009934c2092173250425a7c8ea38479b57b00e6797be6::fish_claim {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct Treasury has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0x8ac52ffa85b65fd5022641e786a520f0b6ae4aa235ef57f3e2e2964fb57e8616::fisher_token::FISHER_TOKEN>,
    }

    struct ClaimData has key {
        id: 0x2::object::UID,
        user_address: address,
        amount: u64,
        selected_percent: u64,
        claimed: bool,
        request_time: u64,
    }

    public fun can_claim(arg0: &ClaimData, arg1: &0x2::tx_context::TxContext) : bool {
        if (arg0.claimed || arg0.selected_percent == 0) {
            return false
        };
        let v0 = if (arg0.selected_percent == 33) {
            0
        } else if (arg0.selected_percent == 66) {
            86400000
        } else {
            172800000
        };
        0x2::tx_context::epoch_timestamp_ms(arg1) >= arg0.request_time + v0
    }

    public fun claim(arg0: &mut ClaimData, arg1: &mut Treasury, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 == arg0.user_address, 1);
        assert!(!arg0.claimed, 2);
        assert!(arg0.selected_percent > 0, 6);
        let v1 = if (arg0.selected_percent == 33) {
            0
        } else if (arg0.selected_percent == 66) {
            86400000
        } else {
            172800000
        };
        assert!(0x2::tx_context::epoch_timestamp_ms(arg2) >= arg0.request_time + v1, 5);
        let v2 = arg0.amount * arg0.selected_percent / 100;
        assert!(0x2::balance::value<0x8ac52ffa85b65fd5022641e786a520f0b6ae4aa235ef57f3e2e2964fb57e8616::fisher_token::FISHER_TOKEN>(&arg1.balance) >= v2, 7);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x8ac52ffa85b65fd5022641e786a520f0b6ae4aa235ef57f3e2e2964fb57e8616::fisher_token::FISHER_TOKEN>>(0x2::coin::from_balance<0x8ac52ffa85b65fd5022641e786a520f0b6ae4aa235ef57f3e2e2964fb57e8616::fisher_token::FISHER_TOKEN>(0x2::balance::split<0x8ac52ffa85b65fd5022641e786a520f0b6ae4aa235ef57f3e2e2964fb57e8616::fisher_token::FISHER_TOKEN>(&mut arg1.balance, v2), arg2), v0);
        arg0.claimed = true;
    }

    public fun deposit_to_treasury(arg0: &AdminCap, arg1: &mut Treasury, arg2: u64, arg3: &mut 0x2::coin::Coin<0x8ac52ffa85b65fd5022641e786a520f0b6ae4aa235ef57f3e2e2964fb57e8616::fisher_token::FISHER_TOKEN>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x8ac52ffa85b65fd5022641e786a520f0b6ae4aa235ef57f3e2e2964fb57e8616::fisher_token::FISHER_TOKEN>(arg3) >= arg2, 7);
        0x2::balance::join<0x8ac52ffa85b65fd5022641e786a520f0b6ae4aa235ef57f3e2e2964fb57e8616::fisher_token::FISHER_TOKEN>(&mut arg1.balance, 0x2::coin::into_balance<0x8ac52ffa85b65fd5022641e786a520f0b6ae4aa235ef57f3e2e2964fb57e8616::fisher_token::FISHER_TOKEN>(0x2::coin::split<0x8ac52ffa85b65fd5022641e786a520f0b6ae4aa235ef57f3e2e2964fb57e8616::fisher_token::FISHER_TOKEN>(arg3, arg2, arg4)));
    }

    public fun get_request_time(arg0: &ClaimData) : u64 {
        arg0.request_time
    }

    public fun get_selected_percent(arg0: &ClaimData) : u64 {
        arg0.selected_percent
    }

    public fun get_treasury_balance(arg0: &Treasury) : u64 {
        0x2::balance::value<0x8ac52ffa85b65fd5022641e786a520f0b6ae4aa235ef57f3e2e2964fb57e8616::fisher_token::FISHER_TOKEN>(&arg0.balance)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Treasury{
            id      : 0x2::object::new(arg0),
            balance : 0x2::balance::zero<0x8ac52ffa85b65fd5022641e786a520f0b6ae4aa235ef57f3e2e2964fb57e8616::fisher_token::FISHER_TOKEN>(),
        };
        0x2::transfer::share_object<Treasury>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun init_claims(arg0: &AdminCap, arg1: address, arg2: u64, arg3: &Treasury, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 > 0, 4);
        assert!(0x2::balance::value<0x8ac52ffa85b65fd5022641e786a520f0b6ae4aa235ef57f3e2e2964fb57e8616::fisher_token::FISHER_TOKEN>(&arg3.balance) >= arg2, 7);
        let v0 = ClaimData{
            id               : 0x2::object::new(arg4),
            user_address     : arg1,
            amount           : arg2,
            selected_percent : 0,
            claimed          : false,
            request_time     : 0,
        };
        0x2::transfer::transfer<ClaimData>(v0, arg1);
    }

    public fun is_claimed(arg0: &ClaimData) : bool {
        arg0.claimed
    }

    public fun request_claim(arg0: &mut ClaimData, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.user_address, 1);
        assert!(!arg0.claimed, 2);
        let v0 = if (arg1 == 33) {
            true
        } else if (arg1 == 66) {
            true
        } else {
            arg1 == 100
        };
        assert!(v0, 3);
        arg0.selected_percent = arg1;
        arg0.request_time = 0x2::tx_context::epoch_timestamp_ms(arg2);
    }

    public fun withdraw_from_treasury(arg0: &AdminCap, arg1: &mut Treasury, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x8ac52ffa85b65fd5022641e786a520f0b6ae4aa235ef57f3e2e2964fb57e8616::fisher_token::FISHER_TOKEN> {
        0x2::coin::from_balance<0x8ac52ffa85b65fd5022641e786a520f0b6ae4aa235ef57f3e2e2964fb57e8616::fisher_token::FISHER_TOKEN>(0x2::balance::split<0x8ac52ffa85b65fd5022641e786a520f0b6ae4aa235ef57f3e2e2964fb57e8616::fisher_token::FISHER_TOKEN>(&mut arg1.balance, arg2), arg3)
    }

    // decompiled from Move bytecode v6
}

