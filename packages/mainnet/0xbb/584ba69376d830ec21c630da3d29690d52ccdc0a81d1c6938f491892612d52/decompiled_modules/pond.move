module 0xad4f4f73dc19dd2e28f380f287201a549215407db46acd7543e89443954d5eba::pond {
    struct ClaimReward<phantom T0> has copy, drop {
        amount: u64,
    }

    struct NAVI_POND has drop {
        dummy_field: bool,
    }

    struct NaviPond has key {
        id: 0x2::object::UID,
        navi_cap: 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct NAVI_UNI_POND has drop {
        dummy_field: bool,
    }

    struct SurplusToCenter<phantom T0, phantom T1> has copy, drop {
        amount: u64,
    }

    struct SurplusCollectCenter<phantom T0, phantom T1> has copy, drop {
        amount: u64,
    }

    struct SurplusReceive<phantom T0, phantom T1, phantom T2> has copy, drop {
        amount: u64,
        current_debt: u64,
    }

    struct SurplusRepay<phantom T0, phantom T1, phantom T2> has copy, drop {
        amount: u64,
        current_debt: u64,
    }

    struct NaviReceive<phantom T0, phantom T1, phantom T2> has copy, drop {
        amount: u64,
        current_debt: u64,
    }

    struct NaviRepay<phantom T0, phantom T1, phantom T2> has copy, drop {
        amount: u64,
        current_debt: u64,
    }

    struct CenterPond<phantom T0> has key {
        id: 0x2::object::UID,
        account: 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::account::Account,
        navi_cap: 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap,
    }

    struct Position<phantom T0> has store {
        strap: 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::strap::BottleStrap<T0>,
        surplus_sheet: 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::Sheet<NAVI_POND, T0>,
        navi_sheet: 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::Sheet<NAVI_UNI_POND, T0>,
    }

    struct AccountSheet<phantom T0, phantom T1> has copy, drop {
        total_debt: u64,
        total_balance: u64,
    }

    public fun receive<T0, T1: store + key>(arg0: &AdminCap, arg1: &mut CenterPond<T0>, arg2: 0x2::transfer::Receiving<T1>) : T1 {
        0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::account::receive<T1>(&mut arg1.account, arg2)
    }

    public fun add_creditor<T0, T1, T2>(arg0: &mut CenterPond<T0>, arg1: &0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::admin::AdminCap<T0>) {
        let v0 = position_mut<T0, T1>(arg0);
        0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::add_creditor<NAVI_POND, T1, T2>(&mut v0.surplus_sheet, stamp());
        0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::add_creditor<NAVI_UNI_POND, T1, T2>(&mut position_mut<T0, T1>(arg0).navi_sheet, uni_stamp());
    }

    public fun add_debtor<T0, T1, T2>(arg0: &mut CenterPond<T0>, arg1: &0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::admin::AdminCap<T0>) {
        let v0 = position_mut<T0, T1>(arg0);
        0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::add_debtor<NAVI_POND, T1, T2>(&mut v0.surplus_sheet, stamp());
        0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::add_debtor<NAVI_UNI_POND, T1, T2>(&mut position_mut<T0, T1>(arg0).navi_sheet, uni_stamp());
    }

    public fun account_request<T0>(arg0: &CenterPond<T0>, arg1: &0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::admin::AdminCap<T0>) : 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::account::AccountRequest {
        0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::account::request_with_account(&arg0.account)
    }

    public fun add_bucket_position<T0, T1>(arg0: &mut CenterPond<T0>, arg1: &0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::admin::AdminCap<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Position<T1>{
            strap         : 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::strap::new<T1>(arg2),
            surplus_sheet : 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::new<NAVI_POND, T1>(stamp()),
            navi_sheet    : 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::new<NAVI_UNI_POND, T1>(uni_stamp()),
        };
        0x2::dynamic_field::add<0x1::type_name::TypeName, Position<T1>>(&mut arg0.id, 0x1::type_name::get<T1>(), v0);
    }

    public fun claim<T0>(arg0: &AdminCap, arg1: &NaviPond, arg2: &0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BucketProtocol, arg3: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg6: u8, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::object::id<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap>(&arg1.navi_cap);
        let v1 = (0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::logic::user_collateral_balance(arg4, arg6, 0x2::object::id_to_address(&v0)) as u64) - 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::pipe::output_volume<T0, NAVI_POND>(0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::borrow_pipe<T0, NAVI_POND>(arg2));
        let v2 = ClaimReward<T0>{amount: v1};
        0x2::event::emit<ClaimReward<T0>>(v2);
        0x2::coin::from_balance<T0>(0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::withdraw_with_account_cap<T0>(arg9, arg3, arg4, arg5, arg6, v1, arg7, arg8, &arg1.navi_cap), arg10)
    }

    public fun claim_center_interest<T0, T1>(arg0: &AdminCap, arg1: &CenterPond<T0>, arg2: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg5: u8, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x2::vec_map::keys<0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::Creditor, 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::Debt<T1>>(0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::debts<NAVI_UNI_POND, T1>(navi_sheet<T0, T1>(arg1)));
        let v1 = &v0;
        let v2 = vector[];
        let v3 = 0;
        while (v3 < 0x1::vector::length<0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::Creditor>(v1)) {
            0x1::vector::push_back<u64>(&mut v2, 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::debt_value<T1>(0x2::vec_map::get<0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::Creditor, 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::Debt<T1>>(0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::debts<NAVI_UNI_POND, T1>(navi_sheet<T0, T1>(arg1)), 0x1::vector::borrow<0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::Creditor>(v1, v3))));
            v3 = v3 + 1;
        };
        let v4 = 0;
        0x1::vector::reverse<u64>(&mut v2);
        let v5 = 0;
        while (v5 < 0x1::vector::length<u64>(&v2)) {
            v4 = v4 + 0x1::vector::pop_back<u64>(&mut v2);
            v5 = v5 + 1;
        };
        0x1::vector::destroy_empty<u64>(v2);
        let v6 = 0x2::object::id<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap>(&arg1.navi_cap);
        let v7 = (0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::logic::user_collateral_balance(arg3, arg5, 0x2::object::id_to_address(&v6)) as u64) - v4;
        let v8 = ClaimReward<T1>{amount: v7};
        0x2::event::emit<ClaimReward<T1>>(v8);
        0x2::coin::from_balance<T1>(0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::withdraw_with_account_cap<T1>(arg8, arg2, arg3, arg4, arg5, v7, arg6, arg7, &arg1.navi_cap), arg9)
    }

    entry fun claim_center_interest_to<T0, T1>(arg0: &AdminCap, arg1: &CenterPond<T0>, arg2: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg5: u8, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg8: &0x2::clock::Clock, arg9: address, arg10: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(claim_center_interest<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg10), arg9);
    }

    public fun claim_center_reward<T0, T1>(arg0: &AdminCap, arg1: &mut CenterPond<T0>, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::IncentiveFundsPool<T1>, arg4: u8, arg5: u8, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::claim_reward_with_account_cap<T1>(arg7, arg6, arg3, arg2, arg4, arg5, &arg1.navi_cap);
        let v1 = ClaimReward<T1>{amount: 0x2::balance::value<T1>(&v0)};
        0x2::event::emit<ClaimReward<T1>>(v1);
        0x2::coin::from_balance<T1>(v0, arg8)
    }

    entry fun claim_center_reward_to<T0, T1>(arg0: &AdminCap, arg1: &mut CenterPond<T0>, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::IncentiveFundsPool<T1>, arg4: u8, arg5: u8, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg7: &0x2::clock::Clock, arg8: address, arg9: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(claim_center_reward<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg9), arg8);
    }

    public fun claim_reward<T0>(arg0: &AdminCap, arg1: &mut NaviPond, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::IncentiveFundsPool<T0>, arg4: u8, arg5: u8, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::claim_reward_with_account_cap<T0>(arg7, arg6, arg3, arg2, arg4, arg5, &arg1.navi_cap);
        let v1 = ClaimReward<T0>{amount: 0x2::balance::value<T0>(&v0)};
        0x2::event::emit<ClaimReward<T0>>(v1);
        0x2::coin::from_balance<T0>(v0, arg8)
    }

    entry fun claim_reward_to<T0>(arg0: &AdminCap, arg1: &mut NaviPond, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::IncentiveFundsPool<T0>, arg4: u8, arg5: u8, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg7: &0x2::clock::Clock, arg8: address, arg9: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(claim_reward<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg9), arg8);
    }

    entry fun claim_to<T0>(arg0: &AdminCap, arg1: &NaviPond, arg2: &0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BucketProtocol, arg3: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg6: u8, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg9: &0x2::clock::Clock, arg10: address, arg11: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(claim<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg11), arg10);
    }

    public fun create_center<T0>(arg0: &AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = CenterPond<T0>{
            id       : 0x2::object::new(arg1),
            account  : 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::account::new(0x1::string::utf8(b"CenterPond"), arg1),
            navi_cap : 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::lending::create_account(arg1),
        };
        0x2::transfer::share_object<CenterPond<T0>>(v0);
    }

    public fun deposit_to_center<T0, T1>(arg0: &mut CenterPond<T0>, arg1: &0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::admin::AdminCap<T0>, arg2: &mut 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BucketProtocol, arg3: &mut 0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::point::PointCenter<T0>, arg4: &mut 0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::pool::DegenPool<T0, T1>, arg5: &0x2::clock::Clock, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::pipe::destroy_output_carrier<T1, NAVI_POND>(stamp(), 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::output<T1, NAVI_POND>(arg2, arg6));
        0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::point::fulfill_stake<T0>(arg3, arg5, 0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::wrapper::fulfill_stake<T0, T1>(arg4, 0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::wrapper::wrap_stake_request<T0, T1>(0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::pool::request_stake<T0, T1>(arg4, 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::account::request_with_account(&arg0.account), arg6)), 0x2::coin::from_balance<T1>(v0, arg7)));
        let v1 = SurplusToCenter<T0, T1>{amount: 0x2::balance::value<T1>(&v0)};
        0x2::event::emit<SurplusToCenter<T0, T1>>(v1);
    }

    public fun deposit_to_navi<T0, T1, T2>(arg0: &mut CenterPond<T0>, arg1: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg3: u8, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg6: &0x2::clock::Clock, arg7: 0x1::option::Option<0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::Loan<T2, NAVI_UNI_POND, T1>>, arg8: &mut 0x2::tx_context::TxContext) {
        if (0x1::option::is_some<0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::Loan<T2, NAVI_UNI_POND, T1>>(&arg7)) {
            let v0 = position_mut<T0, T1>(arg0);
            let v1 = 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::receive<T2, NAVI_UNI_POND, T1>(&mut v0.navi_sheet, 0x1::option::destroy_some<0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::Loan<T2, NAVI_UNI_POND, T1>>(arg7), uni_stamp());
            0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::deposit_with_account_cap<T1>(arg6, arg1, arg2, arg3, 0x2::coin::from_balance<T1>(v1, arg8), arg4, arg5, &arg0.navi_cap);
            let v2 = 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::creditor<T2>();
            let v3 = NaviReceive<T0, T1, T2>{
                amount       : 0x2::balance::value<T1>(&v1),
                current_debt : 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::debt_value<T1>(0x2::vec_map::get<0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::Creditor, 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::Debt<T1>>(0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::debts<NAVI_UNI_POND, T1>(navi_sheet<T0, T1>(arg0)), &v2)),
            };
            0x2::event::emit<NaviReceive<T0, T1, T2>>(v3);
        } else {
            0x1::option::destroy_none<0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::Loan<T2, NAVI_UNI_POND, T1>>(arg7);
        };
    }

    public fun deposit_to_surplus<T0, T1, T2>(arg0: &mut CenterPond<T0>, arg1: &mut 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BucketProtocol, arg2: 0x1::option::Option<0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::Loan<T2, NAVI_POND, T1>>, arg3: &mut 0x2::tx_context::TxContext) {
        if (0x1::option::is_some<0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::Loan<T2, NAVI_POND, T1>>(&arg2)) {
            let v0 = position_mut<T0, T1>(arg0);
            let v1 = 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::receive<T2, NAVI_POND, T1>(&mut v0.surplus_sheet, 0x1::option::destroy_some<0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::Loan<T2, NAVI_POND, T1>>(arg2), stamp());
            0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::deposit_surplus_with_strap<T1>(arg1, v1, &v0.strap, arg3);
            let v2 = 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::creditor<T2>();
            let v3 = SurplusReceive<T0, T1, T2>{
                amount       : 0x2::balance::value<T1>(&v1),
                current_debt : 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::debt_value<T1>(0x2::vec_map::get<0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::Creditor, 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::Debt<T1>>(0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::debts<NAVI_POND, T1>(&v0.surplus_sheet), &v2)),
            };
            0x2::event::emit<SurplusReceive<T0, T1, T2>>(v3);
        } else {
            0x1::option::destroy_none<0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::Loan<T2, NAVI_POND, T1>>(arg2);
        };
    }

    public fun emit_cap_balance<T0, T1>(arg0: &AdminCap, arg1: &CenterPond<T0>, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: u8) {
        let v0 = 0x2::vec_map::keys<0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::Creditor, 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::Debt<T1>>(0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::debts<NAVI_UNI_POND, T1>(navi_sheet<T0, T1>(arg1)));
        let v1 = &v0;
        let v2 = vector[];
        let v3 = 0;
        while (v3 < 0x1::vector::length<0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::Creditor>(v1)) {
            0x1::vector::push_back<u64>(&mut v2, 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::debt_value<T1>(0x2::vec_map::get<0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::Creditor, 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::Debt<T1>>(0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::debts<NAVI_UNI_POND, T1>(navi_sheet<T0, T1>(arg1)), 0x1::vector::borrow<0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::Creditor>(v1, v3))));
            v3 = v3 + 1;
        };
        let v4 = 0;
        0x1::vector::reverse<u64>(&mut v2);
        let v5 = 0;
        while (v5 < 0x1::vector::length<u64>(&v2)) {
            v4 = v4 + 0x1::vector::pop_back<u64>(&mut v2);
            v5 = v5 + 1;
        };
        0x1::vector::destroy_empty<u64>(v2);
        let v6 = AccountSheet<T0, T1>{
            total_debt    : v4,
            total_balance : (0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::logic::user_collateral_balance(arg2, arg3, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::account_owner(&arg1.navi_cap)) as u64),
        };
        0x2::event::emit<AccountSheet<T0, T1>>(v6);
    }

    fun err_unsupported_asset() {
        abort 1
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = NaviPond{
            id       : 0x2::object::new(arg0),
            navi_cap : 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::lending::create_account(arg0),
        };
        0x2::transfer::share_object<NaviPond>(v1);
    }

    public fun navi_sheet<T0, T1>(arg0: &CenterPond<T0>) : &0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::Sheet<NAVI_UNI_POND, T1> {
        let v0 = try_get_asset_name<T0, T1>(arg0);
        if (0x1::option::is_none<0x1::type_name::TypeName>(&v0)) {
            err_unsupported_asset();
        };
        &0x2::dynamic_field::borrow<0x1::type_name::TypeName, Position<T1>>(&arg0.id, 0x1::option::destroy_some<0x1::type_name::TypeName>(v0)).navi_sheet
    }

    fun position_mut<T0, T1>(arg0: &mut CenterPond<T0>) : &mut Position<T1> {
        let v0 = try_get_asset_name<T0, T1>(arg0);
        if (0x1::option::is_none<0x1::type_name::TypeName>(&v0)) {
            err_unsupported_asset();
        };
        0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, Position<T1>>(&mut arg0.id, 0x1::option::destroy_some<0x1::type_name::TypeName>(v0))
    }

    fun stamp() : NAVI_POND {
        NAVI_POND{dummy_field: false}
    }

    public fun supply<T0>(arg0: &AdminCap, arg1: &mut NaviPond, arg2: &mut 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BucketProtocol, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg5: u8, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg8: &0x2::clock::Clock, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = NAVI_POND{dummy_field: false};
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::deposit_with_account_cap<T0>(arg8, arg3, arg4, arg5, 0x2::coin::from_balance<T0>(0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::pipe::destroy_output_carrier<T0, NAVI_POND>(v0, 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::output<T0, NAVI_POND>(arg2, arg9)), arg10), arg6, arg7, &arg1.navi_cap);
    }

    public fun supply_buck(arg0: &AdminCap, arg1: &mut NaviPond, arg2: &mut 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BucketProtocol, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>, arg5: u8, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg8: &0x2::clock::Clock, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = NAVI_POND{dummy_field: false};
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::deposit_with_account_cap<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(arg8, arg3, arg4, arg5, 0x2::coin::from_balance<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::pipe::destroy_output_carrier<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, NAVI_POND>(v0, 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::output_buck<NAVI_POND>(arg2, arg9)), arg10), arg6, arg7, &arg1.navi_cap);
    }

    public fun surplus_sheet<T0, T1>(arg0: &CenterPond<T0>) : &0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::Sheet<NAVI_POND, T1> {
        let v0 = try_get_asset_name<T0, T1>(arg0);
        if (0x1::option::is_none<0x1::type_name::TypeName>(&v0)) {
            err_unsupported_asset();
        };
        &0x2::dynamic_field::borrow<0x1::type_name::TypeName, Position<T1>>(&arg0.id, 0x1::option::destroy_some<0x1::type_name::TypeName>(v0)).surplus_sheet
    }

    public fun try_get_asset_name<T0, T1>(arg0: &CenterPond<T0>) : 0x1::option::Option<0x1::type_name::TypeName> {
        let v0 = 0x1::type_name::get<T1>();
        if (0x2::dynamic_field::exists_<0x1::type_name::TypeName>(&arg0.id, v0)) {
            0x1::option::some<0x1::type_name::TypeName>(v0)
        } else {
            0x1::option::none<0x1::type_name::TypeName>()
        }
    }

    fun uni_stamp() : NAVI_UNI_POND {
        NAVI_UNI_POND{dummy_field: false}
    }

    public fun withdraw<T0>(arg0: &AdminCap, arg1: &mut NaviPond, arg2: &mut 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BucketProtocol, arg3: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg6: u8, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg9: &0x2::clock::Clock, arg10: u64) {
        let v0 = NAVI_POND{dummy_field: false};
        0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::input<T0, NAVI_POND>(arg2, 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::pipe::input<T0, NAVI_POND>(v0, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::withdraw_with_account_cap<T0>(arg9, arg3, arg4, arg5, arg6, arg10, arg7, arg8, &arg1.navi_cap)));
    }

    public fun withdraw_buck(arg0: &AdminCap, arg1: &mut NaviPond, arg2: &mut 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BucketProtocol, arg3: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>, arg6: u8, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg9: &0x2::clock::Clock, arg10: u64) {
        let v0 = NAVI_POND{dummy_field: false};
        0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::input_buck<NAVI_POND>(arg2, 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::pipe::input<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, NAVI_POND>(v0, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::withdraw_with_account_cap<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(arg9, arg3, arg4, arg5, arg6, arg10, arg7, arg8, &arg1.navi_cap)));
    }

    public fun withdraw_from_center<T0, T1>(arg0: &mut CenterPond<T0>, arg1: &0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::admin::AdminCap<T0>, arg2: &mut 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BucketProtocol, arg3: &mut 0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::point::PointCenter<T0>, arg4: &mut 0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::pool::DegenPool<T0, T1>, arg5: &0x2::clock::Clock, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::wrapper::fulfill_unstake<T0, T1>(arg4, 0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::wrapper::wrap_unstake_request<T0, T1>(0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::pool::request_unstake<T0, T1>(arg4, 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::account::request_with_account(&arg0.account), arg6)), arg7);
        let v2 = v0;
        0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::input<T1, NAVI_POND>(arg2, 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::pipe::input<T1, NAVI_POND>(stamp(), 0x2::coin::into_balance<T1>(v2)));
        0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::point::fulfill_unstake<T0>(arg3, arg5, v1);
        let v3 = SurplusCollectCenter<T0, T1>{amount: 0x2::coin::value<T1>(&v2)};
        0x2::event::emit<SurplusCollectCenter<T0, T1>>(v3);
    }

    public fun withdraw_from_navi<T0, T1, T2>(arg0: &AdminCap, arg1: &mut CenterPond<T0>, arg2: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg5: u8, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg8: &0x2::clock::Clock, arg9: &mut 0x1::option::Option<0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::Collector<T2, NAVI_UNI_POND, T1>>) {
        if (0x1::option::is_some<0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::Collector<T2, NAVI_UNI_POND, T1>>(arg9)) {
            let v0 = 0x1::option::borrow_mut<0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::Collector<T2, NAVI_UNI_POND, T1>>(arg9);
            let v1 = 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::requirement<T2, NAVI_UNI_POND, T1>(v0);
            let v2 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::withdraw_with_account_cap<T1>(arg8, arg2, arg3, arg4, arg5, v1, arg6, arg7, &arg1.navi_cap);
            let v3 = position_mut<T0, T1>(arg1);
            0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::repay<T2, NAVI_UNI_POND, T1>(&mut v3.navi_sheet, v0, v2, uni_stamp());
            let v4 = 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::creditor<T2>();
            let v5 = NaviRepay<T0, T1, T2>{
                amount       : v1,
                current_debt : 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::debt_value<T1>(0x2::vec_map::get<0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::Creditor, 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::Debt<T1>>(0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::debts<NAVI_UNI_POND, T1>(navi_sheet<T0, T1>(arg1)), &v4)),
            };
            0x2::event::emit<NaviRepay<T0, T1, T2>>(v5);
        };
    }

    public fun withdraw_from_navi_v2<T0, T1, T2>(arg0: &mut CenterPond<T0>, arg1: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg4: u8, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg7: &0x2::clock::Clock, arg8: &mut 0x1::option::Option<0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::Collector<T2, NAVI_UNI_POND, T1>>) {
        if (0x1::option::is_some<0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::Collector<T2, NAVI_UNI_POND, T1>>(arg8)) {
            let v0 = 0x1::option::borrow_mut<0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::Collector<T2, NAVI_UNI_POND, T1>>(arg8);
            let v1 = 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::requirement<T2, NAVI_UNI_POND, T1>(v0);
            let v2 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::withdraw_with_account_cap<T1>(arg7, arg1, arg2, arg3, arg4, v1, arg5, arg6, &arg0.navi_cap);
            let v3 = position_mut<T0, T1>(arg0);
            0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::repay<T2, NAVI_UNI_POND, T1>(&mut v3.navi_sheet, v0, v2, uni_stamp());
            let v4 = 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::creditor<T2>();
            let v5 = NaviRepay<T0, T1, T2>{
                amount       : v1,
                current_debt : 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::debt_value<T1>(0x2::vec_map::get<0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::Creditor, 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::Debt<T1>>(0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::debts<NAVI_UNI_POND, T1>(navi_sheet<T0, T1>(arg0)), &v4)),
            };
            0x2::event::emit<NaviRepay<T0, T1, T2>>(v5);
        };
    }

    public fun withdraw_from_navi_v3<T0, T1, T2>(arg0: &mut CenterPond<T0>, arg1: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg4: u8, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg7: &0x2::clock::Clock, arg8: &mut 0x1::option::Option<0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::Collector<T2, NAVI_UNI_POND, T1>>) {
        if (0x1::option::is_some<0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::Collector<T2, NAVI_UNI_POND, T1>>(arg8)) {
            let v0 = 0x1::option::borrow_mut<0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::Collector<T2, NAVI_UNI_POND, T1>>(arg8);
            let v1 = 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::requirement<T2, NAVI_UNI_POND, T1>(v0);
            let v2 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::withdraw_with_account_cap<T1>(arg7, arg1, arg2, arg3, arg4, v1, arg5, arg6, &arg0.navi_cap);
            let v3 = position_mut<T0, T1>(arg0);
            0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::repay<T2, NAVI_UNI_POND, T1>(&mut v3.navi_sheet, v0, v2, uni_stamp());
            let v4 = 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::creditor<T2>();
            let v5 = NaviRepay<T0, T1, T2>{
                amount       : v1,
                current_debt : 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::debt_value<T1>(0x2::vec_map::get<0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::Creditor, 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::Debt<T1>>(0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::debts<NAVI_UNI_POND, T1>(navi_sheet<T0, T1>(arg0)), &v4)),
            };
            0x2::event::emit<NaviRepay<T0, T1, T2>>(v5);
        };
    }

    public fun withdraw_from_surplus<T0, T1, T2>(arg0: &mut CenterPond<T0>, arg1: &mut 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BucketProtocol, arg2: &mut 0x1::option::Option<0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::Collector<T2, NAVI_POND, T1>>, arg3: &mut 0x2::tx_context::TxContext) {
        if (0x1::option::is_some<0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::Collector<T2, NAVI_POND, T1>>(arg2)) {
            let v0 = 0x1::option::borrow_mut<0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::Collector<T2, NAVI_POND, T1>>(arg2);
            let v1 = position_mut<T0, T1>(arg0);
            let v2 = 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::withdraw_surplus_with_strap<T1>(arg1, &v1.strap);
            let v3 = 0x2::balance::split<T1>(&mut v2, 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::requirement<T2, NAVI_POND, T1>(v0));
            0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::deposit_surplus_with_strap<T1>(arg1, v2, &v1.strap, arg3);
            0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::repay<T2, NAVI_POND, T1>(&mut v1.surplus_sheet, v0, v3, stamp());
            let v4 = 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::creditor<T2>();
            let v5 = SurplusRepay<T0, T1, T2>{
                amount       : 0x2::balance::value<T1>(&v3),
                current_debt : 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::debt_value<T1>(0x2::vec_map::get<0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::Creditor, 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::Debt<T1>>(0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::debts<NAVI_POND, T1>(&v1.surplus_sheet), &v4)),
            };
            0x2::event::emit<SurplusRepay<T0, T1, T2>>(v5);
        };
    }

    // decompiled from Move bytecode v6
}

