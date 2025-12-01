module 0x839ebd53d7fd8cf4209b83a3937c3875968e2705156717c76760b3b64eef7e3a::stable_vault {
    struct NewVault has copy, drop {
        vault_id: 0x2::object::ID,
        lp_type: 0x1::ascii::String,
        u_type: 0x1::ascii::String,
        y_type: 0x1::ascii::String,
    }

    struct Mint has copy, drop {
        vault_id: 0x2::object::ID,
        lp_type: 0x1::ascii::String,
        lp_amount: u64,
        u_type: 0x1::ascii::String,
        u_amount: u64,
    }

    struct RequestBurn has copy, drop {
        vault_id: 0x2::object::ID,
        request_id: 0x2::object::ID,
        recipient: address,
        lp_type: 0x1::ascii::String,
        lp_amount: u64,
        expected_burn_time: u64,
    }

    struct RequestToBurn has copy, drop {
        vault_id: 0x2::object::ID,
        request_id: 0x2::object::ID,
        recipient: address,
        lp_type: 0x1::ascii::String,
        lp_amount: u64,
        u_amount: u64,
        expected_burn_time: u64,
    }

    struct CancelBurn has copy, drop {
        vault_id: 0x2::object::ID,
        request_id: 0x2::object::ID,
        lp_type: 0x1::ascii::String,
        lp_amount: u64,
    }

    struct Burn has copy, drop {
        vault_id: 0x2::object::ID,
        request_id: 0x1::option::Option<0x2::object::ID>,
        recipient: 0x1::option::Option<address>,
        lp_type: 0x1::ascii::String,
        lp_amount: u64,
        u_type: 0x1::ascii::String,
        u_amount: u64,
    }

    struct BurnRequest<phantom T0> has store {
        recipient: address,
        lp_to_burn: 0x2::balance::Balance<T0>,
        expected_burn_time: u64,
        is_burnable: bool,
    }

    struct BurnRequestData has copy, drop, store {
        request_id: 0x2::object::ID,
        recipient: address,
        lp_amount_to_burn: u64,
        expected_burn_time: u64,
        is_burnable: bool,
    }

    struct StableVault<phantom T0, phantom T1, phantom T2> has store, key {
        id: 0x2::object::UID,
        abstract_account: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::Account,
        yield_usdb_balance: 0x2::balance::Balance<T2>,
        lp_treasury_cap: 0x2::coin::TreasuryCap<T0>,
        versions: 0x2::vec_set::VecSet<u16>,
        managers: 0x2::vec_set::VecSet<address>,
        instant_burn_permissions: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
        burn_requests: 0x2::linked_table::LinkedTable<0x2::object::ID, BurnRequest<T0>>,
        delay_ms: u64,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    public fun burn<T0, T1, T2, T3, T4: drop>(arg0: &mut StableVault<T0, T1, T2>, arg1: &mut 0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::Treasury, arg2: &mut 0xc2ae6693383e4a81285136effc8190c7baaf0e75aafa36d1c69cd2170cfc3803::pool::Pool<T1>, arg3: &mut 0x872d08a70db3db498aa7853276acea8091fdd9871b2d86bc8dcb8524526df622::saving::SavingPool<T3>, arg4: &mut 0x203eebc39442014a1b8180f3b8ed70143dac2c5d28ba5703fe34c21052728705::yield_usdb::YieldVault<T2, T3>, arg5: &0xf2ab9aa60c5e879675351a1a89f47131de9dea7cc927327dd0e7282e295c7f5e::result::PriceResult<T1>, arg6: &0x2::clock::Clock, arg7: 0x2::coin::Coin<T0>, arg8: T4, arg9: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x872d08a70db3db498aa7853276acea8091fdd9871b2d86bc8dcb8524526df622::saving::WithdrawResponse<T3>) {
        assert_valid_package_version<T0, T1, T2>(arg0);
        let v0 = 0x1::type_name::with_defining_ids<T4>();
        if (!0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.instant_burn_permissions, &v0)) {
            err_not_allow_to_burn_instantly();
        };
        let (v1, v2) = burn_to_usdb_internal<T0, T1, T2, T3>(arg0, arg1, arg3, arg4, arg6, arg7, arg9);
        let v3 = 0x1::option::some<0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::AccountRequest>(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::request_with_account(&arg0.abstract_account));
        let v4 = 0xc2ae6693383e4a81285136effc8190c7baaf0e75aafa36d1c69cd2170cfc3803::pool::swap_out<T1>(arg2, arg1, arg5, v1, &v3, arg9);
        let v5 = Burn{
            vault_id   : 0x2::object::id<StableVault<T0, T1, T2>>(arg0),
            request_id : 0x1::option::none<0x2::object::ID>(),
            recipient  : 0x1::option::none<address>(),
            lp_type    : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()),
            lp_amount  : 0x2::coin::value<T0>(&arg7),
            u_type     : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T1>()),
            u_amount   : 0x2::coin::value<T1>(&v4),
        };
        0x2::event::emit<Burn>(v5);
        (v4, v2)
    }

    public fun mint<T0, T1, T2, T3>(arg0: &mut StableVault<T0, T1, T2>, arg1: &mut 0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::Treasury, arg2: &mut 0xc2ae6693383e4a81285136effc8190c7baaf0e75aafa36d1c69cd2170cfc3803::pool::Pool<T1>, arg3: &mut 0x872d08a70db3db498aa7853276acea8091fdd9871b2d86bc8dcb8524526df622::saving::SavingPool<T3>, arg4: &mut 0x203eebc39442014a1b8180f3b8ed70143dac2c5d28ba5703fe34c21052728705::yield_usdb::YieldVault<T2, T3>, arg5: &0xf2ab9aa60c5e879675351a1a89f47131de9dea7cc927327dd0e7282e295c7f5e::result::PriceResult<T1>, arg6: &0x2::clock::Clock, arg7: 0x2::coin::Coin<T1>, arg8: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x872d08a70db3db498aa7853276acea8091fdd9871b2d86bc8dcb8524526df622::saving::DepositResponse<T3>) {
        assert_valid_package_version<T0, T1, T2>(arg0);
        let v0 = 0x1::option::some<0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::AccountRequest>(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::request_with_account(&arg0.abstract_account));
        let (v1, v2) = 0x203eebc39442014a1b8180f3b8ed70143dac2c5d28ba5703fe34c21052728705::yield_usdb::mint<T2, T3>(arg4, arg1, arg3, arg6, 0xc2ae6693383e4a81285136effc8190c7baaf0e75aafa36d1c69cd2170cfc3803::pool::swap_in<T1>(arg2, arg1, arg5, arg7, &v0, arg8), arg8);
        let v3 = v1;
        0x2::balance::join<T2>(&mut arg0.yield_usdb_balance, 0x2::coin::into_balance<T2>(v3));
        let v4 = 0x2::coin::mint<T0>(&mut arg0.lp_treasury_cap, 0x2::coin::value<T2>(&v3), arg8);
        let v5 = Mint{
            vault_id  : 0x2::object::id<StableVault<T0, T1, T2>>(arg0),
            lp_type   : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()),
            lp_amount : 0x2::coin::value<T0>(&v4),
            u_type    : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T1>()),
            u_amount  : 0x2::coin::value<T1>(&arg7),
        };
        0x2::event::emit<Mint>(v5);
        (v4, v2)
    }

    public fun new<T0, T1, T2>(arg0: &AdminCap, arg1: 0x2::coin::TreasuryCap<T0>, arg2: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::Account, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : StableVault<T0, T1, T2> {
        let v0 = StableVault<T0, T1, T2>{
            id                       : 0x2::object::new(arg4),
            abstract_account         : arg2,
            yield_usdb_balance       : 0x2::balance::zero<T2>(),
            lp_treasury_cap          : arg1,
            versions                 : 0x2::vec_set::singleton<u16>(package_version()),
            managers                 : 0x2::vec_set::singleton<address>(0x2::tx_context::sender(arg4)),
            instant_burn_permissions : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
            burn_requests            : 0x2::linked_table::new<0x2::object::ID, BurnRequest<T0>>(arg4),
            delay_ms                 : arg3,
        };
        let v1 = NewVault{
            vault_id : 0x2::object::id<StableVault<T0, T1, T2>>(&v0),
            lp_type  : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()),
            u_type   : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T1>()),
            y_type   : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T2>()),
        };
        0x2::event::emit<NewVault>(v1);
        v0
    }

    public fun abstract_account_address<T0, T1, T2>(arg0: &StableVault<T0, T1, T2>) : address {
        0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::account_address(&arg0.abstract_account)
    }

    public fun add_manager<T0, T1, T2>(arg0: &AdminCap, arg1: &mut StableVault<T0, T1, T2>, arg2: address) {
        assert_valid_package_version<T0, T1, T2>(arg1);
        0x2::vec_set::insert<address>(&mut arg1.managers, arg2);
    }

    public fun add_permission<T0, T1, T2, T3>(arg0: &AdminCap, arg1: &mut StableVault<T0, T1, T2>) {
        assert_valid_package_version<T0, T1, T2>(arg1);
        0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg1.instant_burn_permissions, 0x1::type_name::with_defining_ids<T3>());
    }

    public fun add_version<T0, T1, T2>(arg0: &AdminCap, arg1: &mut StableVault<T0, T1, T2>, arg2: u16) {
        0x2::vec_set::insert<u16>(&mut arg1.versions, arg2);
    }

    fun assert_sender_is_manager<T0, T1, T2>(arg0: &StableVault<T0, T1, T2>, arg1: &0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::AccountRequest) {
        let v0 = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::request_address(arg1);
        if (!0x2::vec_set::contains<address>(&arg0.managers, &v0)) {
            err_sender_is_not_manager();
        };
    }

    fun assert_valid_package_version<T0, T1, T2>(arg0: &StableVault<T0, T1, T2>) {
        let v0 = package_version();
        if (!0x2::vec_set::contains<u16>(&arg0.versions, &v0)) {
            err_invalid_package_version();
        };
    }

    fun borrow_request_mut<T0, T1, T2>(arg0: &mut StableVault<T0, T1, T2>, arg1: 0x2::object::ID) : &mut BurnRequest<T0> {
        if (!0x2::linked_table::contains<0x2::object::ID, BurnRequest<T0>>(&arg0.burn_requests, arg1)) {
            err_request_id_not_exists();
        };
        0x2::linked_table::borrow_mut<0x2::object::ID, BurnRequest<T0>>(&mut arg0.burn_requests, arg1)
    }

    public fun burn_request_data_expected_burn_time(arg0: &BurnRequestData) : u64 {
        arg0.expected_burn_time
    }

    public fun burn_request_data_is_burnable(arg0: &BurnRequestData) : bool {
        arg0.is_burnable
    }

    public fun burn_request_data_lp_amount_to_burn(arg0: &BurnRequestData) : u64 {
        arg0.lp_amount_to_burn
    }

    public fun burn_request_data_recipient(arg0: &BurnRequestData) : address {
        arg0.recipient
    }

    public fun burn_request_data_request_id(arg0: &BurnRequestData) : 0x2::object::ID {
        arg0.request_id
    }

    public fun burn_to_usdb<T0, T1, T2, T3>(arg0: &mut StableVault<T0, T1, T2>, arg1: &mut 0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::Treasury, arg2: &mut 0x872d08a70db3db498aa7853276acea8091fdd9871b2d86bc8dcb8524526df622::saving::SavingPool<T3>, arg3: &mut 0x203eebc39442014a1b8180f3b8ed70143dac2c5d28ba5703fe34c21052728705::yield_usdb::YieldVault<T2, T3>, arg4: &0x2::clock::Clock, arg5: 0x2::coin::Coin<T0>, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB>, 0x872d08a70db3db498aa7853276acea8091fdd9871b2d86bc8dcb8524526df622::saving::WithdrawResponse<T3>) {
        assert_valid_package_version<T0, T1, T2>(arg0);
        let (v0, v1) = burn_to_usdb_internal<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
        let v2 = v0;
        let v3 = Burn{
            vault_id   : 0x2::object::id<StableVault<T0, T1, T2>>(arg0),
            request_id : 0x1::option::none<0x2::object::ID>(),
            recipient  : 0x1::option::none<address>(),
            lp_type    : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()),
            lp_amount  : 0x2::coin::value<T0>(&arg5),
            u_type     : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB>()),
            u_amount   : 0x2::coin::value<0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB>(&v2),
        };
        0x2::event::emit<Burn>(v3);
        (v2, v1)
    }

    fun burn_to_usdb_internal<T0, T1, T2, T3>(arg0: &mut StableVault<T0, T1, T2>, arg1: &mut 0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::Treasury, arg2: &mut 0x872d08a70db3db498aa7853276acea8091fdd9871b2d86bc8dcb8524526df622::saving::SavingPool<T3>, arg3: &mut 0x203eebc39442014a1b8180f3b8ed70143dac2c5d28ba5703fe34c21052728705::yield_usdb::YieldVault<T2, T3>, arg4: &0x2::clock::Clock, arg5: 0x2::coin::Coin<T0>, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB>, 0x872d08a70db3db498aa7853276acea8091fdd9871b2d86bc8dcb8524526df622::saving::WithdrawResponse<T3>) {
        assert_valid_package_version<T0, T1, T2>(arg0);
        0x2::coin::burn<T0>(&mut arg0.lp_treasury_cap, arg5);
        0x203eebc39442014a1b8180f3b8ed70143dac2c5d28ba5703fe34c21052728705::yield_usdb::burn<T2, T3>(arg3, arg1, arg2, arg4, 0x2::coin::from_balance<T2>(0x2::balance::split<T2>(&mut arg0.yield_usdb_balance, 0x2::coin::value<T0>(&arg5)), arg6), arg6)
    }

    public fun cancel_burn<T0, T1, T2>(arg0: &mut StableVault<T0, T1, T2>, arg1: 0x2::object::ID, arg2: &0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::AccountRequest, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_valid_package_version<T0, T1, T2>(arg0);
        let v0 = &mut arg0.burn_requests;
        if (!0x2::linked_table::contains<0x2::object::ID, BurnRequest<T0>>(v0, arg1)) {
            err_request_id_not_exists();
        };
        let BurnRequest {
            recipient          : v1,
            lp_to_burn         : v2,
            expected_burn_time : _,
            is_burnable        : _,
        } = 0x2::linked_table::remove<0x2::object::ID, BurnRequest<T0>>(v0, arg1);
        let v5 = v2;
        if (v1 != 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::request_address(arg2)) {
            err_cannot_cancel();
        };
        let v6 = CancelBurn{
            vault_id   : 0x2::object::id<StableVault<T0, T1, T2>>(arg0),
            request_id : arg1,
            lp_type    : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()),
            lp_amount  : 0x2::balance::value<T0>(&v5),
        };
        0x2::event::emit<CancelBurn>(v6);
        0x2::coin::from_balance<T0>(v5, arg3)
    }

    public fun default_create<T0, T1, T2>(arg0: &AdminCap, arg1: 0x2::coin::TreasuryCap<T0>, arg2: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::Account, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_share_object<StableVault<T0, T1, T2>>(new<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4));
    }

    public fun default_destroy<T0, T1, T2>(arg0: &AdminCap, arg1: StableVault<T0, T1, T2>, arg2: &0x2::tx_context::TxContext) {
        let (v0, v1) = destroy<T0, T1, T2>(arg0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<T0>>(v0, 0x2::tx_context::sender(arg2));
        0x2::transfer::public_transfer<0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::Account>(v1, 0x2::tx_context::sender(arg2));
    }

    public fun delay_ms<T0, T1, T2>(arg0: &StableVault<T0, T1, T2>) : u64 {
        arg0.delay_ms
    }

    public fun destroy<T0, T1, T2>(arg0: &AdminCap, arg1: StableVault<T0, T1, T2>) : (0x2::coin::TreasuryCap<T0>, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::Account) {
        assert_valid_package_version<T0, T1, T2>(&arg1);
        let StableVault {
            id                       : v0,
            abstract_account         : v1,
            yield_usdb_balance       : v2,
            lp_treasury_cap          : v3,
            versions                 : _,
            managers                 : _,
            instant_burn_permissions : _,
            burn_requests            : v7,
            delay_ms                 : _,
        } = arg1;
        let v9 = v7;
        let v10 = v3;
        let v11 = v2;
        let v12 = if (0x2::balance::value<T2>(&v11) > 0) {
            true
        } else if (0x2::coin::total_supply<T0>(&v10) > 0) {
            true
        } else {
            !0x2::linked_table::is_empty<0x2::object::ID, BurnRequest<T0>>(&v9)
        };
        if (v12) {
            err_cannot_destroy_non_empty_vault();
        };
        0x2::object::delete(v0);
        0x2::linked_table::destroy_empty<0x2::object::ID, BurnRequest<T0>>(v9);
        0x2::balance::destroy_zero<T2>(v11);
        (v10, v1)
    }

    fun err_cannot_burn() {
        abort 5
    }

    fun err_cannot_cancel() {
        abort 6
    }

    fun err_cannot_destroy_non_empty_vault() {
        abort 3
    }

    fun err_cannot_request_burn_zero() {
        abort 7
    }

    fun err_invalid_package_version() {
        abort 0
    }

    fun err_not_allow_to_burn_instantly() {
        abort 2
    }

    fun err_request_id_not_exists() {
        abort 4
    }

    fun err_sender_is_not_manager() {
        abort 1
    }

    public fun exchange_rate<T0, T1>(arg0: &0x203eebc39442014a1b8180f3b8ed70143dac2c5d28ba5703fe34c21052728705::yield_usdb::YieldVault<T0, T1>, arg1: &0x872d08a70db3db498aa7853276acea8091fdd9871b2d86bc8dcb8524526df622::saving::SavingPool<T1>, arg2: &0x2::clock::Clock) : u256 {
        0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::to_scaled_val(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::from_fraction(0x203eebc39442014a1b8180f3b8ed70143dac2c5d28ba5703fe34c21052728705::yield_usdb::usdb_reserve<T0, T1>(arg0, arg1, arg2), 0x203eebc39442014a1b8180f3b8ed70143dac2c5d28ba5703fe34c21052728705::yield_usdb::lp_supply<T0, T1>(arg0)))
    }

    public fun execute_burn<T0, T1, T2, T3>(arg0: &mut StableVault<T0, T1, T2>, arg1: &mut 0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::Treasury, arg2: &mut 0xc2ae6693383e4a81285136effc8190c7baaf0e75aafa36d1c69cd2170cfc3803::pool::Pool<T1>, arg3: &mut 0x872d08a70db3db498aa7853276acea8091fdd9871b2d86bc8dcb8524526df622::saving::SavingPool<T3>, arg4: &mut 0x203eebc39442014a1b8180f3b8ed70143dac2c5d28ba5703fe34c21052728705::yield_usdb::YieldVault<T2, T3>, arg5: &0xf2ab9aa60c5e879675351a1a89f47131de9dea7cc927327dd0e7282e295c7f5e::result::PriceResult<T1>, arg6: &0x2::clock::Clock, arg7: &0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::AccountRequest, arg8: 0x2::object::ID, arg9: &mut 0x2::tx_context::TxContext) : 0x872d08a70db3db498aa7853276acea8091fdd9871b2d86bc8dcb8524526df622::saving::WithdrawResponse<T3> {
        assert_valid_package_version<T0, T1, T2>(arg0);
        assert_sender_is_manager<T0, T1, T2>(arg0, arg7);
        let v0 = &mut arg0.burn_requests;
        if (!0x2::linked_table::contains<0x2::object::ID, BurnRequest<T0>>(v0, arg8)) {
            err_request_id_not_exists();
        };
        let BurnRequest {
            recipient          : v1,
            lp_to_burn         : v2,
            expected_burn_time : v3,
            is_burnable        : v4,
        } = 0x2::linked_table::remove<0x2::object::ID, BurnRequest<T0>>(v0, arg8);
        let v5 = v2;
        if (!v4 || v3 > 0x2::clock::timestamp_ms(arg6)) {
            err_cannot_burn();
        };
        let v6 = 0x2::coin::from_balance<T0>(v5, arg9);
        let (v7, v8) = burn_to_usdb_internal<T0, T1, T2, T3>(arg0, arg1, arg3, arg4, arg6, v6, arg9);
        let v9 = 0x1::option::some<0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::AccountRequest>(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::request_with_account(&arg0.abstract_account));
        let v10 = 0xc2ae6693383e4a81285136effc8190c7baaf0e75aafa36d1c69cd2170cfc3803::pool::swap_out<T1>(arg2, arg1, arg5, v7, &v9, arg9);
        let v11 = Burn{
            vault_id   : 0x2::object::id<StableVault<T0, T1, T2>>(arg0),
            request_id : 0x1::option::some<0x2::object::ID>(arg8),
            recipient  : 0x1::option::some<address>(v1),
            lp_type    : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()),
            lp_amount  : 0x2::balance::value<T0>(&v5),
            u_type     : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T1>()),
            u_amount   : 0x2::coin::value<T1>(&v10),
        };
        0x2::event::emit<Burn>(v11);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v10, v1);
        v8
    }

    public fun get_burn_requests<T0, T1, T2>(arg0: &StableVault<T0, T1, T2>, arg1: 0x1::option::Option<0x2::object::ID>, arg2: u64) : (vector<BurnRequestData>, 0x1::option::Option<0x2::object::ID>) {
        let v0 = 0x1::vector::empty<BurnRequestData>();
        let v1 = &arg0.burn_requests;
        if (0x1::option::is_none<0x2::object::ID>(&arg1)) {
            arg1 = *0x2::linked_table::front<0x2::object::ID, BurnRequest<T0>>(v1);
        };
        let v2 = 0;
        while (0x1::option::is_some<0x2::object::ID>(&arg1) && v2 < arg2) {
            let v3 = *0x1::option::borrow<0x2::object::ID>(&arg1);
            let v4 = 0x2::linked_table::borrow<0x2::object::ID, BurnRequest<T0>>(v1, v3);
            let v5 = BurnRequestData{
                request_id         : v3,
                recipient          : v4.recipient,
                lp_amount_to_burn  : 0x2::balance::value<T0>(&v4.lp_to_burn),
                expected_burn_time : v4.expected_burn_time,
                is_burnable        : v4.is_burnable,
            };
            0x1::vector::push_back<BurnRequestData>(&mut v0, v5);
            v2 = v2 + 1;
            arg1 = *0x2::linked_table::next<0x2::object::ID, BurnRequest<T0>>(v1, v3);
        };
        (v0, arg1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun lp_total_supply<T0, T1, T2>(arg0: &StableVault<T0, T1, T2>) : u64 {
        0x2::coin::total_supply<T0>(&arg0.lp_treasury_cap)
    }

    fun package_version() : u16 {
        1
    }

    public fun remove_manager<T0, T1, T2>(arg0: &AdminCap, arg1: &mut StableVault<T0, T1, T2>, arg2: address) {
        assert_valid_package_version<T0, T1, T2>(arg1);
        0x2::vec_set::remove<address>(&mut arg1.managers, &arg2);
    }

    public fun remove_permission<T0, T1, T2, T3>(arg0: &AdminCap, arg1: &mut StableVault<T0, T1, T2>) {
        assert_valid_package_version<T0, T1, T2>(arg1);
        let v0 = 0x1::type_name::with_defining_ids<T3>();
        0x2::vec_set::remove<0x1::type_name::TypeName>(&mut arg1.instant_burn_permissions, &v0);
    }

    public fun remove_version<T0, T1, T2>(arg0: &AdminCap, arg1: &mut StableVault<T0, T1, T2>, arg2: u16) {
        0x2::vec_set::remove<u16>(&mut arg1.versions, &arg2);
    }

    public fun request_burn<T0, T1, T2>(arg0: &mut StableVault<T0, T1, T2>, arg1: &0x2::clock::Clock, arg2: 0x2::coin::Coin<T0>, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public fun request_to_burn<T0, T1, T2, T3>(arg0: &mut StableVault<T0, T1, T2>, arg1: &0x203eebc39442014a1b8180f3b8ed70143dac2c5d28ba5703fe34c21052728705::yield_usdb::YieldVault<T0, T3>, arg2: &0x872d08a70db3db498aa7853276acea8091fdd9871b2d86bc8dcb8524526df622::saving::SavingPool<T3>, arg3: &0x2::clock::Clock, arg4: 0x2::coin::Coin<T0>, arg5: address, arg6: &mut 0x2::tx_context::TxContext) {
        assert_valid_package_version<T0, T1, T2>(arg0);
        let v0 = 0x2::object::new(arg6);
        let v1 = 0x2::object::uid_to_inner(&v0);
        0x2::object::delete(v0);
        let v2 = 0x2::coin::value<T0>(&arg4);
        if (v2 == 0) {
            err_cannot_request_burn_zero();
        };
        let v3 = 0x2::clock::timestamp_ms(arg3) + delay_ms<T0, T1, T2>(arg0);
        let v4 = BurnRequest<T0>{
            recipient          : arg5,
            lp_to_burn         : 0x2::coin::into_balance<T0>(arg4),
            expected_burn_time : v3,
            is_burnable        : true,
        };
        0x2::linked_table::push_back<0x2::object::ID, BurnRequest<T0>>(&mut arg0.burn_requests, v1, v4);
        let v5 = RequestToBurn{
            vault_id           : 0x2::object::id<StableVault<T0, T1, T2>>(arg0),
            request_id         : v1,
            recipient          : arg5,
            lp_type            : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()),
            lp_amount          : v2,
            u_amount           : 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::ceil(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::mul_u64(0x203eebc39442014a1b8180f3b8ed70143dac2c5d28ba5703fe34c21052728705::yield_usdb::burn_ratio<T0, T3>(arg1, arg2, arg3), v2)),
            expected_burn_time : v3,
        };
        0x2::event::emit<RequestToBurn>(v5);
    }

    public fun set_burnable<T0, T1, T2>(arg0: &mut StableVault<T0, T1, T2>, arg1: &0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::AccountRequest, arg2: 0x2::object::ID, arg3: bool) {
        assert_valid_package_version<T0, T1, T2>(arg0);
        assert_sender_is_manager<T0, T1, T2>(arg0, arg1);
        borrow_request_mut<T0, T1, T2>(arg0, arg2).is_burnable = arg3;
    }

    public fun set_delay_ms<T0, T1, T2>(arg0: &AdminCap, arg1: &mut StableVault<T0, T1, T2>, arg2: u64) {
        assert_valid_package_version<T0, T1, T2>(arg1);
        arg1.delay_ms = arg2;
    }

    // decompiled from Move bytecode v6
}

