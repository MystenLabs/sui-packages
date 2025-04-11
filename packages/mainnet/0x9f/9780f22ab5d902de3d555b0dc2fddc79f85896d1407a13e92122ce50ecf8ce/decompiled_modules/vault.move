module 0x9f9780f22ab5d902de3d555b0dc2fddc79f85896d1407a13e92122ce50ecf8ce::vault {
    struct Vault has store {
        epoch: u64,
        collected_house_fees: 0x2::balance::Balance<0x2::sui::SUI>,
        collected_protocol_fees: 0x2::balance::Balance<0x2::sui::SUI>,
        collected_referral_fees: 0x2::vec_map::VecMap<0x2::object::ID, 0x2::balance::Balance<0x2::sui::SUI>>,
        play_balance: 0x2::balance::Balance<0x2::sui::SUI>,
        reserve_balance: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct PlayBalanceFundedEvent has copy, drop {
        amount: u64,
    }

    struct PlayBalanceClearedEvent has copy, drop {
        amount: u64,
    }

    public(friend) fun empty(arg0: &0x2::tx_context::TxContext) : Vault {
        Vault{
            epoch                   : 0x2::tx_context::epoch(arg0),
            collected_house_fees    : 0x2::balance::zero<0x2::sui::SUI>(),
            collected_protocol_fees : 0x2::balance::zero<0x2::sui::SUI>(),
            collected_referral_fees : 0x2::vec_map::empty<0x2::object::ID, 0x2::balance::Balance<0x2::sui::SUI>>(),
            play_balance            : 0x2::balance::zero<0x2::sui::SUI>(),
            reserve_balance         : 0x2::balance::zero<0x2::sui::SUI>(),
        }
    }

    public fun epoch(arg0: &Vault) : u64 {
        arg0.epoch
    }

    public fun collected_house_fees(arg0: &Vault) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.collected_house_fees)
    }

    public fun collected_protocol_fees(arg0: &Vault) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.collected_protocol_fees)
    }

    public fun collected_referral_fees(arg0: &Vault, arg1: 0x2::object::ID) : u64 {
        assert!(0x2::vec_map::contains<0x2::object::ID, 0x2::balance::Balance<0x2::sui::SUI>>(&arg0.collected_referral_fees, &arg1), 3);
        0x2::balance::value<0x2::sui::SUI>(0x2::vec_map::get<0x2::object::ID, 0x2::balance::Balance<0x2::sui::SUI>>(&arg0.collected_referral_fees, &arg1))
    }

    public(friend) fun deposit(arg0: &mut Vault, arg1: 0x2::balance::Balance<0x2::sui::SUI>) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.reserve_balance, arg1);
    }

    fun ensure_referral_fee_balance(arg0: &mut Vault, arg1: 0x2::object::ID) {
        if (!0x2::vec_map::contains<0x2::object::ID, 0x2::balance::Balance<0x2::sui::SUI>>(&arg0.collected_referral_fees, &arg1)) {
            0x2::vec_map::insert<0x2::object::ID, 0x2::balance::Balance<0x2::sui::SUI>>(&mut arg0.collected_referral_fees, arg1, 0x2::balance::zero<0x2::sui::SUI>());
        };
    }

    public(friend) fun fund_play_balance(arg0: &mut Vault, arg1: u64) {
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.reserve_balance) >= arg1, 1);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.play_balance, 0x2::balance::split<0x2::sui::SUI>(&mut arg0.reserve_balance, arg1));
        let v0 = PlayBalanceFundedEvent{amount: arg1};
        0x2::event::emit<PlayBalanceFundedEvent>(v0);
    }

    public fun play_balance(arg0: &Vault) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.play_balance)
    }

    public(friend) fun process_end_of_day(arg0: &mut Vault, arg1: &0x2::tx_context::TxContext) : (bool, u64, u64) {
        if (arg0.epoch == 0x2::tx_context::epoch(arg1)) {
            return (false, 0, 0)
        };
        let v0 = 0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.play_balance);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.reserve_balance, v0);
        arg0.epoch = 0x2::tx_context::epoch(arg1);
        let v1 = PlayBalanceClearedEvent{amount: 0x2::balance::value<0x2::sui::SUI>(&v0)};
        0x2::event::emit<PlayBalanceClearedEvent>(v1);
        (true, arg0.epoch, 0x2::balance::value<0x2::sui::SUI>(&arg0.play_balance))
    }

    public(friend) fun process_house_fee(arg0: &mut Vault, arg1: u64) {
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.play_balance) >= arg1, 1);
        if (arg1 > 0) {
            0x2::balance::join<0x2::sui::SUI>(&mut arg0.collected_house_fees, 0x2::balance::split<0x2::sui::SUI>(&mut arg0.play_balance, arg1));
        };
    }

    public(friend) fun process_protocol_fee(arg0: &mut Vault, arg1: u64) {
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.play_balance) >= arg1, 1);
        if (arg1 > 0) {
            0x2::balance::join<0x2::sui::SUI>(&mut arg0.collected_protocol_fees, 0x2::balance::split<0x2::sui::SUI>(&mut arg0.play_balance, arg1));
        };
    }

    public(friend) fun process_referral_fee(arg0: &mut Vault, arg1: 0x2::object::ID, arg2: u64) {
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.play_balance) >= arg2, 1);
        if (arg2 > 0) {
            ensure_referral_fee_balance(arg0, arg1);
            0x2::balance::join<0x2::sui::SUI>(0x2::vec_map::get_mut<0x2::object::ID, 0x2::balance::Balance<0x2::sui::SUI>>(&mut arg0.collected_referral_fees, &arg1), 0x2::balance::split<0x2::sui::SUI>(&mut arg0.play_balance, arg2));
        };
    }

    public fun reserve_balance(arg0: &Vault) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.reserve_balance)
    }

    public(friend) fun settle_balance_manager(arg0: &mut Vault, arg1: u64, arg2: u64, arg3: &mut 0x9f9780f22ab5d902de3d555b0dc2fddc79f85896d1407a13e92122ce50ecf8ce::balance_manager::BalanceManager, arg4: &0x9f9780f22ab5d902de3d555b0dc2fddc79f85896d1407a13e92122ce50ecf8ce::balance_manager::PlayProof) {
        0x9f9780f22ab5d902de3d555b0dc2fddc79f85896d1407a13e92122ce50ecf8ce::balance_manager::ensure_sufficient_funds(arg3, arg2);
        if (arg1 > arg2) {
            let v0 = if (0x2::balance::value<0x2::sui::SUI>(&arg0.play_balance) >= arg1 - arg2) {
                0x2::balance::split<0x2::sui::SUI>(&mut arg0.play_balance, arg1 - arg2)
            } else {
                assert!(arg1 - arg2 - 0x2::balance::value<0x2::sui::SUI>(&arg0.play_balance) <= 0x9f9780f22ab5d902de3d555b0dc2fddc79f85896d1407a13e92122ce50ecf8ce::constants::precision_error_allowance(), 1);
                0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.play_balance)
            };
            0x9f9780f22ab5d902de3d555b0dc2fddc79f85896d1407a13e92122ce50ecf8ce::balance_manager::deposit_with_proof(arg3, arg4, v0);
        } else if (arg2 > arg1) {
            0x2::balance::join<0x2::sui::SUI>(&mut arg0.play_balance, 0x9f9780f22ab5d902de3d555b0dc2fddc79f85896d1407a13e92122ce50ecf8ce::balance_manager::withdraw_with_proof(arg3, arg4, arg2 - arg1));
        };
    }

    public(friend) fun withdraw(arg0: &mut Vault, arg1: u64) : 0x2::balance::Balance<0x2::sui::SUI> {
        0x2::balance::split<0x2::sui::SUI>(&mut arg0.reserve_balance, arg1)
    }

    public(friend) fun withdraw_house_fees(arg0: &mut Vault) : 0x2::balance::Balance<0x2::sui::SUI> {
        0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.collected_house_fees)
    }

    public(friend) fun withdraw_protocol_fees(arg0: &mut Vault) : 0x2::balance::Balance<0x2::sui::SUI> {
        0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.collected_protocol_fees)
    }

    public(friend) fun withdraw_referral_fees(arg0: &mut Vault, arg1: 0x2::object::ID) : 0x2::balance::Balance<0x2::sui::SUI> {
        ensure_referral_fee_balance(arg0, arg1);
        0x2::balance::withdraw_all<0x2::sui::SUI>(0x2::vec_map::get_mut<0x2::object::ID, 0x2::balance::Balance<0x2::sui::SUI>>(&mut arg0.collected_referral_fees, &arg1))
    }

    // decompiled from Move bytecode v6
}

