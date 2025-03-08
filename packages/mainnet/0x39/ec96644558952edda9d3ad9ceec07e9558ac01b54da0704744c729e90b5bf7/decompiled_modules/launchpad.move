module 0x39ec96644558952edda9d3ad9ceec07e9558ac01b54da0704744c729e90b5bf7::launchpad {
    struct Treasury<phantom T0> has key {
        id: 0x2::object::UID,
        vramTreasury: 0x2::balance::Balance<T0>,
        suiCoinsTreasury: 0x2::balance::Balance<0x2::sui::SUI>,
        balanceOf: 0x2::vec_map::VecMap<address, u64>,
        historyBalanceOf: 0x2::vec_map::VecMap<address, u64>,
        status: bool,
        claimStatus: bool,
        suiPrice: u64,
        tokenPrice: u64,
        totalDepositVram: u64,
        totalSoldVram: u64,
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

    struct AdminVramWithdrawn has copy, drop {
        user: address,
        amount: u64,
    }

    struct AdminUpdateLaunchpad has copy, drop {
        user: address,
        status: bool,
    }

    struct AdminUpdatePriceLaunchpad has copy, drop {
        user: address,
        suiPrice: u64,
    }

    struct AdminUpdateTokenPriceLaunchpad has copy, drop {
        user: address,
        tokenPrice: u64,
    }

    struct AdminUpdateClaimStatusLaunchpad has copy, drop {
        user: address,
        claimStatus: bool,
    }

    public entry fun admin_deposit<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &mut Treasury<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg0);
        0x2::coin::put<T0>(&mut arg1.vramTreasury, arg0);
        arg1.totalDepositVram = arg1.totalDepositVram + v0;
        let v1 = AdminDeposit{
            user   : 0x2::tx_context::sender(arg2),
            amount : v0,
        };
        0x2::event::emit<AdminDeposit>(v1);
    }

    public entry fun admin_withdraw<T0>(arg0: &mut Treasury<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.suiCoinsTreasury);
        let v1 = 0x2::balance::value<T0>(&arg0.vramTreasury);
        assert!(@0xc2b1bd49d0d29cdad7e477f1743f8ecc87dcff274205d8d838b48302896ffe8 == 0x2::tx_context::sender(arg1), 11);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.suiCoinsTreasury, v0, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.vramTreasury, v1, arg1), 0x2::tx_context::sender(arg1));
        let v2 = AdminSuiWithdrawn{
            user   : 0x2::tx_context::sender(arg1),
            amount : v0,
        };
        0x2::event::emit<AdminSuiWithdrawn>(v2);
        let v3 = AdminVramWithdrawn{
            user   : 0x2::tx_context::sender(arg1),
            amount : v1,
        };
        0x2::event::emit<AdminVramWithdrawn>(v3);
    }

    public entry fun buy<T0>(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut Treasury<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.status == true, 13);
        let v0 = 0x2::tx_context::sender(arg2);
        0x2::balance::value<0x2::sui::SUI>(&arg1.suiCoinsTreasury);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.suiCoinsTreasury, 0x2::coin::into_balance<0x2::sui::SUI>(arg0));
        let v2 = v1 * arg1.suiPrice * 10000 / arg1.tokenPrice / 1000;
        arg1.totalSoldVram = arg1.totalSoldVram + v2;
        if (!0x2::vec_map::contains<address, u64>(&arg1.balanceOf, &v0)) {
            0x2::vec_map::insert<address, u64>(&mut arg1.balanceOf, v0, v2);
            0x2::vec_map::insert<address, u64>(&mut arg1.historyBalanceOf, v0, v1);
        } else {
            let v3 = 0x2::vec_map::get_mut<address, u64>(&mut arg1.balanceOf, &v0);
            *v3 = *v3 + v2;
            let v4 = 0x2::vec_map::get_mut<address, u64>(&mut arg1.historyBalanceOf, &v0);
            *v4 = *v4 + v1;
        };
        let v5 = Bought{
            user   : 0x2::tx_context::sender(arg2),
            amount : v1,
        };
        0x2::event::emit<Bought>(v5);
    }

    public entry fun claim<T0>(arg0: &mut Treasury<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.claimStatus == true, 12);
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = *0x2::vec_map::get_mut<address, u64>(&mut arg0.balanceOf, &v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.vramTreasury, v1, arg1), 0x2::tx_context::sender(arg1));
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
            vramTreasury     : 0x2::balance::zero<T0>(),
            suiCoinsTreasury : 0x2::balance::zero<0x2::sui::SUI>(),
            balanceOf        : 0x2::vec_map::empty<address, u64>(),
            historyBalanceOf : 0x2::vec_map::empty<address, u64>(),
            status           : true,
            claimStatus      : false,
            suiPrice         : 3200,
            tokenPrice       : 30,
            totalDepositVram : 0,
            totalSoldVram    : 0,
        };
        0x2::transfer::share_object<Treasury<T0>>(v0);
    }

    public entry fun update_claim_launchpad<T0>(arg0: &mut Treasury<T0>, arg1: bool, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(@0xc2b1bd49d0d29cdad7e477f1743f8ecc87dcff274205d8d838b48302896ffe8 == 0x2::tx_context::sender(arg2), 11);
        arg0.claimStatus = arg1;
        let v0 = AdminUpdateClaimStatusLaunchpad{
            user        : 0x2::tx_context::sender(arg2),
            claimStatus : arg1,
        };
        0x2::event::emit<AdminUpdateClaimStatusLaunchpad>(v0);
    }

    public entry fun update_launchpad<T0>(arg0: &mut Treasury<T0>, arg1: bool, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(@0xc2b1bd49d0d29cdad7e477f1743f8ecc87dcff274205d8d838b48302896ffe8 == 0x2::tx_context::sender(arg2), 11);
        arg0.status = arg1;
        let v0 = AdminUpdateLaunchpad{
            user   : 0x2::tx_context::sender(arg2),
            status : arg1,
        };
        0x2::event::emit<AdminUpdateLaunchpad>(v0);
    }

    public entry fun update_price_launchpad<T0>(arg0: &mut Treasury<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(@0xc2b1bd49d0d29cdad7e477f1743f8ecc87dcff274205d8d838b48302896ffe8 == 0x2::tx_context::sender(arg2), 11);
        arg0.suiPrice = arg1;
        let v0 = AdminUpdatePriceLaunchpad{
            user     : 0x2::tx_context::sender(arg2),
            suiPrice : arg1,
        };
        0x2::event::emit<AdminUpdatePriceLaunchpad>(v0);
    }

    public entry fun update_token_price_launchpad<T0>(arg0: &mut Treasury<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(@0xc2b1bd49d0d29cdad7e477f1743f8ecc87dcff274205d8d838b48302896ffe8 == 0x2::tx_context::sender(arg2), 11);
        arg0.tokenPrice = arg1;
        let v0 = AdminUpdateTokenPriceLaunchpad{
            user       : 0x2::tx_context::sender(arg2),
            tokenPrice : arg1,
        };
        0x2::event::emit<AdminUpdateTokenPriceLaunchpad>(v0);
    }

    // decompiled from Move bytecode v6
}

