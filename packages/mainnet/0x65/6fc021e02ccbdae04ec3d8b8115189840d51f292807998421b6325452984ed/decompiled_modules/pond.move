module 0x7b2720e50e5fa5f2ceb95c82b20495b4eaf0c18f3adfdd7de125f6fc65230dbf::pond {
    struct SCALLOP_POND has drop {
        dummy_field: bool,
    }

    struct ScallopPond<phantom T0> has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct ClaimReward<phantom T0> has copy, drop {
        amount: u64,
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

    struct CenterPond<phantom T0> has key {
        id: 0x2::object::UID,
        account: 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::account::Account,
    }

    struct BucketPosition<phantom T0> has store {
        strap: 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::strap::BottleStrap<T0>,
        sheet: 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::Sheet<SCALLOP_POND, T0>,
    }

    public fun account_request<T0>(arg0: &CenterPond<T0>, arg1: &0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::admin::AdminCap<T0>) : 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::account::AccountRequest {
        0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::account::request_with_account(&arg0.account)
    }

    public fun add_bucket_position<T0, T1>(arg0: &mut CenterPond<T0>, arg1: &0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::admin::AdminCap<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = BucketPosition<T1>{
            strap : 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::strap::new<T1>(arg2),
            sheet : 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::new<SCALLOP_POND, T1>(stamp()),
        };
        0x2::dynamic_field::add<0x1::type_name::TypeName, BucketPosition<T1>>(&mut arg0.id, 0x1::type_name::get<T1>(), v0);
    }

    public fun add_creditor<T0, T1, T2>(arg0: &mut CenterPond<T0>, arg1: &0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::admin::AdminCap<T0>) {
        0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::add_creditor<SCALLOP_POND, T1, T2>(&mut bucket_position_mut<T0, T1>(arg0).sheet, stamp());
    }

    public fun add_debtor<T0, T1, T2>(arg0: &mut CenterPond<T0>, arg1: &0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::admin::AdminCap<T0>) {
        0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::add_debtor<SCALLOP_POND, T1, T2>(&mut bucket_position_mut<T0, T1>(arg0).sheet, stamp());
    }

    fun bucket_position_mut<T0, T1>(arg0: &mut CenterPond<T0>) : &mut BucketPosition<T1> {
        let v0 = try_get_asset_name<T0, T1>(arg0);
        if (0x1::option::is_none<0x1::type_name::TypeName>(&v0)) {
            err_unsupported_asset();
        };
        0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, BucketPosition<T1>>(&mut arg0.id, 0x1::option::destroy_some<0x1::type_name::TypeName>(v0))
    }

    public fun claim<T0>(arg0: &AdminCap, arg1: &mut ScallopPond<T0>, arg2: &0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BucketProtocol, arg3: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg4: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::pipe::output_volume<T0, SCALLOP_POND>(0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::borrow_pipe<T0, SCALLOP_POND>(arg2));
        let v1 = if (v0 > 0) {
            0x7b2720e50e5fa5f2ceb95c82b20495b4eaf0c18f3adfdd7de125f6fc65230dbf::math::calc_coin_to_scoin(arg3, arg4, 0x1::type_name::get<T0>(), arg5, v0)
        } else {
            0
        };
        let v2 = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::redeem::redeem<T0>(arg3, arg4, 0x2::coin::take<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(&mut arg1.balance, 0x2::balance::value<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(&arg1.balance) - v1, arg6), arg5, arg6);
        let v3 = ClaimReward<T0>{amount: 0x2::coin::value<T0>(&v2)};
        0x2::event::emit<ClaimReward<T0>>(v3);
        v2
    }

    entry fun claim_to<T0>(arg0: &AdminCap, arg1: &mut ScallopPond<T0>, arg2: &0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BucketProtocol, arg3: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg4: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg5: &0x2::clock::Clock, arg6: address, arg7: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(claim<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg7), arg6);
    }

    public fun create<T0>(arg0: &AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = ScallopPond<T0>{
            id      : 0x2::object::new(arg1),
            balance : 0x2::balance::zero<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(),
        };
        0x2::transfer::share_object<ScallopPond<T0>>(v0);
    }

    public fun create_center<T0>(arg0: &AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = CenterPond<T0>{
            id      : 0x2::object::new(arg1),
            account : 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::account::new(0x1::string::utf8(b"CenterPond"), arg1),
        };
        0x2::transfer::share_object<CenterPond<T0>>(v0);
    }

    public fun create_center_pond<T0>(arg0: &0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::admin::AdminCap<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        abort 99
    }

    public fun deposit_opt_to_surplus<T0, T1, T2>(arg0: &mut CenterPond<T0>, arg1: &mut 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BucketProtocol, arg2: 0x1::option::Option<0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::Loan<T2, SCALLOP_POND, T1>>, arg3: &mut 0x2::tx_context::TxContext) {
        if (0x1::option::is_some<0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::Loan<T2, SCALLOP_POND, T1>>(&arg2)) {
            let v0 = bucket_position_mut<T0, T1>(arg0);
            let v1 = 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::receive<T2, SCALLOP_POND, T1>(&mut v0.sheet, 0x1::option::destroy_some<0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::Loan<T2, SCALLOP_POND, T1>>(arg2), stamp());
            0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::deposit_surplus_with_strap<T1>(arg1, v1, &v0.strap, arg3);
            let v2 = 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::creditor<T2>();
            let v3 = SurplusReceive<T0, T1, T2>{
                amount       : 0x2::balance::value<T1>(&v1),
                current_debt : 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::debt_value<T1>(0x2::vec_map::get<0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::Creditor, 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::Debt<T1>>(0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::debts<SCALLOP_POND, T1>(&v0.sheet), &v2)),
            };
            0x2::event::emit<SurplusReceive<T0, T1, T2>>(v3);
        } else {
            0x1::option::destroy_none<0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::Loan<T2, SCALLOP_POND, T1>>(arg2);
        };
    }

    public fun sheet<T0, T1>(arg0: &CenterPond<T0>) : &0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::Sheet<SCALLOP_POND, T1> {
        let v0 = try_get_asset_name<T0, T1>(arg0);
        if (0x1::option::is_none<0x1::type_name::TypeName>(&v0)) {
            err_unsupported_asset();
        };
        &0x2::dynamic_field::borrow<0x1::type_name::TypeName, BucketPosition<T1>>(&arg0.id, 0x1::option::destroy_some<0x1::type_name::TypeName>(v0)).sheet
    }

    public fun deposit_to_center<T0, T1>(arg0: &mut CenterPond<T0>, arg1: &0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::admin::AdminCap<T0>, arg2: &mut 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BucketProtocol, arg3: &mut 0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::point::PointCenter<T0>, arg4: &mut 0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::pool::DegenPool<T0, T1>, arg5: &0x2::clock::Clock, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::pipe::destroy_output_carrier<T1, SCALLOP_POND>(stamp(), 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::output<T1, SCALLOP_POND>(arg2, arg6));
        0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::point::fulfill_stake<T0>(arg3, arg5, 0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::wrapper::fulfill_stake<T0, T1>(arg4, 0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::wrapper::wrap_stake_request<T0, T1>(0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::pool::request_stake<T0, T1>(arg4, 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::account::request_with_account(&arg0.account), arg6)), 0x2::coin::from_balance<T1>(v0, arg7)));
        let v1 = SurplusToCenter<T0, T1>{amount: 0x2::balance::value<T1>(&v0)};
        0x2::event::emit<SurplusToCenter<T0, T1>>(v1);
    }

    public fun deposit_to_surplus<T0, T1, T2>(arg0: &mut CenterPond<T0>, arg1: &mut 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BucketProtocol, arg2: 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::Loan<T2, SCALLOP_POND, T1>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = bucket_position_mut<T0, T1>(arg0);
        let v1 = 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::receive<T2, SCALLOP_POND, T1>(&mut v0.sheet, arg2, stamp());
        0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::deposit_surplus_with_strap<T1>(arg1, v1, &v0.strap, arg3);
        let v2 = 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::creditor<T2>();
        let v3 = SurplusReceive<T0, T1, T2>{
            amount       : 0x2::balance::value<T1>(&v1),
            current_debt : 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::debt_value<T1>(0x2::vec_map::get<0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::Creditor, 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::Debt<T1>>(0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::debts<SCALLOP_POND, T1>(&v0.sheet), &v2)),
        };
        0x2::event::emit<SurplusReceive<T0, T1, T2>>(v3);
    }

    fun err_unsupported_asset() {
        abort 1
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun receive<T0, T1: store + key>(arg0: &AdminCap, arg1: &mut CenterPond<T0>, arg2: 0x2::transfer::Receiving<T1>) : T1 {
        0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::account::receive<T1>(&mut arg1.account, arg2)
    }

    fun stamp() : SCALLOP_POND {
        SCALLOP_POND{dummy_field: false}
    }

    public fun supply<T0>(arg0: &AdminCap, arg1: &mut ScallopPond<T0>, arg2: &mut 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BucketProtocol, arg3: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg4: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg5: &0x2::clock::Clock, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        0x2::coin::put<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(&mut arg1.balance, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::mint::mint<T0>(arg3, arg4, 0x2::coin::from_balance<T0>(0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::pipe::destroy_output_carrier<T0, SCALLOP_POND>(stamp(), 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::output<T0, SCALLOP_POND>(arg2, arg6)), arg7), arg5, arg7));
    }

    public fun try_get_asset_name<T0, T1>(arg0: &CenterPond<T0>) : 0x1::option::Option<0x1::type_name::TypeName> {
        let v0 = 0x1::type_name::get<T1>();
        if (0x2::dynamic_field::exists_<0x1::type_name::TypeName>(&arg0.id, v0)) {
            0x1::option::some<0x1::type_name::TypeName>(v0)
        } else {
            0x1::option::none<0x1::type_name::TypeName>()
        }
    }

    public fun withdraw<T0>(arg0: &AdminCap, arg1: &mut ScallopPond<T0>, arg2: &mut 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BucketProtocol, arg3: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg4: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg5: &0x2::clock::Clock, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::input<T0, SCALLOP_POND>(arg2, 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::pipe::input<T0, SCALLOP_POND>(stamp(), 0x2::coin::into_balance<T0>(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::redeem::redeem<T0>(arg3, arg4, 0x2::coin::take<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(&mut arg1.balance, 0x7b2720e50e5fa5f2ceb95c82b20495b4eaf0c18f3adfdd7de125f6fc65230dbf::math::calc_coin_to_scoin(arg3, arg4, 0x1::type_name::get<T0>(), arg5, arg6), arg7), arg5, arg7))));
    }

    public fun withdraw_from_center<T0, T1>(arg0: &mut CenterPond<T0>, arg1: &0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::admin::AdminCap<T0>, arg2: &mut 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BucketProtocol, arg3: &mut 0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::point::PointCenter<T0>, arg4: &mut 0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::pool::DegenPool<T0, T1>, arg5: &0x2::clock::Clock, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::wrapper::fulfill_unstake<T0, T1>(arg4, 0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::wrapper::wrap_unstake_request<T0, T1>(0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::pool::request_unstake<T0, T1>(arg4, 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::account::request_with_account(&arg0.account), arg6)), arg7);
        let v2 = v0;
        0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::input<T1, SCALLOP_POND>(arg2, 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::pipe::input<T1, SCALLOP_POND>(stamp(), 0x2::coin::into_balance<T1>(v2)));
        0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::point::fulfill_unstake<T0>(arg3, arg5, v1);
        let v3 = SurplusCollectCenter<T0, T1>{amount: 0x2::coin::value<T1>(&v2)};
        0x2::event::emit<SurplusCollectCenter<T0, T1>>(v3);
    }

    public fun withdraw_from_surplus<T0, T1, T2>(arg0: &mut CenterPond<T0>, arg1: &mut 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BucketProtocol, arg2: &mut 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::Collector<T2, SCALLOP_POND, T1>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = bucket_position_mut<T0, T1>(arg0);
        let v1 = 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::withdraw_surplus_with_strap<T1>(arg1, &v0.strap);
        let v2 = 0x2::balance::split<T1>(&mut v1, 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::requirement<T2, SCALLOP_POND, T1>(arg2));
        0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::deposit_surplus_with_strap<T1>(arg1, v1, &v0.strap, arg3);
        0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::repay<T2, SCALLOP_POND, T1>(&mut v0.sheet, arg2, v2, stamp());
        let v3 = 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::creditor<T2>();
        let v4 = SurplusRepay<T0, T1, T2>{
            amount       : 0x2::balance::value<T1>(&v2),
            current_debt : 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::debt_value<T1>(0x2::vec_map::get<0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::Creditor, 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::Debt<T1>>(0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::debts<SCALLOP_POND, T1>(&v0.sheet), &v3)),
        };
        0x2::event::emit<SurplusRepay<T0, T1, T2>>(v4);
    }

    public fun withdraw_opt_from_surplus<T0, T1, T2>(arg0: &mut CenterPond<T0>, arg1: &mut 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BucketProtocol, arg2: &mut 0x1::option::Option<0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::Collector<T2, SCALLOP_POND, T1>>, arg3: &mut 0x2::tx_context::TxContext) {
        if (0x1::option::is_some<0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::Collector<T2, SCALLOP_POND, T1>>(arg2)) {
            let v0 = 0x1::option::borrow_mut<0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::Collector<T2, SCALLOP_POND, T1>>(arg2);
            let v1 = bucket_position_mut<T0, T1>(arg0);
            let v2 = 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::withdraw_surplus_with_strap<T1>(arg1, &v1.strap);
            let v3 = 0x2::balance::split<T1>(&mut v2, 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::requirement<T2, SCALLOP_POND, T1>(v0));
            0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::deposit_surplus_with_strap<T1>(arg1, v2, &v1.strap, arg3);
            0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::repay<T2, SCALLOP_POND, T1>(&mut v1.sheet, v0, v3, stamp());
            let v4 = 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::creditor<T2>();
            let v5 = SurplusRepay<T0, T1, T2>{
                amount       : 0x2::balance::value<T1>(&v3),
                current_debt : 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::debt_value<T1>(0x2::vec_map::get<0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::Creditor, 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::Debt<T1>>(0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::debts<SCALLOP_POND, T1>(&v1.sheet), &v4)),
            };
            0x2::event::emit<SurplusRepay<T0, T1, T2>>(v5);
        };
    }

    // decompiled from Move bytecode v6
}

