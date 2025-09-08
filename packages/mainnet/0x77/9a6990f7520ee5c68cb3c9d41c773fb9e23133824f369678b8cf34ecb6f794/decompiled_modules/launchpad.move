module 0x779a6990f7520ee5c68cb3c9d41c773fb9e23133824f369678b8cf34ecb6f794::launchpad {
    struct Treasury<phantom T0> has key {
        id: 0x2::object::UID,
        soccerTreasury: 0x2::balance::Balance<T0>,
        suiCoinsTreasury: 0x2::balance::Balance<0x2::sui::SUI>,
        soccer_balance: 0x2::vec_map::VecMap<address, u64>,
        sui_deposited: 0x2::vec_map::VecMap<address, u64>,
        status: bool,
        claimStatus: bool,
        totalDepositSoccer: u64,
        totalSoldSoccer: u64,
        totalClaimedSoccer: u64,
        max_soccer_for_sale: u64,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct Bought has copy, drop {
        user: address,
        sui_amount: u64,
        soccer_amount: u64,
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

    struct AdminSoccerWithdrawn has copy, drop {
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
        0x2::coin::put<T0>(&mut arg2.soccerTreasury, arg1);
        arg2.totalDepositSoccer = arg2.totalDepositSoccer + v0;
        let v1 = AdminDeposit{
            user   : 0x2::tx_context::sender(arg3),
            amount : v0,
        };
        0x2::event::emit<AdminDeposit>(v1);
    }

    public entry fun admin_withdraw_excess_soccer<T0>(arg0: &AdminCap, arg1: &mut Treasury<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(!arg1.status, 19);
        let v0 = 0x2::balance::value<T0>(&arg1.soccerTreasury);
        let v1 = arg1.totalSoldSoccer - arg1.totalClaimedSoccer;
        assert!(v0 >= v1, 20);
        let v2 = v0 - v1;
        if (v2 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg1.soccerTreasury, v2, arg2), 0x2::tx_context::sender(arg2));
            let v3 = AdminSoccerWithdrawn{
                user   : 0x2::tx_context::sender(arg2),
                amount : v2,
            };
            0x2::event::emit<AdminSoccerWithdrawn>(v3);
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
        let v2 = v1 * 13889;
        assert!(arg1.totalSoldSoccer + v2 <= arg1.max_soccer_for_sale, 16);
        let v3 = if (!0x2::vec_map::contains<address, u64>(&arg1.soccer_balance, &v0)) {
            0x2::vec_map::insert<address, u64>(&mut arg1.soccer_balance, v0, v2);
            0x2::vec_map::insert<address, u64>(&mut arg1.sui_deposited, v0, v1);
            v2
        } else {
            let v4 = 0x2::vec_map::get_mut<address, u64>(&mut arg1.soccer_balance, &v0);
            *v4 = *v4 + v2;
            let v5 = 0x2::vec_map::get_mut<address, u64>(&mut arg1.sui_deposited, &v0);
            *v5 = *v5 + v1;
            *v4
        };
        assert!(v3 < 100000000000000000, 15);
        arg1.totalSoldSoccer = arg1.totalSoldSoccer + v2;
        let v6 = Bought{
            user          : v0,
            sui_amount    : v1,
            soccer_amount : v2,
        };
        0x2::event::emit<Bought>(v6);
    }

    public entry fun claim<T0>(arg0: &mut Treasury<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.claimStatus == true, 12);
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = *0x2::vec_map::get<address, u64>(&arg0.soccer_balance, &v0);
        assert!(v1 > 0, 17);
        assert!(0x2::balance::value<T0>(&arg0.soccerTreasury) >= v1, 18);
        *0x2::vec_map::get_mut<address, u64>(&mut arg0.soccer_balance, &v0) = 0;
        arg0.totalClaimedSoccer = arg0.totalClaimedSoccer + v1;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.soccerTreasury, v1, arg1), v0);
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
            id                  : 0x2::object::new(arg2),
            soccerTreasury      : 0x2::balance::zero<T0>(),
            suiCoinsTreasury    : 0x2::balance::zero<0x2::sui::SUI>(),
            soccer_balance      : 0x2::vec_map::empty<address, u64>(),
            sui_deposited       : 0x2::vec_map::empty<address, u64>(),
            status              : true,
            claimStatus         : false,
            totalDepositSoccer  : 0,
            totalSoldSoccer     : 0,
            totalClaimedSoccer  : 0,
            max_soccer_for_sale : arg1,
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

