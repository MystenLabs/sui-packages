module 0x3e29df454c0a711f0423a98b4a83df74d23c3a59ec016adedd02585922e15012::saving {
    struct InterestConfig has store {
        saving_rate: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::Double,
        last_emitted: u64,
    }

    struct Position<phantom T0> has store {
        balance: 0x2::balance::Balance<T0>,
        last_update_timestamp: u64,
    }

    struct SavingPool<phantom T0> has key {
        id: 0x2::object::UID,
        lp_supply: 0x2::balance::Supply<T0>,
        deposit_cap_amount: 0x1::option::Option<u64>,
        usdb_reserve_balance: 0x2::balance::Balance<0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB>,
        positions: 0x2::table::Table<address, Position<T0>>,
        saving_config: InterestConfig,
        deposit_response_checklist: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
        withdraw_response_checklist: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
        position_locker: 0x2::vec_set::VecSet<address>,
    }

    struct DepositResponse<phantom T0> {
        account_address: address,
        deposited_usdb_amount: u64,
        minted_lp_amount: u64,
        prev_lp_balance: u64,
        prev_last_update_timestamp: u64,
        witnesses: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
    }

    struct WithdrawResponse<phantom T0> {
        account_address: address,
        burned_lp_amount: u64,
        prev_lp_balance: u64,
        prev_last_update_timestamp: u64,
        withdrawal_usdb_amount: u64,
        witnesses: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
    }

    public fun new<T0>(arg0: &0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::admin::AdminCap, arg1: 0x2::coin::TreasuryCap<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg2);
        0x3e29df454c0a711f0423a98b4a83df74d23c3a59ec016adedd02585922e15012::events::emit_new_saving_pool_event<T0>(0x2::object::uid_to_inner(&v0));
        let v1 = InterestConfig{
            saving_rate  : 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::from_bps(0),
            last_emitted : 0,
        };
        let v2 = SavingPool<T0>{
            id                          : v0,
            lp_supply                   : 0x2::coin::treasury_into_supply<T0>(arg1),
            deposit_cap_amount          : 0x1::option::none<u64>(),
            usdb_reserve_balance        : 0x2::balance::zero<0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB>(),
            positions                   : 0x2::table::new<address, Position<T0>>(arg2),
            saving_config               : v1,
            deposit_response_checklist  : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
            withdraw_response_checklist : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
            position_locker             : 0x2::vec_set::empty<address>(),
        };
        0x2::transfer::share_object<SavingPool<T0>>(v2);
    }

    public fun add_deposit_response_check<T0, T1: drop>(arg0: &mut SavingPool<T0>, arg1: &0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::admin::AdminCap) {
        let v0 = 0x1::type_name::get<T1>();
        if (!0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.deposit_response_checklist, &v0)) {
            0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg0.deposit_response_checklist, v0);
        };
    }

    public fun add_deposit_witness<T0, T1: drop>(arg0: &mut DepositResponse<T0>, arg1: T1) {
        let v0 = 0x1::type_name::get<T1>();
        if (0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.witnesses, &v0)) {
            err_witness_already_exists();
        };
        0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg0.witnesses, v0);
    }

    public fun add_withdraw_response_check<T0, T1: drop>(arg0: &mut SavingPool<T0>, arg1: &0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::admin::AdminCap) {
        let v0 = 0x1::type_name::get<T1>();
        if (!0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.withdraw_response_checklist, &v0)) {
            0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg0.withdraw_response_checklist, v0);
        };
    }

    public fun add_withdraw_witness<T0, T1: drop>(arg0: &mut WithdrawResponse<T0>, arg1: T1) {
        let v0 = 0x1::type_name::get<T1>();
        if (0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.witnesses, &v0)) {
            err_witness_already_exists();
        };
        0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg0.witnesses, v0);
    }

    fun assert_deposit_cap<T0>(arg0: &SavingPool<T0>, arg1: &0x2::clock::Clock) {
        if (0x1::option::is_some<u64>(&arg0.deposit_cap_amount) && total_reserve<T0>(arg0, arg1) > *0x1::option::borrow<u64>(&arg0.deposit_cap_amount)) {
            err_exceed_deposit_cap();
        };
    }

    public fun calculate_lp_mint_amount<T0>(arg0: &SavingPool<T0>, arg1: u64, arg2: &0x2::clock::Clock) : u64 {
        let v0 = lp_supply<T0>(arg0);
        if (v0 == 0) {
            arg1
        } else {
            0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::floor(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::div_u64(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::mul_u64(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::from(arg1), v0), total_reserve<T0>(arg0, arg2)))
        }
    }

    public fun check_deposit_response<T0>(arg0: DepositResponse<T0>, arg1: &mut SavingPool<T0>, arg2: &0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::Treasury) {
        0x3e29df454c0a711f0423a98b4a83df74d23c3a59ec016adedd02585922e15012::version::assert_valid_package(arg2);
        let DepositResponse {
            account_address            : v0,
            deposited_usdb_amount      : _,
            minted_lp_amount           : _,
            prev_lp_balance            : _,
            prev_last_update_timestamp : _,
            witnesses                  : v5,
        } = arg0;
        let v6 = v5;
        let v7 = v0;
        let v8 = 0x2::vec_set::keys<0x1::type_name::TypeName>(&arg1.deposit_response_checklist);
        let v9 = 0;
        let v10;
        while (v9 < 0x1::vector::length<0x1::type_name::TypeName>(v8)) {
            if (!0x2::vec_set::contains<0x1::type_name::TypeName>(&v6, 0x1::vector::borrow<0x1::type_name::TypeName>(v8, v9))) {
                v10 = false;
                /* label 6 */
                if (!v10) {
                    err_missing_deposit_response_witness();
                };
                0x2::vec_set::remove<address>(&mut arg1.position_locker, &v7);
                return
            };
            v9 = v9 + 1;
        };
        v10 = true;
        /* goto 6 */
    }

    public fun check_withdraw_response<T0>(arg0: WithdrawResponse<T0>, arg1: &mut SavingPool<T0>, arg2: &0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::Treasury) {
        0x3e29df454c0a711f0423a98b4a83df74d23c3a59ec016adedd02585922e15012::version::assert_valid_package(arg2);
        let WithdrawResponse {
            account_address            : v0,
            burned_lp_amount           : _,
            prev_lp_balance            : _,
            prev_last_update_timestamp : _,
            withdrawal_usdb_amount     : _,
            witnesses                  : v5,
        } = arg0;
        let v6 = v5;
        let v7 = v0;
        let v8 = 0x2::vec_set::keys<0x1::type_name::TypeName>(&arg1.withdraw_response_checklist);
        let v9 = 0;
        let v10;
        while (v9 < 0x1::vector::length<0x1::type_name::TypeName>(v8)) {
            if (!0x2::vec_set::contains<0x1::type_name::TypeName>(&v6, 0x1::vector::borrow<0x1::type_name::TypeName>(v8, v9))) {
                v10 = false;
                /* label 6 */
                if (!v10) {
                    err_missing_withdraw_response_witness();
                };
                0x2::vec_set::remove<address>(&mut arg1.position_locker, &v7);
                return
            };
            v9 = v9 + 1;
        };
        v10 = true;
        /* goto 6 */
    }

    public fun deposit<T0>(arg0: &mut SavingPool<T0>, arg1: &mut 0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::Treasury, arg2: address, arg3: 0x2::coin::Coin<0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : DepositResponse<T0> {
        0x3e29df454c0a711f0423a98b4a83df74d23c3a59ec016adedd02585922e15012::version::assert_valid_package(arg1);
        distribute_interest<T0>(arg0, arg1, arg4, arg5);
        let v0 = 0x2::coin::value<0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB>(&arg3);
        let v1 = deposit_<T0>(arg0, 0x2::coin::into_balance<0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB>(arg3));
        assert_deposit_cap<T0>(arg0, arg4);
        let v2 = 0x2::balance::value<T0>(&v1);
        let (v3, v4) = if (0x2::table::contains<address, Position<T0>>(&arg0.positions, arg2)) {
            0x2::balance::join<T0>(&mut 0x2::table::borrow_mut<address, Position<T0>>(&mut arg0.positions, arg2).balance, v1);
            (0x2::balance::value<T0>(&0x2::table::borrow<address, Position<T0>>(&arg0.positions, arg2).balance), 0x2::table::borrow<address, Position<T0>>(&arg0.positions, arg2).last_update_timestamp)
        } else {
            let v5 = Position<T0>{
                balance               : v1,
                last_update_timestamp : 0x2::clock::timestamp_ms(arg4),
            };
            0x2::table::add<address, Position<T0>>(&mut arg0.positions, arg2, v5);
            (0, 0)
        };
        0x3e29df454c0a711f0423a98b4a83df74d23c3a59ec016adedd02585922e15012::events::emit_deposit_event<T0>(0x2::object::id<SavingPool<T0>>(arg0), arg2, v0, v2);
        if (0x2::vec_set::contains<address>(&arg0.position_locker, &arg2)) {
            err_locked_account();
        };
        0x2::vec_set::insert<address>(&mut arg0.position_locker, arg2);
        DepositResponse<T0>{
            account_address            : arg2,
            deposited_usdb_amount      : v0,
            minted_lp_amount           : v2,
            prev_lp_balance            : v3,
            prev_last_update_timestamp : v4,
            witnesses                  : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
        }
    }

    fun deposit_<T0>(arg0: &mut SavingPool<T0>, arg1: 0x2::balance::Balance<0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB>) : 0x2::balance::Balance<T0> {
        let v0 = lp_supply<T0>(arg0);
        let v1 = if (v0 == 0) {
            0x2::balance::value<0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB>(&arg1)
        } else {
            0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::floor(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::div_u64(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::mul_u64(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::from(0x2::balance::value<0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB>(&arg1)), v0), usdb_reserve<T0>(arg0)))
        };
        0x2::balance::join<0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB>(&mut arg0.usdb_reserve_balance, arg1);
        if (v1 == 0) {
            err_insufficient_deposit();
        };
        0x2::balance::increase_supply<T0>(&mut arg0.lp_supply, v1)
    }

    public fun deposit_cap_amount<T0>(arg0: &SavingPool<T0>) : 0x1::option::Option<u64> {
        arg0.deposit_cap_amount
    }

    public fun deposit_response_account<T0>(arg0: &DepositResponse<T0>) : address {
        arg0.account_address
    }

    public fun deposit_response_checklist<T0>(arg0: &SavingPool<T0>) : &0x2::vec_set::VecSet<0x1::type_name::TypeName> {
        &arg0.deposit_response_checklist
    }

    public fun deposit_response_deposited_usdb_amount<T0>(arg0: &DepositResponse<T0>) : u64 {
        arg0.deposited_usdb_amount
    }

    public fun deposit_response_minted_lp_amount<T0>(arg0: &DepositResponse<T0>) : u64 {
        arg0.minted_lp_amount
    }

    public fun deposit_response_prev_last_update_timestamp<T0>(arg0: &DepositResponse<T0>) : u64 {
        arg0.prev_last_update_timestamp
    }

    public fun deposit_response_prev_lp_balance<T0>(arg0: &DepositResponse<T0>) : u64 {
        arg0.prev_lp_balance
    }

    fun distribute_interest<T0>(arg0: &mut SavingPool<T0>, arg1: &mut 0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::Treasury, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        if (0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::to_scaled_val(saving_rate<T0>(arg0)) == 0) {
            arg0.saving_config.last_emitted = 0x2::clock::timestamp_ms(arg2);
        };
        0x2::balance::join<0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB>(&mut arg0.usdb_reserve_balance, 0x2::coin::into_balance<0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB>(0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::mint<0x3e29df454c0a711f0423a98b4a83df74d23c3a59ec016adedd02585922e15012::witness::BucketV2Saving>(arg1, 0x3e29df454c0a711f0423a98b4a83df74d23c3a59ec016adedd02585922e15012::witness::witness(), 0x3e29df454c0a711f0423a98b4a83df74d23c3a59ec016adedd02585922e15012::version::package_version(), 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::floor(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::div_u64(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::mul_u64(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::mul(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::from(0x2::clock::timestamp_ms(arg2) - last_emitted<T0>(arg0)), arg0.saving_config.saving_rate), usdb_reserve<T0>(arg0)), 31449600000)), arg3)));
        arg0.saving_config.last_emitted = 0x2::clock::timestamp_ms(arg2);
    }

    fun err_account_not_found() {
        abort 104
    }

    fun err_exceed_deposit_cap() {
        abort 105
    }

    fun err_insufficient_deposit() {
        abort 104
    }

    fun err_locked_account() {
        abort 106
    }

    fun err_missing_deposit_response_witness() {
        abort 101
    }

    fun err_missing_withdraw_response_witness() {
        abort 102
    }

    fun err_witness_already_exists() {
        abort 103
    }

    public fun last_emitted<T0>(arg0: &SavingPool<T0>) : u64 {
        arg0.saving_config.last_emitted
    }

    public fun last_update<T0>(arg0: &SavingPool<T0>, arg1: address) : u64 {
        if (position_exists<T0>(arg0, arg1)) {
            0x2::table::borrow<address, Position<T0>>(&arg0.positions, arg1).last_update_timestamp
        } else {
            0
        }
    }

    public fun lp_balance_of<T0>(arg0: &SavingPool<T0>, arg1: address) : u64 {
        if (position_exists<T0>(arg0, arg1)) {
            0x2::balance::value<T0>(&0x2::table::borrow<address, Position<T0>>(&arg0.positions, arg1).balance)
        } else {
            0
        }
    }

    public fun lp_supply<T0>(arg0: &SavingPool<T0>) : u64 {
        0x2::balance::supply_value<T0>(&arg0.lp_supply)
    }

    public fun lp_token_ratio<T0>(arg0: &SavingPool<T0>, arg1: &0x2::clock::Clock) : 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::Double {
        if (lp_supply<T0>(arg0) == 0) {
            return 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::from(1)
        };
        0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::from_fraction(total_reserve<T0>(arg0, arg1), lp_supply<T0>(arg0))
    }

    public fun lp_token_value<T0>(arg0: &SavingPool<T0>, arg1: u64, arg2: &0x2::clock::Clock) : u64 {
        if (lp_supply<T0>(arg0) == 0) {
            return 0
        };
        0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::floor(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::div_u64(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::mul_u64(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::from(arg1), total_reserve<T0>(arg0, arg2)), lp_supply<T0>(arg0)))
    }

    public fun lp_token_value_of<T0>(arg0: &SavingPool<T0>, arg1: address, arg2: &0x2::clock::Clock) : u64 {
        lp_token_value<T0>(arg0, lp_balance_of<T0>(arg0, arg1), arg2)
    }

    public fun ms_in_year() : u64 {
        31449600000
    }

    public fun pending_interest<T0>(arg0: &SavingPool<T0>, arg1: &0x2::clock::Clock) : u64 {
        if (0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::to_scaled_val(saving_rate<T0>(arg0)) == 0) {
            return 0
        };
        0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::floor(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::div_u64(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::mul_u64(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::mul(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::from(0x2::clock::timestamp_ms(arg1) - last_emitted<T0>(arg0)), arg0.saving_config.saving_rate), usdb_reserve<T0>(arg0)), 31449600000))
    }

    public fun position_exists<T0>(arg0: &SavingPool<T0>, arg1: address) : bool {
        0x2::table::contains<address, Position<T0>>(&arg0.positions, arg1)
    }

    public fun position_locker<T0>(arg0: &SavingPool<T0>) : 0x2::vec_set::VecSet<address> {
        arg0.position_locker
    }

    public fun remove_deposit_response_check<T0, T1: drop>(arg0: &mut SavingPool<T0>, arg1: &0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::admin::AdminCap) {
        let v0 = 0x1::type_name::get<T1>();
        if (0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.deposit_response_checklist, &v0)) {
            0x2::vec_set::remove<0x1::type_name::TypeName>(&mut arg0.deposit_response_checklist, &v0);
        };
    }

    public fun remove_withdraw_response_check<T0, T1: drop>(arg0: &mut SavingPool<T0>, arg1: &0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::admin::AdminCap) {
        let v0 = 0x1::type_name::get<T1>();
        if (0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.withdraw_response_checklist, &v0)) {
            0x2::vec_set::remove<0x1::type_name::TypeName>(&mut arg0.withdraw_response_checklist, &v0);
        };
    }

    public fun saving_rate<T0>(arg0: &SavingPool<T0>) : 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::Double {
        arg0.saving_config.saving_rate
    }

    public fun total_reserve<T0>(arg0: &SavingPool<T0>, arg1: &0x2::clock::Clock) : u64 {
        usdb_reserve<T0>(arg0) + pending_interest<T0>(arg0, arg1)
    }

    public fun update_deposit_cap<T0>(arg0: &mut SavingPool<T0>, arg1: &0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::admin::AdminCap, arg2: 0x1::option::Option<u64>) {
        arg0.deposit_cap_amount = arg2;
    }

    public fun update_saving_rate<T0>(arg0: &mut SavingPool<T0>, arg1: &0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::admin::AdminCap, arg2: &mut 0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::Treasury, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x3e29df454c0a711f0423a98b4a83df74d23c3a59ec016adedd02585922e15012::version::assert_valid_package(arg2);
        distribute_interest<T0>(arg0, arg2, arg4, arg5);
        arg0.saving_config.saving_rate = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::from_bps(arg3);
        0x3e29df454c0a711f0423a98b4a83df74d23c3a59ec016adedd02585922e15012::events::emit_update_saving_rate_event<T0>(0x2::object::id<SavingPool<T0>>(arg0), arg3);
    }

    public fun usdb_reserve<T0>(arg0: &SavingPool<T0>) : u64 {
        0x2::balance::value<0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB>(&arg0.usdb_reserve_balance)
    }

    public fun withdraw<T0>(arg0: &mut SavingPool<T0>, arg1: &mut 0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::Treasury, arg2: &0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::AccountRequest, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB>, WithdrawResponse<T0>) {
        let v0 = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::request_address(arg2);
        if (!0x2::table::contains<address, Position<T0>>(&arg0.positions, v0)) {
            err_account_not_found();
        };
        distribute_interest<T0>(arg0, arg1, arg4, arg5);
        let v1 = 0x2::balance::value<T0>(&0x2::table::borrow<address, Position<T0>>(&arg0.positions, v0).balance);
        let v2 = 0x2::table::borrow<address, Position<T0>>(&arg0.positions, v0).last_update_timestamp;
        let v3 = 0x2::balance::split<T0>(&mut 0x2::table::borrow_mut<address, Position<T0>>(&mut arg0.positions, v0).balance, arg3);
        if (0x2::balance::value<T0>(&0x2::table::borrow<address, Position<T0>>(&arg0.positions, v0).balance) == 0) {
            let Position {
                balance               : v4,
                last_update_timestamp : _,
            } = 0x2::table::remove<address, Position<T0>>(&mut arg0.positions, v0);
            0x2::balance::destroy_zero<T0>(v4);
        };
        let v6 = withdraw_<T0>(arg0, v3);
        let v7 = 0x2::coin::from_balance<0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB>(v6, arg5);
        0x3e29df454c0a711f0423a98b4a83df74d23c3a59ec016adedd02585922e15012::events::emit_withdraw_event<T0>(0x2::object::id<SavingPool<T0>>(arg0), v0, arg3, 0x2::coin::value<0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB>(&v7));
        if (0x2::vec_set::contains<address>(&arg0.position_locker, &v0)) {
            err_locked_account();
        };
        0x2::vec_set::insert<address>(&mut arg0.position_locker, v0);
        let v8 = WithdrawResponse<T0>{
            account_address            : v0,
            burned_lp_amount           : arg3,
            prev_lp_balance            : v1,
            prev_last_update_timestamp : v2,
            withdrawal_usdb_amount     : 0x2::coin::value<0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB>(&v7),
            witnesses                  : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
        };
        (v7, v8)
    }

    fun withdraw_<T0>(arg0: &mut SavingPool<T0>, arg1: 0x2::balance::Balance<T0>) : 0x2::balance::Balance<0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB> {
        0x2::balance::decrease_supply<T0>(&mut arg0.lp_supply, arg1);
        0x2::balance::split<0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB>(&mut arg0.usdb_reserve_balance, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::floor(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::div_u64(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::mul_u64(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::from(0x2::balance::value<T0>(&arg1)), usdb_reserve<T0>(arg0)), lp_supply<T0>(arg0))))
    }

    public fun withdraw_response_account<T0>(arg0: &WithdrawResponse<T0>) : address {
        arg0.account_address
    }

    public fun withdraw_response_burned_lp_amount<T0>(arg0: &WithdrawResponse<T0>) : u64 {
        arg0.burned_lp_amount
    }

    public fun withdraw_response_checklist<T0>(arg0: &SavingPool<T0>) : &0x2::vec_set::VecSet<0x1::type_name::TypeName> {
        &arg0.withdraw_response_checklist
    }

    public fun withdraw_response_prev_last_update_timestamp<T0>(arg0: &WithdrawResponse<T0>) : u64 {
        arg0.prev_last_update_timestamp
    }

    public fun withdraw_response_prev_lp_balance<T0>(arg0: &WithdrawResponse<T0>) : u64 {
        arg0.prev_lp_balance
    }

    public fun withdraw_response_withdrawal_usdb_amount<T0>(arg0: &WithdrawResponse<T0>) : u64 {
        arg0.withdrawal_usdb_amount
    }

    // decompiled from Move bytecode v6
}

