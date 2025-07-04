module 0xd3a888a75b7335bc69ea04a310d34bf9e89aa2a2977f9f1de715ed0603f850a1::launchpad {
    struct Treasury<phantom T0> has key {
        id: 0x2::object::UID,
        lifeTreasury: 0x2::balance::Balance<T0>,
        suiCoinsTreasury: 0x2::balance::Balance<0x2::sui::SUI>,
        balanceOf: 0x2::vec_map::VecMap<address, u64>,
        historyBalanceOf: 0x2::vec_map::VecMap<address, u64>,
        status: bool,
        claimStatus: bool,
        totalDepositLife: u64,
        totalSoldLife: u64,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct Bought has copy, drop {
        user: address,
        amount: u64,
    }

    struct AdminDeposit has copy, drop {
        user: address,
        amount: u64,
    }

    struct AdminSuiWithdrawn has copy, drop {
        user: address,
        amount: u64,
    }

    struct AdminLifeWithdrawn has copy, drop {
        user: address,
        amount: u64,
    }

    struct AdminUpdateLaunchpad has copy, drop {
        user: address,
        status: bool,
    }

    struct AdminUpdateClaimStatusLaunchpad has copy, drop {
        user: address,
        claimStatus: bool,
    }

    public entry fun admin_deposit<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &mut Treasury<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg0);
        0x2::coin::put<T0>(&mut arg1.lifeTreasury, arg0);
        arg1.totalDepositLife = arg1.totalDepositLife + v0;
        let v1 = AdminDeposit{
            user   : 0x2::tx_context::sender(arg2),
            amount : v0,
        };
        0x2::event::emit<AdminDeposit>(v1);
    }

    public entry fun admin_withdraw<T0>(arg0: &mut Treasury<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.suiCoinsTreasury);
        let v1 = 0x2::balance::value<T0>(&arg0.lifeTreasury);
        assert!(@0xdd8c398bd6f1291b742b4d6ebb4a474e7926dac1ab91c2543c02fae4fe9113bc == 0x2::tx_context::sender(arg1), 11);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.suiCoinsTreasury, v0, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.lifeTreasury, v1, arg1), 0x2::tx_context::sender(arg1));
        let v2 = AdminSuiWithdrawn{
            user   : 0x2::tx_context::sender(arg1),
            amount : v0,
        };
        0x2::event::emit<AdminSuiWithdrawn>(v2);
        let v3 = AdminLifeWithdrawn{
            user   : 0x2::tx_context::sender(arg1),
            amount : v1,
        };
        0x2::event::emit<AdminLifeWithdrawn>(v3);
    }

    public entry fun buy<T0>(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut Treasury<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.status == true, 13);
        let v0 = 0x2::tx_context::sender(arg2);
        0x2::balance::value<0x2::sui::SUI>(&arg1.suiCoinsTreasury);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(v1 >= 1000000000, 14);
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.suiCoinsTreasury, 0x2::coin::into_balance<0x2::sui::SUI>(arg0));
        let v2 = v1 * 369;
        arg1.totalSoldLife = arg1.totalSoldLife + v2;
        let v3 = if (!0x2::vec_map::contains<address, u64>(&arg1.balanceOf, &v0)) {
            0x2::vec_map::insert<address, u64>(&mut arg1.balanceOf, v0, v2);
            0x2::vec_map::insert<address, u64>(&mut arg1.historyBalanceOf, v0, v1);
            v2
        } else {
            let v4 = 0x2::vec_map::get_mut<address, u64>(&mut arg1.balanceOf, &v0);
            *v4 = *v4 + v2;
            let v5 = 0x2::vec_map::get_mut<address, u64>(&mut arg1.historyBalanceOf, &v0);
            *v5 = *v5 + v1;
            *v4
        };
        assert!(v3 < 1000000000000000, 15);
        let v6 = Bought{
            user   : 0x2::tx_context::sender(arg2),
            amount : v1,
        };
        0x2::event::emit<Bought>(v6);
    }

    public entry fun claim<T0>(arg0: &mut Treasury<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.claimStatus == true, 12);
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = *0x2::vec_map::get_mut<address, u64>(&mut arg0.balanceOf, &v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.lifeTreasury, v1, arg1), 0x2::tx_context::sender(arg1));
        *0x2::vec_map::get_mut<address, u64>(&mut arg0.balanceOf, &v0) = 0;
        let v2 = Bought{
            user   : 0x2::tx_context::sender(arg1),
            amount : v1,
        };
        0x2::event::emit<Bought>(v2);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun new_launchpad<T0>(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Treasury<T0>{
            id               : 0x2::object::new(arg0),
            lifeTreasury     : 0x2::balance::zero<T0>(),
            suiCoinsTreasury : 0x2::balance::zero<0x2::sui::SUI>(),
            balanceOf        : 0x2::vec_map::empty<address, u64>(),
            historyBalanceOf : 0x2::vec_map::empty<address, u64>(),
            status           : true,
            claimStatus      : false,
            totalDepositLife : 0,
            totalSoldLife    : 0,
        };
        0x2::transfer::share_object<Treasury<T0>>(v0);
    }

    public entry fun update_claim_launchpad<T0>(arg0: &mut Treasury<T0>, arg1: bool, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(@0xdd8c398bd6f1291b742b4d6ebb4a474e7926dac1ab91c2543c02fae4fe9113bc == 0x2::tx_context::sender(arg2), 11);
        arg0.claimStatus = arg1;
        let v0 = AdminUpdateClaimStatusLaunchpad{
            user        : 0x2::tx_context::sender(arg2),
            claimStatus : arg1,
        };
        0x2::event::emit<AdminUpdateClaimStatusLaunchpad>(v0);
    }

    public entry fun update_launchpad<T0>(arg0: &mut Treasury<T0>, arg1: bool, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(@0xdd8c398bd6f1291b742b4d6ebb4a474e7926dac1ab91c2543c02fae4fe9113bc == 0x2::tx_context::sender(arg2), 11);
        arg0.status = arg1;
        let v0 = AdminUpdateLaunchpad{
            user   : 0x2::tx_context::sender(arg2),
            status : arg1,
        };
        0x2::event::emit<AdminUpdateLaunchpad>(v0);
    }

    // decompiled from Move bytecode v6
}

