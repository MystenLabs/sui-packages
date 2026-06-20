module 0x3189f9bc40b1a5237ce0474826491d5211c6230b687631ca2ec4d7c9a1f573c4::adaptor {
    struct BucketAdaptor has drop {
        dummy_field: bool,
    }

    struct BucketBorrowed has copy, drop {
        account: address,
        collateral_in: u64,
        usdb_out: u64,
    }

    struct BucketSavingDeposited has copy, drop {
        account: address,
        usdb_in: u64,
    }

    struct BucketSavingWithdrawn has copy, drop {
        account: address,
        usdb_out: u64,
    }

    struct BucketAccountCreated has copy, drop {
        wallet_id: 0x2::object::ID,
        account: address,
    }

    struct BucketAccountReclaimed has copy, drop {
        wallet_id: 0x2::object::ID,
        account: address,
    }

    fun assert_account(arg0: &0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::Account, arg1: address) {
        assert!(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::account_address(arg0) == arg1, 1);
    }

    fun assert_bucket_operator(arg0: &0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::Wallet, arg1: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        if (v0 == 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::owner(arg0)) {
            return
        };
        assert!(0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::delegate::service_allowance<BucketAdaptor>(arg0, v0) > 0, 3);
    }

    public fun borrow_usdb<T0>(arg0: &mut 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::Wallet, arg1: &0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::Account, arg2: address, arg3: &mut 0x9f835c21d21f8ce519fec17d679cd38243ef2643ad879e7048ba77374be4036e::vault::Vault<T0>, arg4: &mut 0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::Treasury, arg5: &0x1::option::Option<0xf2ab9aa60c5e879675351a1a89f47131de9dea7cc927327dd0e7282e295c7f5e::result::PriceResult<T0>>, arg6: u64, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(arg7 > 0, 0);
        assert_account(arg1, arg2);
        0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::assert_external_account_bound_or_owner<BucketAdaptor>(arg0, arg2, arg10);
        let v0 = BucketAdaptor{dummy_field: false};
        let (v1, v2) = 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::intent::validate_and_swap_out<BucketAdaptor, T0, 0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB>(arg0, 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::intent::request_swap<BucketAdaptor, T0, 0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB>(v0, arg6, arg8), arg10);
        let v3 = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::request_with_account(arg1);
        let (v4, v5, v6) = 0x9f835c21d21f8ce519fec17d679cd38243ef2643ad879e7048ba77374be4036e::vault::update_position<T0>(arg3, arg4, arg9, arg5, 0x9f835c21d21f8ce519fec17d679cd38243ef2643ad879e7048ba77374be4036e::vault::debtor_request<T0>(arg3, &v3, arg4, v1, arg7, 0x2::coin::zero<0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB>(arg10), 0), arg10);
        let v7 = v5;
        0x9f835c21d21f8ce519fec17d679cd38243ef2643ad879e7048ba77374be4036e::vault::destroy_response<T0>(arg3, arg4, v6);
        let v8 = 0x2::coin::value<0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB>(&v7);
        let v9 = BucketAdaptor{dummy_field: false};
        0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::intent::verify_swap_and_credit<BucketAdaptor, T0, 0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB>(arg0, v2, 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::intent::create_swap_receipt<BucketAdaptor, T0, 0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB>(v9, arg6, v8), v7);
        let v10 = BucketAdaptor{dummy_field: false};
        credit_or_destroy_coin<BucketAdaptor, T0>(arg0, v4, v10);
        let v11 = BucketBorrowed{
            account       : arg2,
            collateral_in : arg6,
            usdb_out      : v8,
        };
        0x2::event::emit<BucketBorrowed>(v11);
    }

    public fun borrow_usdb_from_position<T0>(arg0: &mut 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::Wallet, arg1: &0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::Account, arg2: address, arg3: &mut 0x9f835c21d21f8ce519fec17d679cd38243ef2643ad879e7048ba77374be4036e::vault::Vault<T0>, arg4: &mut 0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::Treasury, arg5: &0x1::option::Option<0xf2ab9aa60c5e879675351a1a89f47131de9dea7cc927327dd0e7282e295c7f5e::result::PriceResult<T0>>, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(arg6 > 0, 0);
        assert_account(arg1, arg2);
        0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::assert_external_account_bound_or_owner<BucketAdaptor>(arg0, arg2, arg9);
        let v0 = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::request_with_account(arg1);
        let (v1, v2, v3) = 0x9f835c21d21f8ce519fec17d679cd38243ef2643ad879e7048ba77374be4036e::vault::update_position<T0>(arg3, arg4, arg8, arg5, 0x9f835c21d21f8ce519fec17d679cd38243ef2643ad879e7048ba77374be4036e::vault::debtor_request<T0>(arg3, &v0, arg4, 0x2::coin::zero<T0>(arg9), arg6, 0x2::coin::zero<0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB>(arg9), 0), arg9);
        let v4 = v2;
        0x9f835c21d21f8ce519fec17d679cd38243ef2643ad879e7048ba77374be4036e::vault::destroy_response<T0>(arg3, arg4, v3);
        let v5 = 0x2::coin::value<0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB>(&v4);
        assert!(v5 >= arg7, 2);
        let v6 = BucketAdaptor{dummy_field: false};
        0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::receive_from_service<BucketAdaptor, 0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB>(arg0, v4, v6);
        let v7 = BucketAdaptor{dummy_field: false};
        credit_or_destroy_coin<BucketAdaptor, T0>(arg0, v1, v7);
        let v8 = BucketBorrowed{
            account       : arg2,
            collateral_in : 0,
            usdb_out      : v5,
        };
        0x2::event::emit<BucketBorrowed>(v8);
    }

    public fun borrow_usdb_from_stored_position<T0>(arg0: &mut 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::Wallet, arg1: &mut 0x9f835c21d21f8ce519fec17d679cd38243ef2643ad879e7048ba77374be4036e::vault::Vault<T0>, arg2: &mut 0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::Treasury, arg3: &0x1::option::Option<0xf2ab9aa60c5e879675351a1a89f47131de9dea7cc927327dd0e7282e295c7f5e::result::PriceResult<T0>>, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert_bucket_operator(arg0, arg7);
        let v0 = take_bucket_account(arg0);
        borrow_usdb_from_position<T0>(arg0, &v0, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::account_address(&v0), arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        put_bucket_account(arg0, v0);
    }

    public fun borrow_usdb_with_stored_account<T0>(arg0: &mut 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::Wallet, arg1: &mut 0x9f835c21d21f8ce519fec17d679cd38243ef2643ad879e7048ba77374be4036e::vault::Vault<T0>, arg2: &mut 0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::Treasury, arg3: &0x1::option::Option<0xf2ab9aa60c5e879675351a1a89f47131de9dea7cc927327dd0e7282e295c7f5e::result::PriceResult<T0>>, arg4: u64, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = take_bucket_account(arg0);
        borrow_usdb<T0>(arg0, &v0, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::account_address(&v0), arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
        put_bucket_account(arg0, v0);
    }

    fun bucket_account_name() : 0x1::string::String {
        0x1::string::utf8(b"bucket_account")
    }

    public fun create_bucket_account(arg0: &mut 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::Wallet, arg1: 0x1::option::Option<0x1::string::String>, arg2: &mut 0x2::tx_context::TxContext) : address {
        assert_bucket_operator(arg0, arg2);
        let v0 = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::new(arg1, arg2);
        let v1 = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::account_address(&v0);
        let v2 = BucketAdaptor{dummy_field: false};
        0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::bind_external_account_from_service<BucketAdaptor>(arg0, v1, v2);
        put_bucket_account(arg0, v0);
        let v3 = BucketAccountCreated{
            wallet_id : 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::id(arg0),
            account   : v1,
        };
        0x2::event::emit<BucketAccountCreated>(v3);
        v1
    }

    fun credit_or_destroy_coin<T0: drop, T1>(arg0: &0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::Wallet, arg1: 0x2::coin::Coin<T1>, arg2: T0) {
        if (0x2::coin::value<T1>(&arg1) == 0) {
            0x2::coin::destroy_zero<T1>(arg1);
        } else {
            0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::receive_from_service<T0, T1>(arg0, arg1, arg2);
        };
    }

    fun put_bucket_account(arg0: &mut 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::Wallet, arg1: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::Account) {
        let v0 = BucketAdaptor{dummy_field: false};
        0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::receive_asset_from_service<BucketAdaptor, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::Account>(arg0, arg1, bucket_account_name(), v0);
    }

    public fun reclaim_bucket_account(arg0: &mut 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::Wallet, arg1: &mut 0x2::tx_context::TxContext) : 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::Account {
        assert!(0x2::tx_context::sender(arg1) == 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::owner(arg0), 3);
        let v0 = take_bucket_account(arg0);
        let v1 = BucketAccountReclaimed{
            wallet_id : 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::id(arg0),
            account   : 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::account_address(&v0),
        };
        0x2::event::emit<BucketAccountReclaimed>(v1);
        v0
    }

    public fun save_usdb<T0>(arg0: &mut 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::Wallet, arg1: &0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::Account, arg2: address, arg3: &mut 0x872d08a70db3db498aa7853276acea8091fdd9871b2d86bc8dcb8524526df622::saving::SavingPool<T0>, arg4: &mut 0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::Treasury, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg5 > 0, 0);
        assert_account(arg1, arg2);
        0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::assert_external_account_bound_or_owner<BucketAdaptor>(arg0, arg2, arg7);
        let v0 = BucketAdaptor{dummy_field: false};
        let (v1, v2) = 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::intent::validate_and_pay<BucketAdaptor, 0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB>(arg0, 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::intent::request_payment<BucketAdaptor, 0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB>(v0, arg5, arg2), arg7);
        let v3 = 0x872d08a70db3db498aa7853276acea8091fdd9871b2d86bc8dcb8524526df622::saving::deposit<T0>(arg3, arg4, arg2, v1, arg6, arg7);
        let v4 = BucketAdaptor{dummy_field: false};
        0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::intent::verify_and_clear<BucketAdaptor, 0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB>(v2, 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::intent::create_receipt_sig<BucketAdaptor, 0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB>(v4, arg5, arg2));
        0x872d08a70db3db498aa7853276acea8091fdd9871b2d86bc8dcb8524526df622::saving::check_deposit_response<T0>(v3, arg3, arg4);
        let v5 = BucketSavingDeposited{
            account : arg2,
            usdb_in : 0x872d08a70db3db498aa7853276acea8091fdd9871b2d86bc8dcb8524526df622::saving::deposit_response_deposited_usdb_amount<T0>(&v3),
        };
        0x2::event::emit<BucketSavingDeposited>(v5);
    }

    public fun save_usdb_with_incentive<T0, T1>(arg0: &mut 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::Wallet, arg1: &0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::Account, arg2: address, arg3: &mut 0x872d08a70db3db498aa7853276acea8091fdd9871b2d86bc8dcb8524526df622::saving::SavingPool<T0>, arg4: &mut 0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::Treasury, arg5: &0x39692320d6fc01c27315a7972ed4717e4fd32eed43531ad6f55fd7f24b74e207::incentive_config::GlobalConfig, arg6: &mut 0x39692320d6fc01c27315a7972ed4717e4fd32eed43531ad6f55fd7f24b74e207::saving_incentive::RewardManager<T0>, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(arg7 > 0, 0);
        assert_account(arg1, arg2);
        0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::assert_external_account_bound_or_owner<BucketAdaptor>(arg0, arg2, arg9);
        let v0 = BucketAdaptor{dummy_field: false};
        let (v1, v2) = 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::intent::validate_and_pay<BucketAdaptor, 0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB>(arg0, 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::intent::request_payment<BucketAdaptor, 0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB>(v0, arg7, arg2), arg9);
        let v3 = 0x872d08a70db3db498aa7853276acea8091fdd9871b2d86bc8dcb8524526df622::saving::deposit<T0>(arg3, arg4, arg2, v1, arg8, arg9);
        let v4 = 0x39692320d6fc01c27315a7972ed4717e4fd32eed43531ad6f55fd7f24b74e207::saving_incentive::new_checker_for_deposit_action<T0>(arg6, arg5, v3);
        0x39692320d6fc01c27315a7972ed4717e4fd32eed43531ad6f55fd7f24b74e207::saving_incentive::update_deposit_action<T0, T1>(&mut v4, arg5, arg6, arg3, arg8);
        let v5 = BucketAdaptor{dummy_field: false};
        0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::intent::verify_and_clear<BucketAdaptor, 0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB>(v2, 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::intent::create_receipt_sig<BucketAdaptor, 0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB>(v5, arg7, arg2));
        0x872d08a70db3db498aa7853276acea8091fdd9871b2d86bc8dcb8524526df622::saving::check_deposit_response<T0>(0x39692320d6fc01c27315a7972ed4717e4fd32eed43531ad6f55fd7f24b74e207::saving_incentive::destroy_deposit_checker<T0>(v4, arg5), arg3, arg4);
        let v6 = BucketSavingDeposited{
            account : arg2,
            usdb_in : 0x872d08a70db3db498aa7853276acea8091fdd9871b2d86bc8dcb8524526df622::saving::deposit_response_deposited_usdb_amount<T0>(&v3),
        };
        0x2::event::emit<BucketSavingDeposited>(v6);
    }

    public fun save_usdb_with_stored_account<T0>(arg0: &mut 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::Wallet, arg1: &mut 0x872d08a70db3db498aa7853276acea8091fdd9871b2d86bc8dcb8524526df622::saving::SavingPool<T0>, arg2: &mut 0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::Treasury, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = take_bucket_account(arg0);
        save_usdb<T0>(arg0, &v0, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::account_address(&v0), arg1, arg2, arg3, arg4, arg5);
        put_bucket_account(arg0, v0);
    }

    public fun save_usdb_with_stored_account_and_incentive<T0, T1>(arg0: &mut 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::Wallet, arg1: &mut 0x872d08a70db3db498aa7853276acea8091fdd9871b2d86bc8dcb8524526df622::saving::SavingPool<T0>, arg2: &mut 0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::Treasury, arg3: &0x39692320d6fc01c27315a7972ed4717e4fd32eed43531ad6f55fd7f24b74e207::incentive_config::GlobalConfig, arg4: &mut 0x39692320d6fc01c27315a7972ed4717e4fd32eed43531ad6f55fd7f24b74e207::saving_incentive::RewardManager<T0>, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = take_bucket_account(arg0);
        save_usdb_with_incentive<T0, T1>(arg0, &v0, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::account_address(&v0), arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        put_bucket_account(arg0, v0);
    }

    fun take_bucket_account(arg0: &mut 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::Wallet) : 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::Account {
        let v0 = BucketAdaptor{dummy_field: false};
        0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::take_asset_for_service<BucketAdaptor, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::Account>(arg0, bucket_account_name(), v0)
    }

    public fun withdraw_saving<T0>(arg0: &mut 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::Wallet, arg1: &0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::Account, arg2: address, arg3: &mut 0x872d08a70db3db498aa7853276acea8091fdd9871b2d86bc8dcb8524526df622::saving::SavingPool<T0>, arg4: &mut 0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::Treasury, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(arg5 > 0, 0);
        assert_account(arg1, arg2);
        0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::assert_external_account_bound_or_owner<BucketAdaptor>(arg0, arg2, arg8);
        let v0 = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::request_with_account(arg1);
        let (v1, v2) = 0x872d08a70db3db498aa7853276acea8091fdd9871b2d86bc8dcb8524526df622::saving::withdraw<T0>(arg3, arg4, &v0, arg5, arg7, arg8);
        let v3 = v1;
        let v4 = 0x2::coin::value<0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB>(&v3);
        assert!(v4 >= arg6, 2);
        0x872d08a70db3db498aa7853276acea8091fdd9871b2d86bc8dcb8524526df622::saving::check_withdraw_response<T0>(v2, arg3, arg4);
        let v5 = BucketAdaptor{dummy_field: false};
        0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::receive_from_service<BucketAdaptor, 0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB>(arg0, v3, v5);
        let v6 = BucketSavingWithdrawn{
            account  : arg2,
            usdb_out : v4,
        };
        0x2::event::emit<BucketSavingWithdrawn>(v6);
    }

    public fun withdraw_saving_with_incentive<T0, T1>(arg0: &mut 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::Wallet, arg1: &0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::Account, arg2: address, arg3: &mut 0x872d08a70db3db498aa7853276acea8091fdd9871b2d86bc8dcb8524526df622::saving::SavingPool<T0>, arg4: &mut 0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::Treasury, arg5: &0x39692320d6fc01c27315a7972ed4717e4fd32eed43531ad6f55fd7f24b74e207::incentive_config::GlobalConfig, arg6: &mut 0x39692320d6fc01c27315a7972ed4717e4fd32eed43531ad6f55fd7f24b74e207::saving_incentive::RewardManager<T0>, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(arg7 > 0, 0);
        assert_account(arg1, arg2);
        0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::assert_external_account_bound_or_owner<BucketAdaptor>(arg0, arg2, arg10);
        let v0 = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::request_with_account(arg1);
        let (v1, v2) = 0x872d08a70db3db498aa7853276acea8091fdd9871b2d86bc8dcb8524526df622::saving::withdraw<T0>(arg3, arg4, &v0, arg7, arg9, arg10);
        let v3 = v1;
        let v4 = 0x2::coin::value<0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB>(&v3);
        assert!(v4 >= arg8, 2);
        let v5 = 0x39692320d6fc01c27315a7972ed4717e4fd32eed43531ad6f55fd7f24b74e207::saving_incentive::new_checker_for_withdraw_action<T0>(arg6, arg5, v2);
        0x39692320d6fc01c27315a7972ed4717e4fd32eed43531ad6f55fd7f24b74e207::saving_incentive::update_withdraw_action<T0, T1>(&mut v5, arg5, arg6, arg3, arg9);
        0x872d08a70db3db498aa7853276acea8091fdd9871b2d86bc8dcb8524526df622::saving::check_withdraw_response<T0>(0x39692320d6fc01c27315a7972ed4717e4fd32eed43531ad6f55fd7f24b74e207::saving_incentive::destroy_withdraw_checker<T0>(v5, arg5), arg3, arg4);
        let v6 = BucketAdaptor{dummy_field: false};
        0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::receive_from_service<BucketAdaptor, 0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB>(arg0, v3, v6);
        let v7 = BucketSavingWithdrawn{
            account  : arg2,
            usdb_out : v4,
        };
        0x2::event::emit<BucketSavingWithdrawn>(v7);
    }

    public fun withdraw_saving_with_stored_account<T0>(arg0: &mut 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::Wallet, arg1: &mut 0x872d08a70db3db498aa7853276acea8091fdd9871b2d86bc8dcb8524526df622::saving::SavingPool<T0>, arg2: &mut 0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::Treasury, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert_bucket_operator(arg0, arg6);
        let v0 = take_bucket_account(arg0);
        withdraw_saving<T0>(arg0, &v0, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::account_address(&v0), arg1, arg2, arg3, arg4, arg5, arg6);
        put_bucket_account(arg0, v0);
    }

    public fun withdraw_saving_with_stored_account_and_incentive<T0, T1>(arg0: &mut 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::Wallet, arg1: &mut 0x872d08a70db3db498aa7853276acea8091fdd9871b2d86bc8dcb8524526df622::saving::SavingPool<T0>, arg2: &mut 0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::Treasury, arg3: &0x39692320d6fc01c27315a7972ed4717e4fd32eed43531ad6f55fd7f24b74e207::incentive_config::GlobalConfig, arg4: &mut 0x39692320d6fc01c27315a7972ed4717e4fd32eed43531ad6f55fd7f24b74e207::saving_incentive::RewardManager<T0>, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert_bucket_operator(arg0, arg8);
        let v0 = take_bucket_account(arg0);
        withdraw_saving_with_incentive<T0, T1>(arg0, &v0, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::account_address(&v0), arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
        put_bucket_account(arg0, v0);
    }

    // decompiled from Move bytecode v7
}

