module 0x36d13715cfd1896a2756735423c903bcf25834455242f780b0539bb312c78bb5::gusd_usdc_vault {
    struct USDCVault has store, key {
        id: 0x2::object::UID,
        usdc_balance: 0x2::balance::Balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>,
        team_address: address,
        fee_rate: u64,
        admin: address,
        pending_admin: address,
    }

    struct MintEvent has copy, drop {
        user: address,
        amount: u64,
    }

    struct RedeemEvent has copy, drop {
        user: address,
        gusd_amount: u64,
        redeemed_usdc: u64,
        fee: u64,
    }

    struct AdminUpdatedEvent has copy, drop {
        old_admin: address,
        new_admin: address,
    }

    struct AdminProposedEvent has copy, drop {
        old_admin: address,
        proposed_admin: address,
    }

    struct TeamAddressUpdatedEvent has copy, drop {
        old_team_address: address,
        new_team_address: address,
    }

    struct FeeRateUpdatedEvent has copy, drop {
        old_fee_rate: u64,
        new_fee_rate: u64,
    }

    public fun accept_admin(arg0: &mut USDCVault, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(arg0.pending_admin == v0, 8);
        arg0.admin = v0;
        arg0.pending_admin = @0x0;
        let v1 = AdminUpdatedEvent{
            old_admin : arg0.admin,
            new_admin : v0,
        };
        0x2::event::emit<AdminUpdatedEvent>(v1);
    }

    public fun get_fee_rate(arg0: &USDCVault) : u64 {
        arg0.fee_rate
    }

    public fun get_team_address(arg0: &USDCVault) : address {
        arg0.team_address
    }

    public fun get_vault_balance(arg0: &USDCVault) : u64 {
        0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg0.usdc_balance)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = USDCVault{
            id            : 0x2::object::new(arg0),
            usdc_balance  : 0x2::balance::zero<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(),
            team_address  : 0x2::tx_context::sender(arg0),
            fee_rate      : 30,
            admin         : 0x2::tx_context::sender(arg0),
            pending_admin : @0x0,
        };
        0x2::transfer::share_object<USDCVault>(v0);
    }

    public fun mint_gusd(arg0: &0x36d13715cfd1896a2756735423c903bcf25834455242f780b0539bb312c78bb5::version::Version, arg1: &mut USDCVault, arg2: &mut 0x36d13715cfd1896a2756735423c903bcf25834455242f780b0539bb312c78bb5::market::Market, arg3: 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x36d13715cfd1896a2756735423c903bcf25834455242f780b0539bb312c78bb5::version::assert_current_version(arg0);
        assert!(!0x36d13715cfd1896a2756735423c903bcf25834455242f780b0539bb312c78bb5::market::is_paused(arg2), 9);
        let v0 = 0x2::coin::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg3);
        assert!(v0 > 0, 2);
        0x2::balance::join<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg1.usdc_balance, 0x2::coin::into_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg3));
        0x2::transfer::public_transfer<0x2::coin::Coin<0xde256d5bdc317176dd69e94d7a3f81453c5a56f4305df746407433c43d05f83b::coin_gusd::COIN_GUSD>>(0x36d13715cfd1896a2756735423c903bcf25834455242f780b0539bb312c78bb5::market::mint_gusd(arg2, v0, 0x2::clock::timestamp_ms(arg4) / 1000, arg5), 0x2::tx_context::sender(arg5));
        let v1 = MintEvent{
            user   : 0x2::tx_context::sender(arg5),
            amount : v0,
        };
        0x2::event::emit<MintEvent>(v1);
    }

    public fun propose_new_admin(arg0: &mut USDCVault, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 3);
        assert!(arg1 != @0x0, 7);
        arg0.pending_admin = arg1;
        let v0 = AdminProposedEvent{
            old_admin      : arg0.admin,
            proposed_admin : arg1,
        };
        0x2::event::emit<AdminProposedEvent>(v0);
    }

    public fun redeem_gusd(arg0: &0x36d13715cfd1896a2756735423c903bcf25834455242f780b0539bb312c78bb5::version::Version, arg1: &mut USDCVault, arg2: &mut 0x36d13715cfd1896a2756735423c903bcf25834455242f780b0539bb312c78bb5::market::Market, arg3: 0x2::coin::Coin<0xde256d5bdc317176dd69e94d7a3f81453c5a56f4305df746407433c43d05f83b::coin_gusd::COIN_GUSD>, arg4: &mut 0x2::tx_context::TxContext) {
        0x36d13715cfd1896a2756735423c903bcf25834455242f780b0539bb312c78bb5::version::assert_current_version(arg0);
        assert!(!0x36d13715cfd1896a2756735423c903bcf25834455242f780b0539bb312c78bb5::market::is_paused(arg2), 9);
        let v0 = 0x2::coin::value<0xde256d5bdc317176dd69e94d7a3f81453c5a56f4305df746407433c43d05f83b::coin_gusd::COIN_GUSD>(&arg3);
        assert!(v0 > 0, 2);
        assert!(0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg1.usdc_balance) >= v0, 1);
        let v1 = ((v0 as u128) * (arg1.fee_rate as u128) + 10000 - 1) / 10000;
        assert!(v1 <= 18446744073709551615, 5);
        let v2 = (v1 as u64);
        assert!(v2 < v0, 6);
        let v3 = v0 - v2;
        0x36d13715cfd1896a2756735423c903bcf25834455242f780b0539bb312c78bb5::market::burn_gusd(arg2, arg3, arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(0x2::coin::from_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(0x2::balance::split<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg1.usdc_balance, v3), arg4), 0x2::tx_context::sender(arg4));
        if (v2 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(0x2::coin::from_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(0x2::balance::split<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg1.usdc_balance, v2), arg4), arg1.team_address);
        };
        let v4 = RedeemEvent{
            user          : 0x2::tx_context::sender(arg4),
            gusd_amount   : v0,
            redeemed_usdc : v3,
            fee           : v2,
        };
        0x2::event::emit<RedeemEvent>(v4);
    }

    public fun update_fee_rate(arg0: &mut USDCVault, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 3);
        assert!(arg1 > 0, 4);
        assert!(arg1 < 1000, 4);
        arg0.fee_rate = arg1;
        let v0 = FeeRateUpdatedEvent{
            old_fee_rate : arg0.fee_rate,
            new_fee_rate : arg1,
        };
        0x2::event::emit<FeeRateUpdatedEvent>(v0);
    }

    public fun update_team_address(arg0: &mut USDCVault, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 3);
        assert!(arg1 != @0x0, 7);
        arg0.team_address = arg1;
        let v0 = TeamAddressUpdatedEvent{
            old_team_address : arg0.team_address,
            new_team_address : arg1,
        };
        0x2::event::emit<TeamAddressUpdatedEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

