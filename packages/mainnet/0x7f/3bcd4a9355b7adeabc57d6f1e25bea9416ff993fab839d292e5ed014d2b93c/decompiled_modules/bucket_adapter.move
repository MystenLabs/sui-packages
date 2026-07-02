module 0x7f3bcd4a9355b7adeabc57d6f1e25bea9416ff993fab839d292e5ed014d2b93c::bucket_adapter {
    struct BucketAdapterRegistry has key {
        id: 0x2::object::UID,
        map: 0x2::vec_map::VecMap<0x2::object::ID, 0x2::object::ID>,
        whitelist: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
    }

    struct BucketAdapterAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct BucketVault has key {
        id: 0x2::object::UID,
        main_vault_id: 0x1::option::Option<0x2::object::ID>,
        stake_proof: 0x1::option::Option<0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::StakeProof<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>>,
        record: BucketRecord,
        is_redeeming: bool,
    }

    struct BucketRecord has store {
        collateral: 0x2::vec_map::VecMap<0x1::ascii::String, u64>,
        deposit: 0x2::vec_map::VecMap<0x1::ascii::String, u64>,
        borrow: u64,
        reward: 0x2::vec_map::VecMap<0x1::ascii::String, u64>,
    }

    struct BucketState {
        collateral: 0x2::vec_map::VecMap<0x1::ascii::String, u64>,
        borrow: u64,
        deposit: 0x2::vec_map::VecMap<0x1::ascii::String, u64>,
        reward: 0x2::vec_map::VecMap<0x1::ascii::String, u64>,
    }

    struct Bucket has drop {
        dummy_field: bool,
    }

    public fun new<T0: drop>(arg0: &mut BucketAdapterRegistry, arg1: 0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::message::Message<T0, Bucket>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::get<T0>();
        if (!0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.whitelist, &v0)) {
            err_not_whitelisted_source();
        };
        let v1 = stamp();
        let v2 = 0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::message::burn_and_get_info<T0, Bucket>(arg1, &v1);
        let v3 = 0x2::bag::remove<vector<u8>, 0x2::object::ID>(&mut v2, b"main_vault_id");
        0x2::bag::destroy_empty(v2);
        if (0x2::vec_map::contains<0x2::object::ID, 0x2::object::ID>(&arg0.map, &v3)) {
            err_already_registered();
        };
        let v4 = BucketRecord{
            collateral : 0x2::vec_map::empty<0x1::ascii::String, u64>(),
            deposit    : 0x2::vec_map::empty<0x1::ascii::String, u64>(),
            borrow     : 0,
            reward     : 0x2::vec_map::empty<0x1::ascii::String, u64>(),
        };
        let v5 = BucketVault{
            id            : 0x2::object::new(arg2),
            main_vault_id : 0x1::option::some<0x2::object::ID>(v3),
            stake_proof   : 0x1::option::none<0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::StakeProof<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>>(),
            record        : v4,
            is_redeeming  : false,
        };
        0x2::vec_map::insert<0x2::object::ID, 0x2::object::ID>(&mut arg0.map, v3, *0x2::object::uid_as_inner(&v5.id));
        0x2::transfer::share_object<BucketVault>(v5);
    }

    public fun claim<T0: drop>(arg0: &mut BucketVault, arg1: 0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::message::Message<T0, Bucket>, arg2: &0x2::clock::Clock, arg3: &mut 0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::Fountain<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) : 0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::asset::Asset<Bucket, T0, 0x2::sui::SUI> {
        if (arg0.is_redeeming) {
            err_redeeming();
        };
        if (0x1::option::is_none<0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::StakeProof<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>>(&arg0.stake_proof)) {
            err_stake_proof_not_existed();
        };
        message_pre_check<T0>(arg0, arg1);
        let v0 = 0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::claim<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>(arg2, arg3, 0x1::option::borrow_mut<0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::StakeProof<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>>(&mut arg0.stake_proof));
        0x7f3bcd4a9355b7adeabc57d6f1e25bea9416ff993fab839d292e5ed014d2b93c::bucket_adapter_event::claim_event<0x2::sui::SUI>(*0x1::option::borrow<0x2::object::ID>(&arg0.main_vault_id), 0x2::balance::value<0x2::sui::SUI>(&v0));
        new_single_asset<T0, 0x2::sui::SUI>(arg0, v0, arg4)
    }

    fun add_amount(arg0: &mut 0x2::vec_map::VecMap<0x1::ascii::String, u64>, arg1: 0x1::ascii::String, arg2: u64) {
        let v0 = 0x2::vec_map::keys<0x1::ascii::String, u64>(arg0);
        let v1 = if (0x1::vector::contains<0x1::ascii::String>(&v0, &arg1)) {
            let (_, v3) = 0x2::vec_map::remove<0x1::ascii::String, u64>(arg0, &arg1);
            v3
        } else {
            0
        };
        0x2::vec_map::insert<0x1::ascii::String, u64>(arg0, arg1, v1 + arg2);
    }

    entry fun add_whitelist<T0>(arg0: &mut BucketAdapterRegistry, arg1: &BucketAdapterAdminCap) {
        0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg0.whitelist, 0x1::type_name::get<T0>());
    }

    fun check_and_extract_weight<T0: drop>(arg0: &BucketVault, arg1: 0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::message::Message<T0, Bucket>) : 0x8e2270177d325fb4d6c841a6ebfda4738953bf861348f423fb99b4c1c1f7acd7::float::Float {
        let v0 = stamp();
        let v1 = 0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::message::burn_and_get_info<T0, Bucket>(arg1, &v0);
        if (!(*0x1::option::borrow<0x2::object::ID>(&arg0.main_vault_id) != 0x2::bag::remove<vector<u8>, 0x2::object::ID>(&mut v1, b"main_vault_id"))) {
            err_main_vault_id_not_matched();
        };
        0x2::bag::destroy_empty(v1);
        0x2::bag::remove<vector<u8>, 0x8e2270177d325fb4d6c841a6ebfda4738953bf861348f423fb99b4c1c1f7acd7::float::Float>(&mut v1, b"weight")
    }

    fun check_and_fill_main_vault_id(arg0: &mut BucketVault, arg1: 0x2::object::ID) {
        if (0x1::option::is_none<0x2::object::ID>(&arg0.main_vault_id)) {
            arg0.main_vault_id = 0x1::option::some<0x2::object::ID>(arg1);
        } else if (!(*0x1::option::borrow<0x2::object::ID>(&arg0.main_vault_id) != arg1)) {
            err_main_vault_id_not_matched();
        };
    }

    public fun claimable_value(arg0: &0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::Fountain<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>, arg1: &0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::StakeProof<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>, arg2: &0x2::clock::Clock) : (0x1::ascii::String, u64) {
        (0x1::type_name::into_string(0x1::type_name::get<0x2::sui::SUI>()), 0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::get_reward_amount<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>(arg0, arg1, 0x2::clock::timestamp_ms(arg2)))
    }

    public fun deposit<T0: drop>(arg0: &mut BucketVault, arg1: 0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::asset::Asset<T0, Bucket, 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>, arg2: &mut 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BucketProtocol, arg3: &mut 0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::Flask<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>, arg4: &mut 0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::Fountain<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        if (arg0.is_redeeming) {
            err_redeeming();
        };
        if (0x1::option::is_some<0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::StakeProof<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>>(&arg0.stake_proof)) {
            err_stake_proof_existed();
        };
        let v0 = pre_check_and_extract_asset<T0, 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(arg0, arg1);
        let (_, v2) = 0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::get_lock_time_range<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>(arg4);
        let v3 = 0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::stake<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>(arg5, arg4, 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::buck_to_sbuck(arg2, arg3, arg5, v0), v2, arg6);
        let v4 = 0x1::type_name::into_string(0x1::type_name::get<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>());
        if (0x2::vec_map::contains<0x1::ascii::String, u64>(&arg0.record.deposit, &v4)) {
            let (_, _) = 0x2::vec_map::remove<0x1::ascii::String, u64>(&mut arg0.record.deposit, &v4);
            0x2::vec_map::insert<0x1::ascii::String, u64>(&mut arg0.record.deposit, v4, 0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::get_proof_stake_amount<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>(&v3));
        } else {
            0x2::vec_map::insert<0x1::ascii::String, u64>(&mut arg0.record.deposit, v4, 0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::get_proof_stake_amount<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>(&v3));
        };
        0x7f3bcd4a9355b7adeabc57d6f1e25bea9416ff993fab839d292e5ed014d2b93c::bucket_adapter_event::deposit_event<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(*0x1::option::borrow<0x2::object::ID>(&arg0.main_vault_id), 0x2::balance::value<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(&v0));
        0x1::option::fill<0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::StakeProof<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>>(&mut arg0.stake_proof, v3);
    }

    fun err_already_registered() {
        abort 103
    }

    fun err_less_than_bucket_state_collateral() {
        abort 105
    }

    fun err_less_than_bucket_state_deposit() {
        abort 108
    }

    fun err_main_vault_id_not_matched() {
        abort 100
    }

    fun err_more_than_bucket_state_borrow() {
        abort 107
    }

    fun err_not_redeeming() {
        abort 110
    }

    fun err_not_whitelisted_source() {
        abort 104
    }

    fun err_redeeming() {
        abort 109
    }

    fun err_stake_proof_existed() {
        abort 101
    }

    fun err_stake_proof_not_existed() {
        abort 102
    }

    fun err_still_existed_reward() {
        abort 106
    }

    public fun fetch_total_value<T0: drop>(arg0: &mut BucketVault, arg1: &BucketAdapterRegistry, arg2: &0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::Fountain<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::message::Message<Bucket, T0> {
        if (arg0.is_redeeming) {
            err_redeeming();
        };
        let v0 = 0x1::type_name::get<T0>();
        if (!0x2::vec_set::contains<0x1::type_name::TypeName>(&arg1.whitelist, &v0)) {
            err_not_whitelisted_source();
        };
        let v1 = 0x1::vector::empty<0x1::ascii::String>();
        let v2 = 0x1::vector::empty<u64>();
        let v3 = 0x1::vector::empty<bool>();
        let v4 = 0x2::vec_map::empty<0x1::ascii::String, u64>();
        let v5 = 0x2::vec_map::empty<0x1::ascii::String, u64>();
        if (0x1::option::is_some<0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::StakeProof<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>>(&arg0.stake_proof)) {
            let v6 = 0x1::option::borrow<0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::StakeProof<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>>(&arg0.stake_proof);
            let (v7, v8) = claimable_value(arg2, v6, arg3);
            0x1::vector::push_back<0x1::ascii::String>(&mut v1, v7);
            0x1::vector::push_back<u64>(&mut v2, v8);
            let v9 = &mut v4;
            add_amount(v9, v7, v8);
            0x1::vector::push_back<bool>(&mut v3, true);
            let v10 = 0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::get_proof_stake_amount<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>(v6);
            let v11 = 0x1::type_name::into_string(0x1::type_name::get<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>());
            0x1::vector::push_back<0x1::ascii::String>(&mut v1, v11);
            0x1::vector::push_back<u64>(&mut v2, v10);
            let v12 = &mut v5;
            add_amount(v12, v11, v10);
            0x1::vector::push_back<bool>(&mut v3, true);
        };
        arg0.record.deposit = v5;
        arg0.record.reward = v4;
        new_total_value_message<T0>(arg0, v1, v2, v3, arg4)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = BucketAdapterRegistry{
            id        : 0x2::object::new(arg0),
            map       : 0x2::vec_map::empty<0x2::object::ID, 0x2::object::ID>(),
            whitelist : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
        };
        let v1 = BucketAdapterAdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<BucketAdapterRegistry>(v0);
        0x2::transfer::public_transfer<BucketAdapterAdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    fun message_pre_check<T0: drop>(arg0: &mut BucketVault, arg1: 0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::message::Message<T0, Bucket>) {
        let v0 = stamp();
        let v1 = 0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::message::burn_and_get_info<T0, Bucket>(arg1, &v0);
        check_and_fill_main_vault_id(arg0, 0x2::bag::remove<vector<u8>, 0x2::object::ID>(&mut v1, b"main_vault_id"));
        0x2::bag::destroy_empty(v1);
    }

    public fun new_bucket_state<T0: drop>(arg0: &mut BucketVault, arg1: 0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::message::Message<T0, Bucket>, arg2: &mut 0x2::tx_context::TxContext) : (BucketState, 0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::message::Message<Bucket, T0>) {
        let v0 = 0x8e2270177d325fb4d6c841a6ebfda4738953bf861348f423fb99b4c1c1f7acd7::float::sub(0x8e2270177d325fb4d6c841a6ebfda4738953bf861348f423fb99b4c1c1f7acd7::float::from(1), check_and_extract_weight<T0>(arg0, arg1));
        let v1 = BucketState{
            collateral : 0x2::vec_map::empty<0x1::ascii::String, u64>(),
            borrow     : 0,
            deposit    : 0x2::vec_map::empty<0x1::ascii::String, u64>(),
            reward     : 0x2::vec_map::empty<0x1::ascii::String, u64>(),
        };
        let v2 = 0x2::vec_map::keys<0x1::ascii::String, u64>(&arg0.record.reward);
        while (0x1::vector::length<0x1::ascii::String>(&v2) > 0) {
            let v3 = &mut v1.reward;
            add_amount(v3, 0x1::vector::pop_back<0x1::ascii::String>(&mut v2), 0);
        };
        if (arg0.record.borrow > 0) {
            v1.borrow = 0x8e2270177d325fb4d6c841a6ebfda4738953bf861348f423fb99b4c1c1f7acd7::float::ceil(0x8e2270177d325fb4d6c841a6ebfda4738953bf861348f423fb99b4c1c1f7acd7::float::mul_u64(v0, arg0.record.borrow));
        } else {
            v1.borrow = 0;
        };
        let v4 = 0x2::vec_map::keys<0x1::ascii::String, u64>(&arg0.record.deposit);
        while (0x1::vector::length<0x1::ascii::String>(&v4) > 0) {
            let v5 = 0x1::vector::pop_back<0x1::ascii::String>(&mut v4);
            let v6 = &mut v1.deposit;
            add_amount(v6, v5, 0x8e2270177d325fb4d6c841a6ebfda4738953bf861348f423fb99b4c1c1f7acd7::float::floor(0x8e2270177d325fb4d6c841a6ebfda4738953bf861348f423fb99b4c1c1f7acd7::float::mul_u64(v0, *0x2::vec_map::get<0x1::ascii::String, u64>(&arg0.record.deposit, &v5))));
        };
        let v7 = 0x2::vec_map::keys<0x1::ascii::String, u64>(&arg0.record.collateral);
        while (0x1::vector::length<0x1::ascii::String>(&v7) > 0) {
            let v8 = 0x1::vector::pop_back<0x1::ascii::String>(&mut v7);
            let v9 = &mut v1.collateral;
            add_amount(v9, v8, 0x8e2270177d325fb4d6c841a6ebfda4738953bf861348f423fb99b4c1c1f7acd7::float::floor(0x8e2270177d325fb4d6c841a6ebfda4738953bf861348f423fb99b4c1c1f7acd7::float::mul_u64(v0, *0x2::vec_map::get<0x1::ascii::String, u64>(&arg0.record.collateral, &v8))));
        };
        (v1, new_generated_state_proof_message<T0>(arg0, arg2))
    }

    fun new_generated_state_proof_message<T0: drop>(arg0: &BucketVault, arg1: &mut 0x2::tx_context::TxContext) : 0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::message::Message<Bucket, T0> {
        let v0 = stamp();
        let v1 = 0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::message::new<Bucket, T0>(&v0, arg1);
        let v2 = stamp();
        0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::message::set_info<Bucket, T0, vector<u8>, 0x2::object::ID>(&mut v1, &v2, b"main_vault_id", *0x1::option::borrow<0x2::object::ID>(&arg0.main_vault_id));
        let v3 = stamp();
        0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::message::set_info<Bucket, T0, vector<u8>, bool>(&mut v1, &v3, b"is_sate_generated", true);
        v1
    }

    fun new_single_asset<T0: drop, T1>(arg0: &BucketVault, arg1: 0x2::balance::Balance<T1>, arg2: &mut 0x2::tx_context::TxContext) : 0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::asset::Asset<Bucket, T0, T1> {
        let v0 = stamp();
        let v1 = 0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::asset::new<Bucket, T0, T1>(&v0, arg1, arg2);
        let v2 = stamp();
        0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::asset::set_extra_info<Bucket, T0, T1, vector<u8>, 0x2::object::ID>(&mut v1, &v2, b"main_vault_id", *0x1::option::borrow<0x2::object::ID>(&arg0.main_vault_id));
        v1
    }

    fun new_total_value_message<T0: drop>(arg0: &BucketVault, arg1: vector<0x1::ascii::String>, arg2: vector<u64>, arg3: vector<bool>, arg4: &mut 0x2::tx_context::TxContext) : 0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::message::Message<Bucket, T0> {
        let v0 = stamp();
        let v1 = 0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::message::new<Bucket, T0>(&v0, arg4);
        let v2 = stamp();
        0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::message::set_info<Bucket, T0, vector<u8>, vector<0x1::ascii::String>>(&mut v1, &v2, b"asset_types", arg1);
        let v3 = stamp();
        0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::message::set_info<Bucket, T0, vector<u8>, vector<u64>>(&mut v1, &v3, b"amounts", arg2);
        let v4 = stamp();
        0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::message::set_info<Bucket, T0, vector<u8>, vector<bool>>(&mut v1, &v4, b"is_positives", arg3);
        let v5 = stamp();
        0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::message::set_info<Bucket, T0, vector<u8>, 0x2::object::ID>(&mut v1, &v5, b"main_vault_id", *0x1::option::borrow<0x2::object::ID>(&arg0.main_vault_id));
        v1
    }

    fun new_verified_message<T0: drop>(arg0: &BucketVault, arg1: &mut 0x2::tx_context::TxContext) : 0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::message::Message<Bucket, T0> {
        let v0 = stamp();
        let v1 = 0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::message::new<Bucket, T0>(&v0, arg1);
        let v2 = stamp();
        0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::message::set_info<Bucket, T0, vector<u8>, bool>(&mut v1, &v2, b"is_verified", true);
        let v3 = stamp();
        0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::message::set_info<Bucket, T0, vector<u8>, 0x1::option::Option<0x2::object::ID>>(&mut v1, &v3, b"main_vault_id", arg0.main_vault_id);
        v1
    }

    fun pre_check_and_extract_asset<T0: drop, T1>(arg0: &mut BucketVault, arg1: 0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::asset::Asset<T0, Bucket, T1>) : 0x2::balance::Balance<T1> {
        let v0 = stamp();
        check_and_fill_main_vault_id(arg0, 0x2::bag::remove<vector<u8>, 0x2::object::ID>(0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::asset::borrow_extra_info_mut<T0, Bucket, T1>(&mut arg1, &v0), b"main_vault_id"));
        let v1 = stamp();
        0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::asset::burn<T0, Bucket, T1>(arg1, &v1)
    }

    entry fun remove_whitelist<T0>(arg0: &mut BucketAdapterRegistry, arg1: &BucketAdapterAdminCap) {
        let v0 = 0x1::type_name::get<T0>();
        0x2::vec_set::remove<0x1::type_name::TypeName>(&mut arg0.whitelist, &v0);
    }

    fun stamp() : Bucket {
        Bucket{dummy_field: false}
    }

    public fun unlock<T0: drop>(arg0: &mut BucketVault, arg1: 0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::message::Message<T0, Bucket>) {
        if (!arg0.is_redeeming) {
            err_not_redeeming();
        };
        unlock_<T0>(arg0, arg1);
    }

    fun unlock_<T0: drop>(arg0: &mut BucketVault, arg1: 0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::message::Message<T0, Bucket>) {
        let v0 = stamp();
        let v1 = 0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::message::burn_and_get_info<T0, Bucket>(arg1, &v0);
        if (*0x2::object::uid_as_inner(&arg0.id) != 0x2::bag::remove<vector<u8>, 0x2::object::ID>(&mut v1, b"main_vault_id")) {
            err_main_vault_id_not_matched();
        };
        if (0x2::bag::remove<vector<u8>, bool>(&mut v1, b"is_unlocked")) {
            arg0.is_redeeming = false;
        };
        0x2::bag::destroy_empty(v1);
    }

    public fun update_record_value(arg0: &mut BucketVault, arg1: &0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::Fountain<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>, arg2: &0x2::clock::Clock) {
        if (arg0.is_redeeming) {
            err_redeeming();
        };
        let v0 = 0x2::vec_map::empty<0x1::ascii::String, u64>();
        let v1 = 0x2::vec_map::empty<0x1::ascii::String, u64>();
        if (0x1::option::is_some<0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::StakeProof<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>>(&arg0.stake_proof)) {
            let v2 = 0x1::option::borrow<0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::StakeProof<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>>(&arg0.stake_proof);
            let (v3, v4) = claimable_value(arg1, v2, arg2);
            let v5 = &mut v0;
            add_amount(v5, v3, v4);
            let v6 = &mut v1;
            add_amount(v6, 0x1::type_name::into_string(0x1::type_name::get<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>()), 0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::get_proof_stake_amount<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>(v2));
        };
        arg0.record.deposit = v1;
        arg0.record.reward = v0;
    }

    public fun verify_bucket_state<T0: drop>(arg0: &mut BucketVault, arg1: BucketState, arg2: &0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::Fountain<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::message::Message<Bucket, T0> {
        if (arg0.is_redeeming) {
            err_redeeming();
        };
        update_record_value(arg0, arg2, arg3);
        let BucketState {
            collateral : v0,
            borrow     : v1,
            deposit    : v2,
            reward     : v3,
        } = arg1;
        let v4 = v3;
        let v5 = v2;
        let v6 = v0;
        let v7 = 0x2::vec_map::keys<0x1::ascii::String, u64>(&v6);
        while (0x1::vector::length<0x1::ascii::String>(&v7) > 0) {
            let v8 = 0x1::vector::pop_back<0x1::ascii::String>(&mut v7);
            if (*0x2::vec_map::get<0x1::ascii::String, u64>(&arg0.record.collateral, &v8) < *0x2::vec_map::get<0x1::ascii::String, u64>(&v6, &v8)) {
                err_less_than_bucket_state_collateral();
            };
        };
        let v9 = 0x2::vec_map::keys<0x1::ascii::String, u64>(&v4);
        while (0x1::vector::length<0x1::ascii::String>(&v9) > 0) {
            let v10 = 0x1::vector::pop_back<0x1::ascii::String>(&mut v9);
            if (*0x2::vec_map::get<0x1::ascii::String, u64>(&arg0.record.reward, &v10) != 0) {
                err_still_existed_reward();
            };
        };
        let v11 = 0x2::vec_map::keys<0x1::ascii::String, u64>(&v5);
        while (0x1::vector::length<0x1::ascii::String>(&v11) > 0) {
            let v12 = 0x1::vector::pop_back<0x1::ascii::String>(&mut v11);
            if (*0x2::vec_map::get<0x1::ascii::String, u64>(&arg0.record.deposit, &v12) < *0x2::vec_map::get<0x1::ascii::String, u64>(&v5, &v12)) {
                err_less_than_bucket_state_deposit();
            };
        };
        if (arg0.record.borrow > v1) {
            err_more_than_bucket_state_borrow();
        };
        new_verified_message<T0>(arg0, arg4)
    }

    public fun withdraw<T0: drop>(arg0: &mut BucketVault, arg1: 0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::message::Message<T0, Bucket>, arg2: &mut 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BucketProtocol, arg3: &mut 0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::Flask<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>, arg4: &mut 0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::Fountain<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::asset::Asset<Bucket, T0, 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>, 0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::asset::Asset<Bucket, T0, 0x2::sui::SUI>) {
        if (arg0.is_redeeming) {
            err_redeeming();
        };
        if (0x1::option::is_none<0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::StakeProof<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>>(&arg0.stake_proof)) {
            err_stake_proof_not_existed();
        };
        message_pre_check<T0>(arg0, arg1);
        let (v0, v1) = 0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::force_unstake<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>(arg5, arg4, 0x1::option::extract<0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::StakeProof<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>>(&mut arg0.stake_proof));
        let v2 = v1;
        let v3 = 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::sbuck_to_buck(arg2, arg3, arg5, v0);
        let v4 = new_single_asset<T0, 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(arg0, v3, arg6);
        let v5 = 0x1::type_name::into_string(0x1::type_name::get<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>());
        if (0x2::vec_map::contains<0x1::ascii::String, u64>(&arg0.record.deposit, &v5)) {
            let (_, _) = 0x2::vec_map::remove<0x1::ascii::String, u64>(&mut arg0.record.deposit, &v5);
            0x2::vec_map::insert<0x1::ascii::String, u64>(&mut arg0.record.deposit, v5, 0);
        } else {
            0x2::vec_map::insert<0x1::ascii::String, u64>(&mut arg0.record.deposit, v5, 0);
        };
        0x7f3bcd4a9355b7adeabc57d6f1e25bea9416ff993fab839d292e5ed014d2b93c::bucket_adapter_event::withdraw_event<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(*0x1::option::borrow<0x2::object::ID>(&arg0.main_vault_id), 0x2::balance::value<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(&v3));
        0x7f3bcd4a9355b7adeabc57d6f1e25bea9416ff993fab839d292e5ed014d2b93c::bucket_adapter_event::withdraw_event<0x2::sui::SUI>(*0x1::option::borrow<0x2::object::ID>(&arg0.main_vault_id), 0x2::balance::value<0x2::sui::SUI>(&v2));
        (v4, new_single_asset<T0, 0x2::sui::SUI>(arg0, v2, arg6))
    }

    // decompiled from Move bytecode v7
}

