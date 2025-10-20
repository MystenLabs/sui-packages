module 0xa774cf0c683054615bde64f9da7df1b7a6ca69fc810aeb2232d6e46689eb2237::timelock_vault {
    struct Vault has store, key {
        id: 0x2::object::UID,
        balance: 0x2::coin::Coin<0x2::sui::SUI>,
        depositor: address,
        beneficiary: address,
        unlock_time_ms: u64,
    }

    public entry fun create_vault(arg0: &0x2::clock::Clock, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = Vault{
            id             : 0x2::object::new(arg4),
            balance        : arg1,
            depositor      : v0,
            beneficiary    : arg2,
            unlock_time_ms : 0x2::clock::timestamp_ms(arg0) + arg3,
        };
        0x2::transfer::public_transfer<Vault>(v1, v0);
    }

    public entry fun redeem_vault(arg0: Vault, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg1) >= arg0.unlock_time_ms, 1);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 == arg0.depositor || v0 == arg0.beneficiary, 2);
        let Vault {
            id             : v1,
            balance        : v2,
            depositor      : _,
            beneficiary    : _,
            unlock_time_ms : _,
        } = arg0;
        0x2::object::delete(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v2, v0);
    }

    // decompiled from Move bytecode v6
}

