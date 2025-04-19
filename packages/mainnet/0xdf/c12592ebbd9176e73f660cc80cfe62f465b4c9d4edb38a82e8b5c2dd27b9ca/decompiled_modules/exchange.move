module 0xdfc12592ebbd9176e73f660cc80cfe62f465b4c9d4edb38a82e8b5c2dd27b9ca::exchange {
    struct Exchange<phantom T0> has key {
        id: 0x2::object::UID,
        versions: 0x2::vec_set::VecSet<u64>,
        treasury_cap: 0x2::coin::TreasuryCap<T0>,
        supply_limit: u64,
        fee: Fee,
        sheet: 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::Sheet<GExchange, 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>,
        position: 0x1::option::Option<0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::StakeProof<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>>,
        whitelisted_debtors: 0x2::vec_set::VecSet<0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::Debtor>,
        owner: address,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct GExchange has drop {
        dummy_field: bool,
    }

    struct Fee has store {
        deposit_fee: 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::float::Float,
        redeem_fee: 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::float::Float,
    }

    struct Loan<phantom T0, phantom T1> has copy, drop {
        amount: u64,
        current_credit: u64,
    }

    struct Collect<phantom T0, phantom T1> has copy, drop {
        amount: u64,
        current_credit: u64,
    }

    public fun supply<T0>(arg0: &mut Exchange<T0>) : u64 {
        0x2::balance::supply_value<T0>(0x2::coin::supply<T0>(&mut arg0.treasury_cap))
    }

    public fun new<T0>(arg0: &AdminCap, arg1: 0x2::coin::TreasuryCap<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = Fee{
            deposit_fee : 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::float::from(0),
            redeem_fee  : 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::float::from(0),
        };
        let v1 = Exchange<T0>{
            id                  : 0x2::object::new(arg3),
            versions            : 0x2::vec_set::singleton<u64>(1),
            treasury_cap        : arg1,
            supply_limit        : arg2,
            fee                 : v0,
            sheet               : 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::new<GExchange, 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(stamp()),
            position            : 0x1::option::none<0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::StakeProof<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>>(),
            whitelisted_debtors : 0x2::vec_set::empty<0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::Debtor>(),
            owner               : 0x2::tx_context::sender(arg3),
        };
        0x2::transfer::share_object<Exchange<T0>>(v1);
    }

    public fun add_debtor<T0, T1>(arg0: &mut Exchange<T0>) {
        0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::add_debtor<GExchange, 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, T1>(&mut arg0.sheet, stamp());
    }

    public fun add_credit<T0>(arg0: &mut Exchange<T0>, arg1: &AdminCap) {
        0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::add_creditor<GExchange, 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, GExchange>(&mut arg0.sheet, stamp());
    }

    public fun add_version<T0>(arg0: &mut Exchange<T0>, arg1: &AdminCap, arg2: u64) {
        0x2::vec_set::insert<u64>(&mut arg0.versions, arg2);
    }

    public fun buy_chip<T0, T1>(arg0: &mut Exchange<T0>, arg1: 0x2::balance::Balance<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>, arg2: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::Loan<GExchange, T1, 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>) {
        check_version<T0>(arg0);
        if (!is_whitelisted_debtor<T0, T1>(arg0)) {
            err_not_whitelisted();
        };
        let v0 = exchange_rate<T0>(arg0);
        let v1 = calculate_loan_value<T0>(arg0, 0x2::balance::value<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(&arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>>(0x2::coin::from_balance<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(arg1, arg2), arg0.owner);
        let v2 = 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::debtor<T1>();
        let v3 = Loan<T1, 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>{
            amount         : v1,
            current_credit : 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::credit_value<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(0x2::vec_map::get<0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::Debtor, 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::Credit<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>>(0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::credits<GExchange, 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(&arg0.sheet), &v2)),
        };
        0x2::event::emit<Loan<T1, 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>>(v3);
        (0x2::balance::increase_supply<T0>(0x2::coin::supply_mut<T0>(&mut arg0.treasury_cap), 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::float::floor(0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::float::mul_u64(v0, v1))), 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::loan<GExchange, T1, 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(&mut arg0.sheet, 0x2::balance::split<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(&mut arg1, v1), stamp()))
    }

    fun calculate_loan_value<T0>(arg0: &Exchange<T0>, arg1: u64) : u64 {
        0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::float::floor(0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::float::mul_u64(0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::float::sub(0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::float::from_bps(10000), arg0.fee.deposit_fee), arg1))
    }

    fun calculate_redeem_value<T0>(arg0: &Exchange<T0>, arg1: u64) : u64 {
        0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::float::floor(0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::float::mul_u64(0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::float::sub(0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::float::from_bps(10000), arg0.fee.deposit_fee), arg1))
    }

    fun check_version<T0>(arg0: &Exchange<T0>) {
        let v0 = 1;
        if (!0x2::vec_set::contains<u64>(&arg0.versions, &v0)) {
            err_version_not_supported();
        };
    }

    fun err_not_whitelisted() {
        abort 2
    }

    fun err_version_already_contained() {
        abort 1
    }

    fun err_version_not_supported() {
        abort 0
    }

    fun exchange_rate<T0>(arg0: &mut Exchange<T0>) : 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::float::Float {
        if (0x1::option::is_none<0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::StakeProof<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>>(&arg0.position)) {
            0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::float::from_bps(10000)
        } else {
            let v1 = supply<T0>(arg0);
            0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::float::from_fraction(v1, 0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::get_proof_stake_amount<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>(0x1::option::borrow<0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::StakeProof<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>>(&arg0.position)))
        }
    }

    public fun fee<T0>(arg0: &Exchange<T0>) : (u64, u64) {
        ((0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::float::to_scaled_val(arg0.fee.deposit_fee) as u64), (0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::float::to_scaled_val(arg0.fee.redeem_fee) as u64))
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun is_whitelisted_debtor<T0, T1>(arg0: &Exchange<T0>) : bool {
        let v0 = 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::debtor<T1>();
        0x2::vec_set::contains<0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::Debtor>(&arg0.whitelisted_debtors, &v0)
    }

    public fun redeem_chip<T0, T1>(arg0: &mut Exchange<T0>, arg1: 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::Collector<GExchange, T1, 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK> {
        check_version<T0>(arg0);
        let v0 = 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::collect<GExchange, T1, 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(&mut arg0.sheet, arg1, stamp());
        let v1 = calculate_redeem_value<T0>(arg0, 0x2::balance::value<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(&v0));
        0x2::transfer::public_transfer<0x2::coin::Coin<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>>(0x2::coin::from_balance<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(v0, arg2), arg0.owner);
        let v2 = 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::debtor<T1>();
        let v3 = Collect<T1, 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>{
            amount         : v1,
            current_credit : 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::credit_value<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(0x2::vec_map::get<0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::Debtor, 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::Credit<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>>(0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::credits<GExchange, 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(&arg0.sheet), &v2)),
        };
        0x2::event::emit<Collect<T1, 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>>(v3);
        0x2::balance::split<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(&mut v0, v1)
    }

    public fun remove_version<T0>(arg0: &mut Exchange<T0>, arg1: &AdminCap, arg2: u64) {
        if (0x2::vec_set::contains<u64>(&arg0.versions, &arg2)) {
            err_version_already_contained();
        };
        0x2::vec_set::remove<u64>(&mut arg0.versions, &arg2);
    }

    public fun setFee<T0>(arg0: &mut Exchange<T0>, arg1: &AdminCap, arg2: u64, arg3: u64) {
        arg0.fee.deposit_fee = 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::float::from_bps(arg2);
        arg0.fee.redeem_fee = 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::float::from_bps(arg3);
    }

    fun stamp() : GExchange {
        GExchange{dummy_field: false}
    }

    public fun supply_limit<T0>(arg0: &Exchange<T0>) : u64 {
        arg0.supply_limit
    }

    public fun update_supply_limit<T0>(arg0: &mut Exchange<T0>, arg1: &AdminCap, arg2: u64) {
        arg0.supply_limit = arg2;
    }

    public fun whitelist_debtor<T0, T1>(arg0: &mut Exchange<T0>, arg1: &AdminCap) {
        0x2::vec_set::insert<0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::Debtor>(&mut arg0.whitelisted_debtors, 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::debtor<T1>());
    }

    // decompiled from Move bytecode v6
}

