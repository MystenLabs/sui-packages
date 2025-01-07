module 0x46956f33fbd3b3396cb2bc5aa6de2702d6832fad38c762092561bb332028d471::bond {
    struct BOND_ADMIN has drop {
        dummy_field: bool,
    }

    struct BondCreated has copy, drop {
        exec_price: u64,
        vapor_amount: u64,
        bond_amount: u64,
    }

    struct BondClaimed has copy, drop {
        vapor_amount: u64,
    }

    struct BondManager has key {
        id: 0x2::object::UID,
        treasury: 0x1::option::Option<address>,
        vapor_mint_cap: 0x1::option::Option<0x46956f33fbd3b3396cb2bc5aa6de2702d6832fad38c762092561bb332028d471::vapor::MintCap>,
        vapor_outstanding: u64,
        vapor_rfv: u64,
        vest_duration: u64,
    }

    struct BondAsset<phantom T0> has key {
        id: 0x2::object::UID,
        oracle: 0x1::option::Option<0x46956f33fbd3b3396cb2bc5aa6de2702d6832fad38c762092561bb332028d471::price_oracle::PriceOracle>,
        bcv: u64,
        bond_cap: 0x1::option::Option<u64>,
    }

    struct BondVesting has store, key {
        id: 0x2::object::UID,
        schedule: 0x46956f33fbd3b3396cb2bc5aa6de2702d6832fad38c762092561bb332028d471::vesting::VestingSchedule<0x46956f33fbd3b3396cb2bc5aa6de2702d6832fad38c762092561bb332028d471::vapor::VAPOR>,
    }

    public fun bond<T0>(arg0: &mut BondManager, arg1: &mut BondAsset<T0>, arg2: &mut 0x46956f33fbd3b3396cb2bc5aa6de2702d6832fad38c762092561bb332028d471::vapor::Treasury, arg3: 0x2::coin::Coin<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : BondVesting {
        let v0 = 0x2::coin::value<T0>(&arg3);
        assert!(v0 > 0, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg3, *0x1::option::borrow<address>(&arg0.treasury));
        let v1 = get_asset_exec_price<T0>(arg0, arg1, arg2);
        let v2 = v0 * 0x46956f33fbd3b3396cb2bc5aa6de2702d6832fad38c762092561bb332028d471::price_oracle::get_oracle_price(0x1::option::borrow<0x46956f33fbd3b3396cb2bc5aa6de2702d6832fad38c762092561bb332028d471::price_oracle::PriceOracle>(&arg1.oracle), arg4) / v1;
        arg0.vapor_outstanding = arg0.vapor_outstanding + v2;
        if (0x1::option::is_some<u64>(&arg1.bond_cap)) {
            let v3 = *0x1::option::borrow<u64>(&arg1.bond_cap);
            assert!(v3 >= v0, 1);
            arg1.bond_cap = 0x1::option::some<u64>(v3 - v0);
        };
        let v4 = BondCreated{
            exec_price   : v1,
            vapor_amount : v2,
            bond_amount  : v0,
        };
        0x2::event::emit<BondCreated>(v4);
        BondVesting{
            id       : 0x2::object::new(arg5),
            schedule : 0x46956f33fbd3b3396cb2bc5aa6de2702d6832fad38c762092561bb332028d471::vesting::vest_tokens<0x46956f33fbd3b3396cb2bc5aa6de2702d6832fad38c762092561bb332028d471::vapor::VAPOR>(0x46956f33fbd3b3396cb2bc5aa6de2702d6832fad38c762092561bb332028d471::vapor::mint(0x1::option::borrow<0x46956f33fbd3b3396cb2bc5aa6de2702d6832fad38c762092561bb332028d471::vapor::MintCap>(&arg0.vapor_mint_cap), arg2, v2, arg5), 0x2::clock::timestamp_ms(arg4), arg0.vest_duration, arg5),
        }
    }

    entry fun bond_to_sender<T0>(arg0: &mut BondManager, arg1: &mut BondAsset<T0>, arg2: &mut 0x46956f33fbd3b3396cb2bc5aa6de2702d6832fad38c762092561bb332028d471::vapor::Treasury, arg3: 0x2::coin::Coin<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = bond<T0>(arg0, arg1, arg2, arg3, arg4, arg5);
        0x2::transfer::public_transfer<BondVesting>(v0, 0x2::tx_context::sender(arg5));
    }

    public fun claim_vapor(arg0: &mut BondManager, arg1: &mut BondVesting, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x46956f33fbd3b3396cb2bc5aa6de2702d6832fad38c762092561bb332028d471::vapor::VAPOR> {
        let v0 = 0x46956f33fbd3b3396cb2bc5aa6de2702d6832fad38c762092561bb332028d471::vesting::claim_vested<0x46956f33fbd3b3396cb2bc5aa6de2702d6832fad38c762092561bb332028d471::vapor::VAPOR>(&mut arg1.schedule, arg2, arg3);
        arg0.vapor_outstanding = arg0.vapor_outstanding - 0x2::coin::value<0x46956f33fbd3b3396cb2bc5aa6de2702d6832fad38c762092561bb332028d471::vapor::VAPOR>(&v0);
        let v1 = BondClaimed{vapor_amount: 0x2::coin::value<0x46956f33fbd3b3396cb2bc5aa6de2702d6832fad38c762092561bb332028d471::vapor::VAPOR>(&v0)};
        0x2::event::emit<BondClaimed>(v1);
        v0
    }

    entry fun claim_vapor_to_sender(arg0: &mut BondManager, arg1: &mut BondVesting, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = claim_vapor(arg0, arg1, arg2, arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x46956f33fbd3b3396cb2bc5aa6de2702d6832fad38c762092561bb332028d471::vapor::VAPOR>>(v0, 0x2::tx_context::sender(arg3));
    }

    public fun create_bond_asset<T0>(arg0: &0x46956f33fbd3b3396cb2bc5aa6de2702d6832fad38c762092561bb332028d471::admin::OwnerCap<BOND_ADMIN>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: 0x1::option::Option<u64>, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::coin::destroy_zero<T0>(arg1);
        let v0 = BondAsset<T0>{
            id       : 0x2::object::new(arg4),
            oracle   : 0x1::option::none<0x46956f33fbd3b3396cb2bc5aa6de2702d6832fad38c762092561bb332028d471::price_oracle::PriceOracle>(),
            bcv      : arg2,
            bond_cap : arg3,
        };
        0x2::transfer::share_object<BondAsset<T0>>(v0);
    }

    public fun destroy_asset_oracle<T0>(arg0: &0x46956f33fbd3b3396cb2bc5aa6de2702d6832fad38c762092561bb332028d471::admin::OwnerCap<BOND_ADMIN>, arg1: &mut BondAsset<T0>) {
        0x46956f33fbd3b3396cb2bc5aa6de2702d6832fad38c762092561bb332028d471::price_oracle::destroy_oracle(0x1::option::extract<0x46956f33fbd3b3396cb2bc5aa6de2702d6832fad38c762092561bb332028d471::price_oracle::PriceOracle>(&mut arg1.oracle));
    }

    public fun destroy_vapor_mint_cap(arg0: &0x46956f33fbd3b3396cb2bc5aa6de2702d6832fad38c762092561bb332028d471::admin::OwnerCap<BOND_ADMIN>, arg1: &mut BondManager) {
        0x46956f33fbd3b3396cb2bc5aa6de2702d6832fad38c762092561bb332028d471::vapor::destroy_mint_cap(0x1::option::extract<0x46956f33fbd3b3396cb2bc5aa6de2702d6832fad38c762092561bb332028d471::vapor::MintCap>(&mut arg1.vapor_mint_cap));
    }

    public fun get_asset_bcv<T0>(arg0: &BondAsset<T0>) : u64 {
        arg0.bcv
    }

    public fun get_asset_exec_price<T0>(arg0: &BondManager, arg1: &BondAsset<T0>, arg2: &0x46956f33fbd3b3396cb2bc5aa6de2702d6832fad38c762092561bb332028d471::vapor::Treasury) : u64 {
        arg0.vapor_rfv * (1000000 + get_debt_ratio(arg0, arg2) * 1000000 / arg1.bcv) / 1000000
    }

    public fun get_debt_ratio(arg0: &BondManager, arg1: &0x46956f33fbd3b3396cb2bc5aa6de2702d6832fad38c762092561bb332028d471::vapor::Treasury) : u64 {
        arg0.vapor_outstanding * 1000000 / (0x46956f33fbd3b3396cb2bc5aa6de2702d6832fad38c762092561bb332028d471::vapor::get_total_supply(arg1) - arg0.vapor_outstanding)
    }

    public fun get_treasury(arg0: &BondManager) : 0x1::option::Option<address> {
        arg0.treasury
    }

    public fun get_vapor_outstanding(arg0: &BondManager) : u64 {
        arg0.vapor_outstanding
    }

    public fun get_vapor_rfv(arg0: &BondManager) : u64 {
        arg0.vapor_rfv
    }

    public fun get_vest_duration(arg0: &BondManager) : u64 {
        arg0.vest_duration
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = BOND_ADMIN{dummy_field: false};
        0x46956f33fbd3b3396cb2bc5aa6de2702d6832fad38c762092561bb332028d471::admin::transfer_owner_cap<BOND_ADMIN>(0x46956f33fbd3b3396cb2bc5aa6de2702d6832fad38c762092561bb332028d471::admin::create_owner_cap<BOND_ADMIN>(v0, arg0), 0x2::tx_context::sender(arg0));
        let v1 = BondManager{
            id                : 0x2::object::new(arg0),
            treasury          : 0x1::option::none<address>(),
            vapor_mint_cap    : 0x1::option::none<0x46956f33fbd3b3396cb2bc5aa6de2702d6832fad38c762092561bb332028d471::vapor::MintCap>(),
            vapor_outstanding : 0,
            vapor_rfv         : 0,
            vest_duration     : 432000000,
        };
        0x2::transfer::share_object<BondManager>(v1);
    }

    public fun set_asset_bcv<T0>(arg0: &0x46956f33fbd3b3396cb2bc5aa6de2702d6832fad38c762092561bb332028d471::admin::OwnerCap<BOND_ADMIN>, arg1: &mut BondAsset<T0>, arg2: u64) {
        arg1.bcv = arg2;
    }

    public fun set_asset_bond_cap<T0>(arg0: &0x46956f33fbd3b3396cb2bc5aa6de2702d6832fad38c762092561bb332028d471::admin::OwnerCap<BOND_ADMIN>, arg1: &mut BondAsset<T0>, arg2: u64) {
        0x1::option::fill<u64>(&mut arg1.bond_cap, arg2);
    }

    public fun set_asset_oracle<T0>(arg0: &0x46956f33fbd3b3396cb2bc5aa6de2702d6832fad38c762092561bb332028d471::admin::OwnerCap<BOND_ADMIN>, arg1: &mut BondAsset<T0>, arg2: 0x46956f33fbd3b3396cb2bc5aa6de2702d6832fad38c762092561bb332028d471::price_oracle::PriceOracle) {
        0x1::option::fill<0x46956f33fbd3b3396cb2bc5aa6de2702d6832fad38c762092561bb332028d471::price_oracle::PriceOracle>(&mut arg1.oracle, arg2);
    }

    public fun set_oracle_admin_price<T0>(arg0: &0x46956f33fbd3b3396cb2bc5aa6de2702d6832fad38c762092561bb332028d471::admin::OperatorCap<0x46956f33fbd3b3396cb2bc5aa6de2702d6832fad38c762092561bb332028d471::price_oracle::ORACLE_ADMIN>, arg1: &mut BondAsset<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x46956f33fbd3b3396cb2bc5aa6de2702d6832fad38c762092561bb332028d471::price_oracle::set_admin_price(arg0, 0x1::option::borrow_mut<0x46956f33fbd3b3396cb2bc5aa6de2702d6832fad38c762092561bb332028d471::price_oracle::PriceOracle>(&mut arg1.oracle), arg2, arg3);
    }

    public fun set_treasury(arg0: &0x46956f33fbd3b3396cb2bc5aa6de2702d6832fad38c762092561bb332028d471::admin::OwnerCap<BOND_ADMIN>, arg1: &mut BondManager, arg2: address) {
        0x1::option::swap_or_fill<address>(&mut arg1.treasury, arg2);
    }

    public fun set_vapor_mint_cap(arg0: &0x46956f33fbd3b3396cb2bc5aa6de2702d6832fad38c762092561bb332028d471::admin::OwnerCap<BOND_ADMIN>, arg1: &mut BondManager, arg2: 0x46956f33fbd3b3396cb2bc5aa6de2702d6832fad38c762092561bb332028d471::vapor::MintCap) {
        0x1::option::fill<0x46956f33fbd3b3396cb2bc5aa6de2702d6832fad38c762092561bb332028d471::vapor::MintCap>(&mut arg1.vapor_mint_cap, arg2);
    }

    public fun set_vapor_rfv(arg0: &0x46956f33fbd3b3396cb2bc5aa6de2702d6832fad38c762092561bb332028d471::admin::OwnerCap<BOND_ADMIN>, arg1: &mut BondManager, arg2: u64) {
        arg1.vapor_rfv = arg2;
    }

    public fun set_vest_duration(arg0: &0x46956f33fbd3b3396cb2bc5aa6de2702d6832fad38c762092561bb332028d471::admin::OwnerCap<BOND_ADMIN>, arg1: &mut BondManager, arg2: u64) {
        arg1.vest_duration = arg2;
    }

    // decompiled from Move bytecode v6
}

