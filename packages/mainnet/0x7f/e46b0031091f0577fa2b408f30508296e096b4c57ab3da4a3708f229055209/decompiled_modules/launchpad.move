module 0x7fe46b0031091f0577fa2b408f30508296e096b4c57ab3da4a3708f229055209::launchpad {
    struct Treasury<phantom T0> has key {
        id: 0x2::object::UID,
        lifeTreasury: 0x2::balance::Balance<T0>,
        suiCoinsTreasury: 0x2::balance::Balance<0x2::sui::SUI>,
        life_balance: 0x2::vec_map::VecMap<address, u64>,
        sui_deposited: 0x2::vec_map::VecMap<address, u64>,
        status: bool,
        claimStatus: bool,
        totalDepositLife: u64,
        totalSoldLife: u64,
        totalClaimedLife: u64,
        max_life_for_sale: u64,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct Bought has copy, drop {
        user: address,
        sui_amount: u64,
        life_amount: u64,
    }

    struct Claimed has copy, drop {
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

    public entry fun admin_deposit<T0>(arg0: &AdminCap, arg1: 0x2::coin::Coin<T0>, arg2: &mut Treasury<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg1);
        0x2::coin::put<T0>(&mut arg2.lifeTreasury, arg1);
        arg2.totalDepositLife = arg2.totalDepositLife + v0;
        let v1 = AdminDeposit{
            user   : 0x2::tx_context::sender(arg3),
            amount : v0,
        };
        0x2::event::emit<AdminDeposit>(v1);
    }

    public entry fun admin_withdraw_excess_life<T0>(arg0: &AdminCap, arg1: &mut Treasury<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(!arg1.status, 19);
        let v0 = 0x2::balance::value<T0>(&arg1.lifeTreasury);
        let v1 = arg1.totalSoldLife - arg1.totalClaimedLife;
        assert!(v0 >= v1, 20);
        let v2 = v0 - v1;
        if (v2 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg1.lifeTreasury, v2, arg2), 0x2::tx_context::sender(arg2));
            let v3 = AdminLifeWithdrawn{
                user   : 0x2::tx_context::sender(arg2),
                amount : v2,
            };
            0x2::event::emit<AdminLifeWithdrawn>(v3);
        };
    }

    public entry fun admin_withdraw_sui<T0>(arg0: &AdminCap, arg1: &mut Treasury<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(!arg1.status, 19);
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg1.suiCoinsTreasury);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg1.suiCoinsTreasury, v0, arg2), 0x2::tx_context::sender(arg2));
        let v1 = AdminSuiWithdrawn{
            user   : 0x2::tx_context::sender(arg2),
            amount : v0,
        };
        0x2::event::emit<AdminSuiWithdrawn>(v1);
    }

    public entry fun buy<T0>(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut Treasury<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.status == true, 13);
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(v1 >= 1000000000, 14);
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.suiCoinsTreasury, 0x2::coin::into_balance<0x2::sui::SUI>(arg0));
        let v2 = v1 * 369;
        assert!(arg1.totalSoldLife + v2 <= arg1.max_life_for_sale, 16);
        let v3 = if (!0x2::vec_map::contains<address, u64>(&arg1.life_balance, &v0)) {
            0x2::vec_map::insert<address, u64>(&mut arg1.life_balance, v0, v2);
            0x2::vec_map::insert<address, u64>(&mut arg1.sui_deposited, v0, v1);
            v2
        } else {
            let v4 = 0x2::vec_map::get_mut<address, u64>(&mut arg1.life_balance, &v0);
            *v4 = *v4 + v2;
            let v5 = 0x2::vec_map::get_mut<address, u64>(&mut arg1.sui_deposited, &v0);
            *v5 = *v5 + v1;
            *v4
        };
        assert!(v3 < 1000000000000000, 15);
        arg1.totalSoldLife = arg1.totalSoldLife + v2;
        let v6 = Bought{
            user        : v0,
            sui_amount  : v1,
            life_amount : v2,
        };
        0x2::event::emit<Bought>(v6);
    }

    public entry fun claim<T0>(arg0: &mut Treasury<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.claimStatus == true, 12);
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = *0x2::vec_map::get<address, u64>(&arg0.life_balance, &v0);
        assert!(v1 > 0, 17);
        assert!(0x2::balance::value<T0>(&arg0.lifeTreasury) >= v1, 18);
        *0x2::vec_map::get_mut<address, u64>(&mut arg0.life_balance, &v0) = 0;
        arg0.totalClaimedLife = arg0.totalClaimedLife + v1;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.lifeTreasury, v1, arg1), v0);
        let v2 = Claimed{
            user   : v0,
            amount : v1,
        };
        0x2::event::emit<Claimed>(v2);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun new_launchpad<T0>(arg0: &AdminCap, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Treasury<T0>{
            id                : 0x2::object::new(arg2),
            lifeTreasury      : 0x2::balance::zero<T0>(),
            suiCoinsTreasury  : 0x2::balance::zero<0x2::sui::SUI>(),
            life_balance      : 0x2::vec_map::empty<address, u64>(),
            sui_deposited     : 0x2::vec_map::empty<address, u64>(),
            status            : true,
            claimStatus       : false,
            totalDepositLife  : 0,
            totalSoldLife     : 0,
            totalClaimedLife  : 0,
            max_life_for_sale : arg1,
        };
        0x2::transfer::share_object<Treasury<T0>>(v0);
    }

    public entry fun update_claim_launchpad<T0>(arg0: &AdminCap, arg1: &mut Treasury<T0>, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.claimStatus = arg2;
        let v0 = AdminUpdateClaimStatusLaunchpad{
            user        : 0x2::tx_context::sender(arg3),
            claimStatus : arg2,
        };
        0x2::event::emit<AdminUpdateClaimStatusLaunchpad>(v0);
    }

    public entry fun update_launchpad<T0>(arg0: &AdminCap, arg1: &mut Treasury<T0>, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.status = arg2;
        let v0 = AdminUpdateLaunchpad{
            user   : 0x2::tx_context::sender(arg3),
            status : arg2,
        };
        0x2::event::emit<AdminUpdateLaunchpad>(v0);
    }

    // decompiled from Move bytecode v6
}

