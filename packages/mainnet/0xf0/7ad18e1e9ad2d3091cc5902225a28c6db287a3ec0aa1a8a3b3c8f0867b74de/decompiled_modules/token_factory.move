module 0xf07ad18e1e9ad2d3091cc5902225a28c6db287a3ec0aa1a8a3b3c8f0867b74de::token_factory {
    struct Factory has store, key {
        id: 0x2::object::UID,
        total_tokens_created: u64,
        service_fee: u64,
    }

    struct Treasury has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    public fun get_service_fee(arg0: &Factory) : u64 {
        arg0.service_fee
    }

    public fun get_total_tokens_created(arg0: &Factory) : u64 {
        arg0.total_tokens_created
    }

    public fun get_treasury_balance(arg0: &Treasury) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.balance)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Factory{
            id                   : 0x2::object::new(arg0),
            total_tokens_created : 0,
            service_fee          : 500000000,
        };
        0x2::transfer::share_object<Factory>(v0);
        let v1 = Treasury{
            id      : 0x2::object::new(arg0),
            balance : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::transfer::share_object<Treasury>(v1);
        let v2 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v2, 0x2::tx_context::sender(arg0));
    }

    entry fun pay_and_record(arg0: &mut Factory, arg1: &mut Treasury, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: u8, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) >= arg0.service_fee, 0);
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg2));
        if (0x2::balance::value<0x2::sui::SUI>(&arg1.balance) >= 5000000000) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.balance, 4900000000), arg9), @0x3bc44c92f693a7e02ac587b6c221abe3084285f47c271e0d13b4d4599b22788);
        };
        arg0.total_tokens_created = arg0.total_tokens_created + 1;
    }

    entry fun update_service_fee(arg0: &mut Factory, arg1: &AdminCap, arg2: u64) {
        arg0.service_fee = arg2;
    }

    public fun withdraw(arg0: &mut Treasury, arg1: &AdminCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.balance) >= arg2, 1);
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance, arg2), arg3)
    }

    entry fun withdraw_all_to_platform(arg0: &mut Treasury, arg1: &AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.balance);
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance, v0), arg2), @0x3bc44c92f693a7e02ac587b6c221abe3084285f47c271e0d13b4d4599b22788);
        };
    }

    entry fun withdraw_to_platform(arg0: &mut Treasury, arg1: &AdminCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(withdraw(arg0, arg1, arg2, arg3), @0x3bc44c92f693a7e02ac587b6c221abe3084285f47c271e0d13b4d4599b22788);
    }

    // decompiled from Move bytecode v6
}

