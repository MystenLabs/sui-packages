module 0x89a9c03d408ff7007d6674c3f9f36f08617900b6c202292d39b62d30be92794b::bucket_adapter {
    public entry fun withdraw<T0, T1>(arg0: &mut 0x89a9c03d408ff7007d6674c3f9f36f08617900b6c202292d39b62d30be92794b::staked_share::ShareSupply<0x89a9c03d408ff7007d6674c3f9f36f08617900b6c202292d39b62d30be92794b::pool::BUCKET_PROTOCOL, T0, T1>, arg1: &mut 0x89a9c03d408ff7007d6674c3f9f36f08617900b6c202292d39b62d30be92794b::staked_share::NumberPool<0x89a9c03d408ff7007d6674c3f9f36f08617900b6c202292d39b62d30be92794b::pool::BUCKET_PROTOCOL, T0, T1>, arg2: &mut 0x89a9c03d408ff7007d6674c3f9f36f08617900b6c202292d39b62d30be92794b::pool::Pool<0x89a9c03d408ff7007d6674c3f9f36f08617900b6c202292d39b62d30be92794b::pool::BUCKET_PROTOCOL, T0, T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::Flask<T0>, arg5: &mut 0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::Fountain<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, T1>, arg6: 0x89a9c03d408ff7007d6674c3f9f36f08617900b6c202292d39b62d30be92794b::staked_share::StakedPoolShare<0x89a9c03d408ff7007d6674c3f9f36f08617900b6c202292d39b62d30be92794b::pool::BUCKET_PROTOCOL, T0, T1>, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x89a9c03d408ff7007d6674c3f9f36f08617900b6c202292d39b62d30be92794b::staked_share::amount<0x89a9c03d408ff7007d6674c3f9f36f08617900b6c202292d39b62d30be92794b::pool::BUCKET_PROTOCOL, T0, T1>(&arg6);
        assert!(0x89a9c03d408ff7007d6674c3f9f36f08617900b6c202292d39b62d30be92794b::pool::contains_proof<0x89a9c03d408ff7007d6674c3f9f36f08617900b6c202292d39b62d30be92794b::pool::BUCKET_PROTOCOL, T0, T1, 0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::StakeProof<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, T1>>(arg2), 0);
        let v1 = 0x89a9c03d408ff7007d6674c3f9f36f08617900b6c202292d39b62d30be92794b::pool::extract_vec_proof<0x89a9c03d408ff7007d6674c3f9f36f08617900b6c202292d39b62d30be92794b::pool::BUCKET_PROTOCOL, T0, T1, 0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::StakeProof<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, T1>>(arg2);
        let v2 = 0x2::balance::zero<T1>();
        let v3 = 0;
        while (0x1::vector::length<0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::StakeProof<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, T1>>(&v1) > 0) {
            let v4 = 0x1::vector::pop_back<0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::StakeProof<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, T1>>(&mut v1);
            let v5 = 0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::get_proof_stake_amount<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, T1>(&v4);
            if (v5 > v0) {
                let (v6, v7) = 0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::force_unstake<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, T1>(arg3, arg5, v4);
                let v8 = v6;
                0x2::balance::join<T1>(&mut v2, v7);
                let v9 = 0x2::coin::from_balance<T0>(0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::withdraw<T0>(arg4, 0x2::coin::from_balance<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK>(0x2::balance::split<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK>(&mut v8, v0), arg8)), arg8);
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v9, 0x2::tx_context::sender(arg8));
                v3 = v3 + 0x2::coin::value<T0>(&v9);
                0x1::vector::push_back<0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::StakeProof<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, T1>>(&mut v1, 0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::stake<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, T1>(arg3, arg5, v8, arg7, arg8));
                break
            };
            if (v5 == v0) {
                let (v10, v11) = 0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::force_unstake<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, T1>(arg3, arg5, v4);
                0x2::balance::join<T1>(&mut v2, v11);
                let v12 = 0x2::coin::from_balance<T0>(0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::withdraw<T0>(arg4, 0x2::coin::from_balance<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK>(v10, arg8)), arg8);
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v12, 0x2::tx_context::sender(arg8));
                v3 = v3 + 0x2::coin::value<T0>(&v12);
                break
            };
            let (v13, v14) = 0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::force_unstake<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, T1>(arg3, arg5, v4);
            let v15 = v13;
            v0 = v0 - 0x2::balance::value<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK>(&v15);
            0x2::balance::join<T1>(&mut v2, v14);
            let v16 = 0x2::coin::from_balance<T0>(0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::withdraw<T0>(arg4, 0x2::coin::from_balance<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK>(v15, arg8)), arg8);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v16, 0x2::tx_context::sender(arg8));
            v3 = v3 + 0x2::coin::value<T0>(&v16);
        };
        0x2::balance::join<T1>(0x89a9c03d408ff7007d6674c3f9f36f08617900b6c202292d39b62d30be92794b::pool::borrow_mut_rewards<0x89a9c03d408ff7007d6674c3f9f36f08617900b6c202292d39b62d30be92794b::pool::BUCKET_PROTOCOL, T0, T1>(arg2), v2);
        0x89a9c03d408ff7007d6674c3f9f36f08617900b6c202292d39b62d30be92794b::pool::update_statistic_for_withdraw<0x89a9c03d408ff7007d6674c3f9f36f08617900b6c202292d39b62d30be92794b::pool::BUCKET_PROTOCOL, T0, T1>(arg2, 0x2::tx_context::sender(arg8), v3);
        0x89a9c03d408ff7007d6674c3f9f36f08617900b6c202292d39b62d30be92794b::staked_share::to_number_pool<0x89a9c03d408ff7007d6674c3f9f36f08617900b6c202292d39b62d30be92794b::pool::BUCKET_PROTOCOL, T0, T1>(arg1, arg0, arg6);
        0x89a9c03d408ff7007d6674c3f9f36f08617900b6c202292d39b62d30be92794b::pool::reput_vec_proof<0x89a9c03d408ff7007d6674c3f9f36f08617900b6c202292d39b62d30be92794b::pool::BUCKET_PROTOCOL, T0, T1, 0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::StakeProof<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, T1>>(arg2, v1);
    }

    public entry fun stake<T0, T1>(arg0: &mut 0x89a9c03d408ff7007d6674c3f9f36f08617900b6c202292d39b62d30be92794b::staked_share::ShareSupply<0x89a9c03d408ff7007d6674c3f9f36f08617900b6c202292d39b62d30be92794b::pool::BUCKET_PROTOCOL, T0, T1>, arg1: &mut 0x89a9c03d408ff7007d6674c3f9f36f08617900b6c202292d39b62d30be92794b::staked_share::NumberPool<0x89a9c03d408ff7007d6674c3f9f36f08617900b6c202292d39b62d30be92794b::pool::BUCKET_PROTOCOL, T0, T1>, arg2: &mut 0x89a9c03d408ff7007d6674c3f9f36f08617900b6c202292d39b62d30be92794b::pool::Pool<0x89a9c03d408ff7007d6674c3f9f36f08617900b6c202292d39b62d30be92794b::pool::BUCKET_PROTOCOL, T0, T1>, arg3: &mut 0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::Flask<T0>, arg4: 0x2::coin::Coin<T0>, arg5: &mut 0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::Fountain<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, T1>, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg4);
        let v1 = 0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::stake<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, T1>(arg7, arg5, 0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::deposit<T0>(arg3, arg4), arg6, arg8);
        if (0x89a9c03d408ff7007d6674c3f9f36f08617900b6c202292d39b62d30be92794b::pool::contains_proof<0x89a9c03d408ff7007d6674c3f9f36f08617900b6c202292d39b62d30be92794b::pool::BUCKET_PROTOCOL, T0, T1, 0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::StakeProof<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, T1>>(arg2)) {
            0x1::vector::push_back<0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::StakeProof<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, T1>>(0x89a9c03d408ff7007d6674c3f9f36f08617900b6c202292d39b62d30be92794b::pool::borrow_mut_vec_proof<0x89a9c03d408ff7007d6674c3f9f36f08617900b6c202292d39b62d30be92794b::pool::BUCKET_PROTOCOL, T0, T1, 0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::StakeProof<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, T1>>(arg2), v1);
        } else {
            0x89a9c03d408ff7007d6674c3f9f36f08617900b6c202292d39b62d30be92794b::pool::create_proof_container<0x89a9c03d408ff7007d6674c3f9f36f08617900b6c202292d39b62d30be92794b::pool::BUCKET_PROTOCOL, T0, T1, 0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::StakeProof<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, T1>>(arg2, true, v1);
        };
        let v2 = 0x89a9c03d408ff7007d6674c3f9f36f08617900b6c202292d39b62d30be92794b::staked_share::new_share<0x89a9c03d408ff7007d6674c3f9f36f08617900b6c202292d39b62d30be92794b::pool::BUCKET_PROTOCOL, T0, T1>(arg0, arg1, 0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::get_proof_stake_amount<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, T1>(&v1), v0, arg8);
        while (!0x1::vector::is_empty<0x89a9c03d408ff7007d6674c3f9f36f08617900b6c202292d39b62d30be92794b::staked_share::StakedPoolShare<0x89a9c03d408ff7007d6674c3f9f36f08617900b6c202292d39b62d30be92794b::pool::BUCKET_PROTOCOL, T0, T1>>(&v2)) {
            0x2::transfer::public_transfer<0x89a9c03d408ff7007d6674c3f9f36f08617900b6c202292d39b62d30be92794b::staked_share::StakedPoolShare<0x89a9c03d408ff7007d6674c3f9f36f08617900b6c202292d39b62d30be92794b::pool::BUCKET_PROTOCOL, T0, T1>>(0x1::vector::pop_back<0x89a9c03d408ff7007d6674c3f9f36f08617900b6c202292d39b62d30be92794b::staked_share::StakedPoolShare<0x89a9c03d408ff7007d6674c3f9f36f08617900b6c202292d39b62d30be92794b::pool::BUCKET_PROTOCOL, T0, T1>>(&mut v2), 0x2::tx_context::sender(arg8));
        };
        0x1::vector::destroy_empty<0x89a9c03d408ff7007d6674c3f9f36f08617900b6c202292d39b62d30be92794b::staked_share::StakedPoolShare<0x89a9c03d408ff7007d6674c3f9f36f08617900b6c202292d39b62d30be92794b::pool::BUCKET_PROTOCOL, T0, T1>>(v2);
        0x89a9c03d408ff7007d6674c3f9f36f08617900b6c202292d39b62d30be92794b::pool::update_statistic_for_stake<0x89a9c03d408ff7007d6674c3f9f36f08617900b6c202292d39b62d30be92794b::pool::BUCKET_PROTOCOL, T0, T1>(arg2, 0x2::tx_context::sender(arg8), v0);
    }

    public entry fun allocate_reward<T0, T1>(arg0: &0x89a9c03d408ff7007d6674c3f9f36f08617900b6c202292d39b62d30be92794b::pool::GlobalConfig, arg1: &mut 0x89a9c03d408ff7007d6674c3f9f36f08617900b6c202292d39b62d30be92794b::staked_share::ShareSupply<0x89a9c03d408ff7007d6674c3f9f36f08617900b6c202292d39b62d30be92794b::pool::BUCKET_PROTOCOL, T0, T1>, arg2: &mut 0x89a9c03d408ff7007d6674c3f9f36f08617900b6c202292d39b62d30be92794b::pool::Pool<0x89a9c03d408ff7007d6674c3f9f36f08617900b6c202292d39b62d30be92794b::pool::BUCKET_PROTOCOL, T0, T1>, arg3: &mut 0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::Fountain<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, T1>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(!0x2::dynamic_field::exists_<u64>(0x89a9c03d408ff7007d6674c3f9f36f08617900b6c202292d39b62d30be92794b::pool::uid<0x89a9c03d408ff7007d6674c3f9f36f08617900b6c202292d39b62d30be92794b::pool::BUCKET_PROTOCOL, T0, T1>(arg2), 0x89a9c03d408ff7007d6674c3f9f36f08617900b6c202292d39b62d30be92794b::pool::current_round<0x89a9c03d408ff7007d6674c3f9f36f08617900b6c202292d39b62d30be92794b::pool::BUCKET_PROTOCOL, T0, T1>(arg2)), 1);
        0x89a9c03d408ff7007d6674c3f9f36f08617900b6c202292d39b62d30be92794b::pool::check_arrived_reward_time<0x89a9c03d408ff7007d6674c3f9f36f08617900b6c202292d39b62d30be92794b::pool::BUCKET_PROTOCOL, T0, T1>(arg2, arg7);
        let v0 = 0x89a9c03d408ff7007d6674c3f9f36f08617900b6c202292d39b62d30be92794b::pool::extract_vec_proof<0x89a9c03d408ff7007d6674c3f9f36f08617900b6c202292d39b62d30be92794b::pool::BUCKET_PROTOCOL, T0, T1, 0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::StakeProof<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, T1>>(arg2);
        let v1 = 0x2::balance::zero<T1>();
        let v2 = &mut v0;
        0x2::balance::join<T1>(&mut v1, extract_all_rewards_from_proofs<T1>(v2, arg3, arg7));
        let v3 = 0x89a9c03d408ff7007d6674c3f9f36f08617900b6c202292d39b62d30be92794b::pool::borrow_mut_rewards<0x89a9c03d408ff7007d6674c3f9f36f08617900b6c202292d39b62d30be92794b::pool::BUCKET_PROTOCOL, T0, T1>(arg2);
        0x2::balance::join<T1>(v3, v1);
        let v4 = 0x2::balance::value<T1>(v3);
        let v5 = 0x2::balance::split<T1>(v3, v4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut v5, v4 * 0x89a9c03d408ff7007d6674c3f9f36f08617900b6c202292d39b62d30be92794b::pool::platform_ratio<0x89a9c03d408ff7007d6674c3f9f36f08617900b6c202292d39b62d30be92794b::pool::BUCKET_PROTOCOL, T0, T1>(arg2) / 10000), arg8), 0x89a9c03d408ff7007d6674c3f9f36f08617900b6c202292d39b62d30be92794b::pool::platform_address(arg0));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut v5, v4 * 0x89a9c03d408ff7007d6674c3f9f36f08617900b6c202292d39b62d30be92794b::pool::allocate_gas_payer_ratio<0x89a9c03d408ff7007d6674c3f9f36f08617900b6c202292d39b62d30be92794b::pool::BUCKET_PROTOCOL, T0, T1>(arg2) / 10000), arg8), 0x2::tx_context::sender(arg8));
        let v6 = 0x89a9c03d408ff7007d6674c3f9f36f08617900b6c202292d39b62d30be92794b::pool::current_round<0x89a9c03d408ff7007d6674c3f9f36f08617900b6c202292d39b62d30be92794b::pool::BUCKET_PROTOCOL, T0, T1>(arg2);
        0x2::dynamic_field::add<u64, u64>(0x89a9c03d408ff7007d6674c3f9f36f08617900b6c202292d39b62d30be92794b::pool::uid<0x89a9c03d408ff7007d6674c3f9f36f08617900b6c202292d39b62d30be92794b::pool::BUCKET_PROTOCOL, T0, T1>(arg2), v6, 0x89a9c03d408ff7007d6674c3f9f36f08617900b6c202292d39b62d30be92794b::random_lib::verify_and_random<0x89a9c03d408ff7007d6674c3f9f36f08617900b6c202292d39b62d30be92794b::pool::BUCKET_PROTOCOL, T0, T1>(arg2, arg4, arg5, arg6, 0x89a9c03d408ff7007d6674c3f9f36f08617900b6c202292d39b62d30be92794b::staked_share::total_supply<0x89a9c03d408ff7007d6674c3f9f36f08617900b6c202292d39b62d30be92794b::pool::BUCKET_PROTOCOL, T0, T1>(arg1)));
        let v7 = v6 - 1;
        let v8;
        loop {
            v8 = 0x89a9c03d408ff7007d6674c3f9f36f08617900b6c202292d39b62d30be92794b::pool::extract_previous_rewards<0x89a9c03d408ff7007d6674c3f9f36f08617900b6c202292d39b62d30be92794b::pool::BUCKET_PROTOCOL, T0, T1>(arg2, v7);
            if (0x1::option::is_none<0x2::balance::Balance<T1>>(&v8)) {
                break
            };
            0x2::balance::join<T1>(&mut v5, 0x1::option::extract<0x2::balance::Balance<T1>>(&mut v8));
            0x1::option::destroy_none<0x2::balance::Balance<T1>>(v8);
            v7 = v7 - 1;
        };
        0x1::option::destroy_none<0x2::balance::Balance<T1>>(v8);
        0x89a9c03d408ff7007d6674c3f9f36f08617900b6c202292d39b62d30be92794b::pool::reput_vec_proof<0x89a9c03d408ff7007d6674c3f9f36f08617900b6c202292d39b62d30be92794b::pool::BUCKET_PROTOCOL, T0, T1, 0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::StakeProof<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, T1>>(arg2, v0);
        0x89a9c03d408ff7007d6674c3f9f36f08617900b6c202292d39b62d30be92794b::pool::put_current_round_reward_to_claimable<0x89a9c03d408ff7007d6674c3f9f36f08617900b6c202292d39b62d30be92794b::pool::BUCKET_PROTOCOL, T0, T1>(arg2, v5);
        0x89a9c03d408ff7007d6674c3f9f36f08617900b6c202292d39b62d30be92794b::pool::next_round<0x89a9c03d408ff7007d6674c3f9f36f08617900b6c202292d39b62d30be92794b::pool::BUCKET_PROTOCOL, T0, T1>(arg2);
        0x89a9c03d408ff7007d6674c3f9f36f08617900b6c202292d39b62d30be92794b::pool::update_time<0x89a9c03d408ff7007d6674c3f9f36f08617900b6c202292d39b62d30be92794b::pool::BUCKET_PROTOCOL, T0, T1>(arg2, arg7);
        0x89a9c03d408ff7007d6674c3f9f36f08617900b6c202292d39b62d30be92794b::pool::add_expired_data<0x89a9c03d408ff7007d6674c3f9f36f08617900b6c202292d39b62d30be92794b::pool::BUCKET_PROTOCOL, T0, T1>(arg2);
    }

    public entry fun claim_reward<T0, T1>(arg0: &mut 0x89a9c03d408ff7007d6674c3f9f36f08617900b6c202292d39b62d30be92794b::pool::Pool<0x89a9c03d408ff7007d6674c3f9f36f08617900b6c202292d39b62d30be92794b::pool::BUCKET_PROTOCOL, T0, T1>, arg1: u64, arg2: vector<0x89a9c03d408ff7007d6674c3f9f36f08617900b6c202292d39b62d30be92794b::staked_share::StakedPoolShare<0x89a9c03d408ff7007d6674c3f9f36f08617900b6c202292d39b62d30be92794b::pool::BUCKET_PROTOCOL, T0, T1>>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x89a9c03d408ff7007d6674c3f9f36f08617900b6c202292d39b62d30be92794b::pool::check_claim_expired<0x89a9c03d408ff7007d6674c3f9f36f08617900b6c202292d39b62d30be92794b::pool::BUCKET_PROTOCOL, T0, T1>(arg0, arg1, arg3);
        0x89a9c03d408ff7007d6674c3f9f36f08617900b6c202292d39b62d30be92794b::pool::check_is_claimed<0x89a9c03d408ff7007d6674c3f9f36f08617900b6c202292d39b62d30be92794b::pool::BUCKET_PROTOCOL, T0, T1>(arg0, arg1);
        0x89a9c03d408ff7007d6674c3f9f36f08617900b6c202292d39b62d30be92794b::pool::check_round_could_claim_reward<0x89a9c03d408ff7007d6674c3f9f36f08617900b6c202292d39b62d30be92794b::pool::BUCKET_PROTOCOL, T0, T1>(arg0, arg1);
        let v0 = *0x2::dynamic_field::borrow<u64, u64>(0x89a9c03d408ff7007d6674c3f9f36f08617900b6c202292d39b62d30be92794b::pool::uid<0x89a9c03d408ff7007d6674c3f9f36f08617900b6c202292d39b62d30be92794b::pool::BUCKET_PROTOCOL, T0, T1>(arg0), arg1);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x89a9c03d408ff7007d6674c3f9f36f08617900b6c202292d39b62d30be92794b::staked_share::StakedPoolShare<0x89a9c03d408ff7007d6674c3f9f36f08617900b6c202292d39b62d30be92794b::pool::BUCKET_PROTOCOL, T0, T1>>(&arg2)) {
            let v2 = 0x1::vector::borrow<0x89a9c03d408ff7007d6674c3f9f36f08617900b6c202292d39b62d30be92794b::staked_share::StakedPoolShare<0x89a9c03d408ff7007d6674c3f9f36f08617900b6c202292d39b62d30be92794b::pool::BUCKET_PROTOCOL, T0, T1>>(&arg2, v1);
            if (v0 >= 0x89a9c03d408ff7007d6674c3f9f36f08617900b6c202292d39b62d30be92794b::staked_share::start_num<0x89a9c03d408ff7007d6674c3f9f36f08617900b6c202292d39b62d30be92794b::pool::BUCKET_PROTOCOL, T0, T1>(v2) && v0 <= 0x89a9c03d408ff7007d6674c3f9f36f08617900b6c202292d39b62d30be92794b::staked_share::end_num<0x89a9c03d408ff7007d6674c3f9f36f08617900b6c202292d39b62d30be92794b::pool::BUCKET_PROTOCOL, T0, T1>(v2)) {
                let v3 = 0x89a9c03d408ff7007d6674c3f9f36f08617900b6c202292d39b62d30be92794b::pool::extract_round_claimable_reward<0x89a9c03d408ff7007d6674c3f9f36f08617900b6c202292d39b62d30be92794b::pool::BUCKET_PROTOCOL, T0, T1>(arg0, arg1);
                0x89a9c03d408ff7007d6674c3f9f36f08617900b6c202292d39b62d30be92794b::pool::add_claimed_info<0x89a9c03d408ff7007d6674c3f9f36f08617900b6c202292d39b62d30be92794b::pool::BUCKET_PROTOCOL, T0, T1>(arg0, arg1, 0x2::tx_context::sender(arg4), 0x2::balance::value<T1>(&v3));
                0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v3, arg4), 0x2::tx_context::sender(arg4));
                break
            };
            v1 = v1 + 1;
        };
        loop {
            0x2::transfer::public_transfer<0x89a9c03d408ff7007d6674c3f9f36f08617900b6c202292d39b62d30be92794b::staked_share::StakedPoolShare<0x89a9c03d408ff7007d6674c3f9f36f08617900b6c202292d39b62d30be92794b::pool::BUCKET_PROTOCOL, T0, T1>>(0x1::vector::pop_back<0x89a9c03d408ff7007d6674c3f9f36f08617900b6c202292d39b62d30be92794b::staked_share::StakedPoolShare<0x89a9c03d408ff7007d6674c3f9f36f08617900b6c202292d39b62d30be92794b::pool::BUCKET_PROTOCOL, T0, T1>>(&mut arg2), 0x2::tx_context::sender(arg4));
            if (0x1::vector::is_empty<0x89a9c03d408ff7007d6674c3f9f36f08617900b6c202292d39b62d30be92794b::staked_share::StakedPoolShare<0x89a9c03d408ff7007d6674c3f9f36f08617900b6c202292d39b62d30be92794b::pool::BUCKET_PROTOCOL, T0, T1>>(&arg2)) {
                break
            };
        };
        0x1::vector::destroy_empty<0x89a9c03d408ff7007d6674c3f9f36f08617900b6c202292d39b62d30be92794b::staked_share::StakedPoolShare<0x89a9c03d408ff7007d6674c3f9f36f08617900b6c202292d39b62d30be92794b::pool::BUCKET_PROTOCOL, T0, T1>>(arg2);
    }

    fun extract_all_rewards_from_proofs<T0>(arg0: &mut vector<0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::StakeProof<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, T0>>, arg1: &mut 0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::Fountain<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, T0>, arg2: &0x2::clock::Clock) : 0x2::balance::Balance<T0> {
        let v0 = 0x2::balance::zero<T0>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::StakeProof<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, T0>>(arg0)) {
            0x2::balance::join<T0>(&mut v0, 0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::claim<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, T0>(arg2, arg1, 0x1::vector::borrow_mut<0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::StakeProof<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, T0>>(arg0, v1)));
            v1 = v1 + 1;
        };
        v0
    }

    public entry fun get_current_reward<T0, T1>(arg0: &mut 0x89a9c03d408ff7007d6674c3f9f36f08617900b6c202292d39b62d30be92794b::pool::Pool<0x89a9c03d408ff7007d6674c3f9f36f08617900b6c202292d39b62d30be92794b::pool::BUCKET_PROTOCOL, T0, T1>, arg1: &0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::Fountain<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, T1>, arg2: &0x2::clock::Clock) : u64 {
        let v0 = 0x89a9c03d408ff7007d6674c3f9f36f08617900b6c202292d39b62d30be92794b::pool::borrow_mut_vec_proof<0x89a9c03d408ff7007d6674c3f9f36f08617900b6c202292d39b62d30be92794b::pool::BUCKET_PROTOCOL, T0, T1, 0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::StakeProof<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, T1>>(arg0);
        let v1 = 0;
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::StakeProof<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, T1>>(v0)) {
            v1 = v1 + 0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::get_reward_amount<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, T1>(arg1, 0x1::vector::borrow<0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::StakeProof<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, T1>>(v0, v2), 0x2::clock::timestamp_ms(arg2));
            v2 = v2 + 1;
        };
        v1
    }

    // decompiled from Move bytecode v6
}

