module 0x67d4d6478241ea65f4d2a912e07bedec71597dd3542ef9a5899d1cf4ec55a35f::vesting {
    struct Treasury<phantom T0> has key {
        id: 0x2::object::UID,
        vitalTreasury: 0x2::balance::Balance<T0>,
        balanceOf: 0x2::vec_map::VecMap<address, u64>,
        totalDepositVital: u64,
        depositTimestamp: u64,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct AdminDeposit has copy, drop {
        user: address,
        amount: u64,
    }

    struct AdminVitalWithdrawn has copy, drop {
        user: address,
        amount: u64,
    }

    public entry fun admin_deposit<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &mut Treasury<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg0);
        0x2::coin::put<T0>(&mut arg1.vitalTreasury, arg0);
        arg1.totalDepositVital = arg1.totalDepositVital + v0;
        arg1.depositTimestamp = 0x2::clock::timestamp_ms(arg2);
        let v1 = AdminDeposit{
            user   : 0x2::tx_context::sender(arg3),
            amount : v0,
        };
        0x2::event::emit<AdminDeposit>(v1);
    }

    public entry fun admin_withdraw<T0>(arg0: &mut Treasury<T0>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(@0xd2c32ad35f66254537a08ba185a142aa84e16a92dc20370c2d21a106dc57d9de == 0x2::tx_context::sender(arg3), 11);
        assert!(0x2::clock::timestamp_ms(arg2) >= arg0.depositTimestamp + 7776000000, 13);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.vitalTreasury, arg1, arg3), 0x2::tx_context::sender(arg3));
        let v0 = AdminVitalWithdrawn{
            user   : 0x2::tx_context::sender(arg3),
            amount : arg1,
        };
        0x2::event::emit<AdminVitalWithdrawn>(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun new_vesting<T0>(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Treasury<T0>{
            id                : 0x2::object::new(arg0),
            vitalTreasury     : 0x2::balance::zero<T0>(),
            balanceOf         : 0x2::vec_map::empty<address, u64>(),
            totalDepositVital : 0,
            depositTimestamp  : 0,
        };
        0x2::transfer::share_object<Treasury<T0>>(v0);
    }

    // decompiled from Move bytecode v6
}

