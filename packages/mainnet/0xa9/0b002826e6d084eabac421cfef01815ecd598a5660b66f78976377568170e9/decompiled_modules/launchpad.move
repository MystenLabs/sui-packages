module 0xa90b002826e6d084eabac421cfef01815ecd598a5660b66f78976377568170e9::launchpad {
    struct Treasury<phantom T0> has key {
        id: 0x2::object::UID,
        vitalTreasury: 0x2::balance::Balance<T0>,
        suiCoinsTreasury: 0x2::balance::Balance<0x2::sui::SUI>,
        balanceOf: 0x2::vec_map::VecMap<address, u64>,
        historyBalanceOf: 0x2::vec_map::VecMap<address, u64>,
        status: bool,
        claimStatus: bool,
        price: u64,
        totalDepositVital: u64,
        totalSoldVital: u64,
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

    struct AdminVitalWithdrawn has copy, drop {
        user: address,
        amount: u64,
    }

    struct AdminUpdateLaunchpad has copy, drop {
        user: address,
        status: bool,
    }

    struct AdminUpdatePriceLaunchpad has copy, drop {
        user: address,
        price: u64,
    }

    struct AdminUpdateClaimStatusLaunchpad has copy, drop {
        user: address,
        claimStatus: bool,
    }

    public entry fun admin_airdrop<T0>(arg0: &mut Treasury<T0>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(@0xd2c32ad35f66254537a08ba185a142aa84e16a92dc20370c2d21a106dc57d9de == 0x2::tx_context::sender(arg3), 11);
        let v0 = arg2 / 1000000000 * arg0.price;
        arg0.totalSoldVital = arg0.totalSoldVital + v0;
        if (!0x2::vec_map::contains<address, u64>(&arg0.balanceOf, &arg1)) {
            0x2::vec_map::insert<address, u64>(&mut arg0.balanceOf, arg1, v0);
            0x2::vec_map::insert<address, u64>(&mut arg0.historyBalanceOf, arg1, arg2);
        } else {
            let v1 = 0x2::vec_map::get_mut<address, u64>(&mut arg0.balanceOf, &arg1);
            *v1 = *v1 + v0;
            let v2 = 0x2::vec_map::get_mut<address, u64>(&mut arg0.historyBalanceOf, &arg1);
            *v2 = *v2 + arg2;
        };
    }

    public entry fun admin_deposit<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &mut Treasury<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg0);
        0x2::coin::put<T0>(&mut arg1.vitalTreasury, arg0);
        arg1.totalDepositVital = arg1.totalDepositVital + v0;
        let v1 = AdminDeposit{
            user   : 0x2::tx_context::sender(arg2),
            amount : v0,
        };
        0x2::event::emit<AdminDeposit>(v1);
    }

    public entry fun admin_withdraw<T0>(arg0: &mut Treasury<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.suiCoinsTreasury);
        let v1 = 0x2::balance::value<T0>(&arg0.vitalTreasury);
        assert!(@0xd2c32ad35f66254537a08ba185a142aa84e16a92dc20370c2d21a106dc57d9de == 0x2::tx_context::sender(arg1), 11);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.suiCoinsTreasury, v0, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.vitalTreasury, v1, arg1), 0x2::tx_context::sender(arg1));
        let v2 = AdminSuiWithdrawn{
            user   : 0x2::tx_context::sender(arg1),
            amount : v0,
        };
        0x2::event::emit<AdminSuiWithdrawn>(v2);
        let v3 = AdminVitalWithdrawn{
            user   : 0x2::tx_context::sender(arg1),
            amount : v1,
        };
        0x2::event::emit<AdminVitalWithdrawn>(v3);
    }

    public entry fun buy<T0>(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut Treasury<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.status == true, 13);
        let v0 = 0x2::tx_context::sender(arg2);
        0x2::balance::value<0x2::sui::SUI>(&arg1.suiCoinsTreasury);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(v1 >= 10000000000, 14);
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.suiCoinsTreasury, 0x2::coin::into_balance<0x2::sui::SUI>(arg0));
        let v2 = v1 / 1000000000 * arg1.price;
        arg1.totalSoldVital = arg1.totalSoldVital + v2;
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
        assert!(v3 < 5000000000000000, 15);
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
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.vitalTreasury, v1, arg1), 0x2::tx_context::sender(arg1));
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
            id                : 0x2::object::new(arg0),
            vitalTreasury     : 0x2::balance::zero<T0>(),
            suiCoinsTreasury  : 0x2::balance::zero<0x2::sui::SUI>(),
            balanceOf         : 0x2::vec_map::empty<address, u64>(),
            historyBalanceOf  : 0x2::vec_map::empty<address, u64>(),
            status            : true,
            claimStatus       : false,
            price             : 10000,
            totalDepositVital : 0,
            totalSoldVital    : 0,
        };
        0x2::transfer::share_object<Treasury<T0>>(v0);
    }

    public entry fun update_claim_launchpad<T0>(arg0: &mut Treasury<T0>, arg1: bool, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(@0xd2c32ad35f66254537a08ba185a142aa84e16a92dc20370c2d21a106dc57d9de == 0x2::tx_context::sender(arg2), 11);
        arg0.claimStatus = arg1;
        let v0 = AdminUpdateClaimStatusLaunchpad{
            user        : 0x2::tx_context::sender(arg2),
            claimStatus : arg1,
        };
        0x2::event::emit<AdminUpdateClaimStatusLaunchpad>(v0);
    }

    public entry fun update_launchpad<T0>(arg0: &mut Treasury<T0>, arg1: bool, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(@0xd2c32ad35f66254537a08ba185a142aa84e16a92dc20370c2d21a106dc57d9de == 0x2::tx_context::sender(arg2), 11);
        arg0.status = arg1;
        let v0 = AdminUpdateLaunchpad{
            user   : 0x2::tx_context::sender(arg2),
            status : arg1,
        };
        0x2::event::emit<AdminUpdateLaunchpad>(v0);
    }

    public entry fun update_price_launchpad<T0>(arg0: &mut Treasury<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(@0xd2c32ad35f66254537a08ba185a142aa84e16a92dc20370c2d21a106dc57d9de == 0x2::tx_context::sender(arg2), 11);
        arg0.price = arg1;
        let v0 = AdminUpdatePriceLaunchpad{
            user  : 0x2::tx_context::sender(arg2),
            price : arg1,
        };
        0x2::event::emit<AdminUpdatePriceLaunchpad>(v0);
    }

    // decompiled from Move bytecode v6
}

