module 0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::bucket_adapter {
    struct BucketProtocolBorrowRequest {
        dummy_field: bool,
    }

    struct BucketProtocolDepositRequest {
        dummy_field: bool,
    }

    struct BucketProtocolRepayRequest {
        dummy_field: bool,
    }

    struct BucketProtocolWithdrawRequest {
        dummy_field: bool,
    }

    struct BucketProtocolClaimRequest {
        dummy_field: bool,
    }

    struct BucketProtocolDepositReceipt {
        info: 0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::receipt::SingleAssetReceipt,
    }

    struct BucketProtocolWithdrawReceipt {
        info: 0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::receipt::MultiAssetReceipt,
    }

    struct BucketProtocolBorrowReceipt {
        info: 0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::receipt::SingleAssetReceipt,
    }

    struct BucketProtocolRepayReceipt {
        info: 0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::receipt::SingleAssetReceipt,
    }

    struct BucketProtocolClaimReceipt {
        info: 0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::receipt::MultiAssetReceipt,
    }

    public fun borrow_receipt_amount(arg0: &BucketProtocolBorrowReceipt) : u64 {
        0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::receipt::single_asset_receipt_amount(arg0.info)
    }

    public fun borrow_receipt_asset_type(arg0: &BucketProtocolBorrowReceipt) : 0x1::type_name::TypeName {
        0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::receipt::single_asset_receipt_asset_type(arg0.info)
    }

    public fun borrow_receipt_vault_id(arg0: &BucketProtocolBorrowReceipt) : 0x2::object::ID {
        0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::receipt::single_asset_receipt_vault_id(arg0.info)
    }

    public fun claim(arg0: &mut 0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::collector::Collector, arg1: BucketProtocolRepayRequest, arg2: &0x2::clock::Clock, arg3: &mut 0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::Fountain<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) : (0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::collector::Collector, BucketProtocolClaimReceipt) {
        let v0 = 0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::collector::vault_id(arg0);
        let v1 = 0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::collector::extract_asset_map_mut<BucketProtocolRepayRequest>(arg0, &arg1);
        let v2 = 0x1::type_name::get<0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::StakeProof<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>>();
        let (_, v4) = 0x2::vec_map::remove<0x1::type_name::TypeName, 0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::collector::Item>(v1, &v2);
        let v5 = 0x2::vec_map::keys<0x1::type_name::TypeName, 0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::collector::Item>(v1);
        if (0x1::vector::length<0x1::type_name::TypeName>(&v5) > 0) {
            err_remaining_unused_asset();
        };
        let v6 = 0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::collector::extract_inner_asset<0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::StakeProof<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>>(v4);
        let v7 = 0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::claim<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>(arg2, arg3, &mut v6);
        drop_repay_request(arg1);
        let v8 = 0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::collector::new(v0);
        let v9 = new_claim_receipt(v0);
        let v10 = &mut v9;
        fill_claim_receipt<0x2::sui::SUI>(v10, &v6, &v7);
        0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::collector::collect_asset<0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::StakeProof<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>, BucketProtocolClaimReceipt>(&mut v8, &v9, v6, arg4);
        0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::collector::collect_asset<0x2::balance::Balance<0x2::sui::SUI>, BucketProtocolClaimReceipt>(&mut v8, &v9, v7, arg4);
        (v8, v9)
    }

    public fun claim_receipt_amounts(arg0: &BucketProtocolClaimReceipt) : vector<u64> {
        0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::receipt::multiple_asset_receipt_amounts(arg0.info)
    }

    public fun claim_receipt_asset_types(arg0: &BucketProtocolClaimReceipt) : vector<0x1::type_name::TypeName> {
        0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::receipt::multiple_asset_receipt_asset_type(arg0.info)
    }

    public fun claim_receipt_vault_id(arg0: &BucketProtocolClaimReceipt) : 0x2::object::ID {
        0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::receipt::multiple_asset_receipt_vault_id(arg0.info)
    }

    public fun collateral_and_borrow<T0>(arg0: &mut 0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::collector::Collector, arg1: BucketProtocolBorrowRequest, arg2: &mut 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BucketProtocol, arg3: &0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::bucket_oracle::BucketOracle, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::collector::Collector, BucketProtocolBorrowReceipt) {
        let v0 = 0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::collector::vault_id(arg0);
        let v1 = 0x1::type_name::get<0x2::balance::Balance<T0>>();
        let (_, v3) = 0x2::vec_map::remove<0x1::type_name::TypeName, 0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::collector::Item>(0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::collector::extract_asset_map_mut<BucketProtocolBorrowRequest>(arg0, &arg1), &v1);
        let v4 = 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::borrow<T0>(arg2, arg3, arg5, 0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::collector::extract_inner_asset<0x2::balance::Balance<T0>>(v3), arg4, 0x1::option::none<address>(), arg6);
        drop_borrow_request(arg1);
        let v5 = 0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::collector::new(v0);
        let v6 = new_borrow_receipt<T0>(v0);
        let v7 = &mut v6;
        fill_borrow_receipt<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(v7, &v4);
        0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::collector::collect_asset<0x2::balance::Balance<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>, BucketProtocolBorrowReceipt>(&mut v5, &v6, v4, arg6);
        (v5, v6)
    }

    public fun deposit(arg0: &mut 0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::collector::Collector, arg1: BucketProtocolDepositRequest, arg2: &mut 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BucketProtocol, arg3: &mut 0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::Flask<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>, arg4: &mut 0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::Fountain<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::collector::Collector, BucketProtocolDepositReceipt) {
        let v0 = 0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::collector::vault_id(arg0);
        let v1 = 0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::collector::extract_asset_map_mut<BucketProtocolDepositRequest>(arg0, &arg1);
        let v2 = 0x1::type_name::get<0x2::balance::Balance<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>>();
        let (_, v4) = 0x2::vec_map::remove<0x1::type_name::TypeName, 0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::collector::Item>(v1, &v2);
        let v5 = 0x2::vec_map::keys<0x1::type_name::TypeName, 0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::collector::Item>(v1);
        if (0x1::vector::length<0x1::type_name::TypeName>(&v5) > 0) {
            err_remaining_unused_asset();
        };
        let (_, v7) = 0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::get_lock_time_range<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>(arg4);
        let v8 = 0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::stake<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>(arg5, arg4, 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::buck_to_sbuck(arg2, arg3, arg5, 0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::collector::extract_inner_asset<0x2::balance::Balance<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>>(v4)), v7, arg6);
        drop_deposit_request(arg1);
        let v9 = 0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::collector::new(v0);
        let v10 = new_deposit_receipt(v0);
        let v11 = &mut v10;
        fill_deposit_receipt(v11, &v8);
        0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::collector::collect_asset<0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::StakeProof<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>, BucketProtocolDepositReceipt>(&mut v9, &v10, v8, arg6);
        (v9, v10)
    }

    public fun deposit_receipt_amount(arg0: &BucketProtocolDepositReceipt) : u64 {
        0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::receipt::single_asset_receipt_amount(arg0.info)
    }

    public fun deposit_receipt_asset_type(arg0: &BucketProtocolDepositReceipt) : 0x1::type_name::TypeName {
        0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::receipt::single_asset_receipt_asset_type(arg0.info)
    }

    public fun deposit_receipt_vault_id(arg0: &BucketProtocolDepositReceipt) : 0x2::object::ID {
        0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::receipt::single_asset_receipt_vault_id(arg0.info)
    }

    public(friend) fun drop_borrow_receipt(arg0: BucketProtocolBorrowReceipt) {
        let BucketProtocolBorrowReceipt {  } = arg0;
    }

    public(friend) fun drop_borrow_request(arg0: BucketProtocolBorrowRequest) {
        let BucketProtocolBorrowRequest {  } = arg0;
    }

    public(friend) fun drop_claim_receipt(arg0: BucketProtocolClaimReceipt) {
        let BucketProtocolClaimReceipt { info: v0 } = arg0;
        0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::receipt::drop_multiple_receipt(v0);
    }

    public(friend) fun drop_claim_request(arg0: BucketProtocolClaimRequest) {
        let BucketProtocolClaimRequest {  } = arg0;
    }

    public(friend) fun drop_deposit_receipt(arg0: BucketProtocolDepositReceipt) {
        let BucketProtocolDepositReceipt { info: v0 } = arg0;
        0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::receipt::drop_single_receipt(v0);
    }

    public(friend) fun drop_deposit_request(arg0: BucketProtocolDepositRequest) {
        let BucketProtocolDepositRequest {  } = arg0;
    }

    public(friend) fun drop_repay_receipt(arg0: BucketProtocolRepayReceipt) {
        let BucketProtocolRepayReceipt {  } = arg0;
    }

    public(friend) fun drop_repay_request(arg0: BucketProtocolRepayRequest) {
        let BucketProtocolRepayRequest {  } = arg0;
    }

    public(friend) fun drop_withdraw_receipt(arg0: BucketProtocolWithdrawReceipt) {
        let BucketProtocolWithdrawReceipt { info: v0 } = arg0;
        0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::receipt::drop_multiple_receipt(v0);
    }

    public(friend) fun drop_withdraw_request(arg0: BucketProtocolWithdrawRequest) {
        let BucketProtocolWithdrawRequest {  } = arg0;
    }

    fun err_remaining_unused_asset() {
        abort 1000
    }

    public(friend) fun fill_borrow_receipt<T0>(arg0: &mut BucketProtocolBorrowReceipt, arg1: &0x2::balance::Balance<T0>) {
        0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::receipt::set_single_receipt_amount(&mut arg0.info, 0x2::balance::value<T0>(arg1));
    }

    public(friend) fun fill_claim_receipt<T0>(arg0: &mut BucketProtocolClaimReceipt, arg1: &0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::StakeProof<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, T0>, arg2: &0x2::balance::Balance<T0>) {
        0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::receipt::add_multiple_receipt_amount(&mut arg0.info, 0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::get_proof_stake_amount<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, T0>(arg1));
        0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::receipt::add_multiple_receipt_amount(&mut arg0.info, 0x2::balance::value<T0>(arg2));
        0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::receipt::add_multiple_receipt_asset_type(&mut arg0.info, 0x1::type_name::get<0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::StakeProof<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, T0>>());
        0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::receipt::add_multiple_receipt_asset_type(&mut arg0.info, 0x1::type_name::get<0x2::balance::Balance<T0>>());
    }

    public(friend) fun fill_deposit_receipt(arg0: &mut BucketProtocolDepositReceipt, arg1: &0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::StakeProof<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>) {
        0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::receipt::set_single_receipt_amount(&mut arg0.info, 0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::get_proof_stake_amount<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>(arg1));
    }

    public(friend) fun fill_repay_receipt<T0>(arg0: &mut BucketProtocolRepayReceipt, arg1: &0x2::balance::Balance<T0>) {
        0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::receipt::set_single_receipt_amount(&mut arg0.info, 0x2::balance::value<T0>(arg1));
    }

    public(friend) fun fill_withdraw_receipt<T0, T1>(arg0: &mut BucketProtocolWithdrawReceipt, arg1: &0x2::balance::Balance<T0>, arg2: &0x2::balance::Balance<T1>) {
        0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::receipt::add_multiple_receipt_amount(&mut arg0.info, 0x2::balance::value<T0>(arg1));
        0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::receipt::add_multiple_receipt_amount(&mut arg0.info, 0x2::balance::value<T1>(arg2));
        0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::receipt::add_multiple_receipt_asset_type(&mut arg0.info, 0x1::type_name::get<0x2::balance::Balance<T0>>());
        0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::receipt::add_multiple_receipt_asset_type(&mut arg0.info, 0x1::type_name::get<0x2::balance::Balance<T1>>());
    }

    public(friend) fun new_borrow_receipt<T0>(arg0: 0x2::object::ID) : BucketProtocolBorrowReceipt {
        BucketProtocolBorrowReceipt{info: 0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::receipt::new_single_asset_receipt(arg0, 0x1::type_name::get<0x2::balance::Balance<T0>>(), 0x1::option::none<u64>())}
    }

    public(friend) fun new_borrow_request() : BucketProtocolBorrowRequest {
        BucketProtocolBorrowRequest{dummy_field: false}
    }

    public(friend) fun new_claim_receipt(arg0: 0x2::object::ID) : BucketProtocolClaimReceipt {
        BucketProtocolClaimReceipt{info: 0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::receipt::new_multiple_asset_receipt(arg0, 0x1::option::none<vector<0x1::type_name::TypeName>>(), 0x1::option::none<vector<u64>>())}
    }

    public(friend) fun new_claim_request() : BucketProtocolClaimRequest {
        BucketProtocolClaimRequest{dummy_field: false}
    }

    public(friend) fun new_deposit_receipt(arg0: 0x2::object::ID) : BucketProtocolDepositReceipt {
        BucketProtocolDepositReceipt{info: 0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::receipt::new_single_asset_receipt(arg0, 0x1::type_name::get<0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::StakeProof<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>>(), 0x1::option::none<u64>())}
    }

    public(friend) fun new_deposit_request() : BucketProtocolDepositRequest {
        BucketProtocolDepositRequest{dummy_field: false}
    }

    public(friend) fun new_repay_receipt<T0>(arg0: 0x2::object::ID) : BucketProtocolRepayReceipt {
        BucketProtocolRepayReceipt{info: 0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::receipt::new_single_asset_receipt(arg0, 0x1::type_name::get<0x2::balance::Balance<T0>>(), 0x1::option::none<u64>())}
    }

    public(friend) fun new_repay_request() : BucketProtocolRepayRequest {
        BucketProtocolRepayRequest{dummy_field: false}
    }

    public(friend) fun new_withdraw_receipt(arg0: 0x2::object::ID) : BucketProtocolWithdrawReceipt {
        BucketProtocolWithdrawReceipt{info: 0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::receipt::new_multiple_asset_receipt(arg0, 0x1::option::none<vector<0x1::type_name::TypeName>>(), 0x1::option::none<vector<u64>>())}
    }

    public(friend) fun new_withdraw_request() : BucketProtocolWithdrawRequest {
        BucketProtocolWithdrawRequest{dummy_field: false}
    }

    public fun repay<T0>(arg0: &mut 0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::collector::Collector, arg1: BucketProtocolRepayRequest, arg2: &mut 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BucketProtocol, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::collector::Collector, BucketProtocolRepayReceipt) {
        let v0 = 0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::collector::vault_id(arg0);
        let v1 = 0x1::type_name::get<0x2::balance::Balance<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>>();
        let (_, v3) = 0x2::vec_map::remove<0x1::type_name::TypeName, 0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::collector::Item>(0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::collector::extract_asset_map_mut<BucketProtocolRepayRequest>(arg0, &arg1), &v1);
        let v4 = 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::repay_debt<T0>(arg2, 0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::collector::extract_inner_asset<0x2::balance::Balance<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>>(v3), arg3, arg4);
        drop_repay_request(arg1);
        let v5 = 0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::collector::new(v0);
        let v6 = new_repay_receipt<T0>(v0);
        let v7 = &mut v6;
        fill_repay_receipt<T0>(v7, &v4);
        0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::collector::collect_asset<0x2::balance::Balance<T0>, BucketProtocolRepayReceipt>(&mut v5, &v6, v4, arg4);
        (v5, v6)
    }

    public fun repay_receipt_amount(arg0: &BucketProtocolRepayReceipt) : u64 {
        0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::receipt::single_asset_receipt_amount(arg0.info)
    }

    public fun repay_receipt_asset_type(arg0: &BucketProtocolRepayReceipt) : 0x1::type_name::TypeName {
        0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::receipt::single_asset_receipt_asset_type(arg0.info)
    }

    public fun repay_receipt_vault_id(arg0: &BucketProtocolRepayReceipt) : 0x2::object::ID {
        0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::receipt::single_asset_receipt_vault_id(arg0.info)
    }

    public fun withdraw(arg0: &mut 0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::collector::Collector, arg1: BucketProtocolWithdrawRequest, arg2: &mut 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BucketProtocol, arg3: &mut 0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::Flask<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>, arg4: &mut 0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::Fountain<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::collector::Collector, BucketProtocolWithdrawReceipt) {
        let v0 = 0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::collector::vault_id(arg0);
        let v1 = 0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::collector::extract_asset_map_mut<BucketProtocolWithdrawRequest>(arg0, &arg1);
        let v2 = 0x1::type_name::get<0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::StakeProof<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>>();
        let (_, v4) = 0x2::vec_map::remove<0x1::type_name::TypeName, 0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::collector::Item>(v1, &v2);
        let v5 = 0x2::vec_map::keys<0x1::type_name::TypeName, 0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::collector::Item>(v1);
        if (0x1::vector::length<0x1::type_name::TypeName>(&v5) > 0) {
            err_remaining_unused_asset();
        };
        let (v6, v7) = 0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::force_unstake<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>(arg5, arg4, 0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::collector::extract_inner_asset<0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::StakeProof<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>>(v4));
        let v8 = v7;
        let v9 = 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::sbuck_to_buck(arg2, arg3, arg5, v6);
        drop_withdraw_request(arg1);
        let v10 = 0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::collector::new(v0);
        let v11 = new_withdraw_receipt(v0);
        let v12 = &mut v11;
        fill_withdraw_receipt<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, 0x2::sui::SUI>(v12, &v9, &v8);
        0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::collector::collect_asset<0x2::balance::Balance<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>, BucketProtocolWithdrawReceipt>(&mut v10, &v11, v9, arg6);
        0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::collector::collect_asset<0x2::balance::Balance<0x2::sui::SUI>, BucketProtocolWithdrawReceipt>(&mut v10, &v11, v8, arg6);
        (v10, v11)
    }

    public fun withdraw_receipt_amounts(arg0: &BucketProtocolWithdrawReceipt) : vector<u64> {
        0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::receipt::multiple_asset_receipt_amounts(arg0.info)
    }

    public fun withdraw_receipt_asset_types(arg0: &BucketProtocolWithdrawReceipt) : vector<0x1::type_name::TypeName> {
        0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::receipt::multiple_asset_receipt_asset_type(arg0.info)
    }

    public fun withdraw_receipt_vault_id(arg0: &BucketProtocolWithdrawReceipt) : 0x2::object::ID {
        0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::receipt::multiple_asset_receipt_vault_id(arg0.info)
    }

    // decompiled from Move bytecode v6
}

