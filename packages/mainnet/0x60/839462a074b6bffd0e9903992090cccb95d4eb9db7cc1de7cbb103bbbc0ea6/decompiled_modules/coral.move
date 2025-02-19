module 0x60839462a074b6bffd0e9903992090cccb95d4eb9db7cc1de7cbb103bbbc0ea6::coral {
    struct CreatorCap has store, key {
        id: 0x2::object::UID,
    }

    struct FeeCollectorCap has store, key {
        id: 0x2::object::UID,
    }

    struct Coral has key {
        id: 0x2::object::UID,
        channel: 0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::channel::Channel,
        order_hash_to_status: 0x2::bag::Bag,
        settlement_to_status: 0x2::bag::Bag,
        token_to_collected_fees: 0x2::bag::Bag,
        hub_chain: 0x1::string::String,
        hub_address: 0x1::string::String,
        message_id_to_release_batch: 0x2::bag::Bag,
    }

    fun add_created_order<T0>(arg0: &mut Coral, arg1: vector<u8>, arg2: 0x2::coin::Coin<T0>) {
        0x2::bag::add<vector<u8>, 0x60839462a074b6bffd0e9903992090cccb95d4eb9db7cc1de7cbb103bbbc0ea6::order_status::OrderStatus<T0>>(&mut arg0.order_hash_to_status, arg1, 0x60839462a074b6bffd0e9903992090cccb95d4eb9db7cc1de7cbb103bbbc0ea6::order_status::created<T0>(arg2));
    }

    fun add_filled_settlement<T0>(arg0: &mut Coral, arg1: vector<u8>) {
        0x2::bag::add<vector<u8>, 0x60839462a074b6bffd0e9903992090cccb95d4eb9db7cc1de7cbb103bbbc0ea6::settlement_status::SettlementStatus<T0>>(&mut arg0.settlement_to_status, arg1, 0x60839462a074b6bffd0e9903992090cccb95d4eb9db7cc1de7cbb103bbbc0ea6::settlement_status::filled<T0>());
    }

    fun add_forwarded_settlement<T0>(arg0: &mut Coral, arg1: vector<u8>) {
        0x2::bag::add<vector<u8>, 0x60839462a074b6bffd0e9903992090cccb95d4eb9db7cc1de7cbb103bbbc0ea6::settlement_status::SettlementStatus<T0>>(&mut arg0.settlement_to_status, arg1, 0x60839462a074b6bffd0e9903992090cccb95d4eb9db7cc1de7cbb103bbbc0ea6::settlement_status::forwarded<T0>());
    }

    fun add_refunded_order<T0>(arg0: &mut Coral, arg1: vector<u8>) {
        0x2::bag::add<vector<u8>, 0x60839462a074b6bffd0e9903992090cccb95d4eb9db7cc1de7cbb103bbbc0ea6::order_status::OrderStatus<T0>>(&mut arg0.order_hash_to_status, arg1, 0x60839462a074b6bffd0e9903992090cccb95d4eb9db7cc1de7cbb103bbbc0ea6::order_status::refunded<T0>());
    }

    fun add_settled_order<T0>(arg0: &mut Coral, arg1: vector<u8>) {
        0x2::bag::add<vector<u8>, 0x60839462a074b6bffd0e9903992090cccb95d4eb9db7cc1de7cbb103bbbc0ea6::order_status::OrderStatus<T0>>(&mut arg0.order_hash_to_status, arg1, 0x60839462a074b6bffd0e9903992090cccb95d4eb9db7cc1de7cbb103bbbc0ea6::order_status::settled<T0>());
    }

    fun assert_new_order<T0>(arg0: &Coral, arg1: vector<u8>) {
        assert!(!0x2::bag::contains_with_type<vector<u8>, 0x60839462a074b6bffd0e9903992090cccb95d4eb9db7cc1de7cbb103bbbc0ea6::order_status::OrderStatus<T0>>(&arg0.order_hash_to_status, arg1), 9223372543660982274);
    }

    fun assert_new_settlement<T0>(arg0: &Coral, arg1: vector<u8>) {
        assert!(!0x2::bag::contains_with_type<vector<u8>, 0x60839462a074b6bffd0e9903992090cccb95d4eb9db7cc1de7cbb103bbbc0ea6::settlement_status::SettlementStatus<T0>>(&arg0.settlement_to_status, arg1), 9223372681100066820);
    }

    entry fun batch_fill_order<T0>(arg0: &mut Coral, arg1: 0x2::coin::Coin<T0>, arg2: vector<vector<u8>>, arg3: vector<vector<u8>>, arg4: vector<vector<u8>>, arg5: vector<vector<u8>>, arg6: vector<vector<u8>>, arg7: vector<vector<u8>>, arg8: vector<u256>, arg9: vector<u256>, arg10: vector<u256>, arg11: vector<u256>, arg12: vector<u256>, arg13: vector<u256>, arg14: vector<vector<u8>>, arg15: &mut 0x2::tx_context::TxContext) {
        let v0 = if (0x1::vector::length<vector<u8>>(&arg2) == 0x1::vector::length<vector<u8>>(&arg3)) {
            if (0x1::vector::length<vector<u8>>(&arg2) == 0x1::vector::length<vector<u8>>(&arg4)) {
                if (0x1::vector::length<vector<u8>>(&arg2) == 0x1::vector::length<vector<u8>>(&arg5)) {
                    if (0x1::vector::length<vector<u8>>(&arg2) == 0x1::vector::length<vector<u8>>(&arg6)) {
                        if (0x1::vector::length<vector<u8>>(&arg2) == 0x1::vector::length<vector<u8>>(&arg7)) {
                            if (0x1::vector::length<vector<u8>>(&arg2) == 0x1::vector::length<u256>(&arg8)) {
                                if (0x1::vector::length<vector<u8>>(&arg2) == 0x1::vector::length<u256>(&arg9)) {
                                    if (0x1::vector::length<vector<u8>>(&arg2) == 0x1::vector::length<u256>(&arg10)) {
                                        if (0x1::vector::length<vector<u8>>(&arg2) == 0x1::vector::length<u256>(&arg11)) {
                                            if (0x1::vector::length<vector<u8>>(&arg2) == 0x1::vector::length<u256>(&arg12)) {
                                                if (0x1::vector::length<vector<u8>>(&arg2) == 0x1::vector::length<u256>(&arg13)) {
                                                    0x1::vector::length<vector<u8>>(&arg2) == 0x1::vector::length<vector<u8>>(&arg14)
                                                } else {
                                                    false
                                                }
                                            } else {
                                                false
                                            }
                                        } else {
                                            false
                                        }
                                    } else {
                                        false
                                    }
                                } else {
                                    false
                                }
                            } else {
                                false
                            }
                        } else {
                            false
                        }
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 9223374210108555270);
        let v1 = *0x1::vector::borrow<vector<u8>>(&arg7, 0);
        let v2 = &arg7;
        let v3 = 0;
        let v4;
        while (v3 < 0x1::vector::length<vector<u8>>(v2)) {
            if (!(0x1::vector::borrow<vector<u8>>(v2, v3) == &v1)) {
                v4 = false;
                /* label 31 */
                assert!(v4, 9223374231583522824);
                let v5 = 0;
                while (v5 < 0x1::vector::length<vector<u8>>(&arg2)) {
                    let v6 = *0x1::vector::borrow<u256>(&arg10, v5);
                    fill_order_internal<T0>(arg0, arg15, 0x2::coin::split<T0>(&mut arg1, (v6 as u64), arg15), *0x1::vector::borrow<vector<u8>>(&arg2, v5), *0x1::vector::borrow<vector<u8>>(&arg3, v5), *0x1::vector::borrow<vector<u8>>(&arg4, v5), *0x1::vector::borrow<vector<u8>>(&arg5, v5), *0x1::vector::borrow<vector<u8>>(&arg6, v5), *0x1::vector::borrow<vector<u8>>(&arg7, v5), *0x1::vector::borrow<u256>(&arg8, v5), *0x1::vector::borrow<u256>(&arg9, v5), v6, *0x1::vector::borrow<u256>(&arg11, v5), *0x1::vector::borrow<u256>(&arg12, v5), *0x1::vector::borrow<u256>(&arg13, v5), *0x1::vector::borrow<vector<u8>>(&arg14, v5));
                    v5 = v5 + 1;
                };
                assert!(0x2::coin::value<T0>(&arg1) == 0, 9223374437743001624);
                0x2::coin::destroy_zero<T0>(arg1);
                return
            };
            v3 = v3 + 1;
        };
        v4 = true;
        /* goto 31 */
    }

    entry fun collect_fees<T0>(arg0: &FeeCollectorCap, arg1: &mut Coral, arg2: 0x1::ascii::String, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = get_collected_fee<T0>(arg1, arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v0, arg3), 0x2::tx_context::sender(arg3));
        0x60839462a074b6bffd0e9903992090cccb95d4eb9db7cc1de7cbb103bbbc0ea6::events::fee_collected(0x2::tx_context::sender(arg3), arg2, 0x2::balance::value<T0>(&v0));
    }

    entry fun create_order<T0>(arg0: &mut Coral, arg1: &0x2::clock::Clock, arg2: 0x2::coin::Coin<T0>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<u8>, arg8: vector<u8>, arg9: u256, arg10: u256, arg11: u256, arg12: u256, arg13: u256, arg14: u256, arg15: vector<u8>, arg16: &0x2::tx_context::TxContext) {
        let v0 = 0x60839462a074b6bffd0e9903992090cccb95d4eb9db7cc1de7cbb103bbbc0ea6::order::new(arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15);
        let v1 = 0x60839462a074b6bffd0e9903992090cccb95d4eb9db7cc1de7cbb103bbbc0ea6::order::order_hash(&v0);
        assert_new_order<T0>(arg0, v1);
        0x60839462a074b6bffd0e9903992090cccb95d4eb9db7cc1de7cbb103bbbc0ea6::order::verify_signer(&v0, 0x2::tx_context::sender(arg16));
        0x60839462a074b6bffd0e9903992090cccb95d4eb9db7cc1de7cbb103bbbc0ea6::order::verify_expiry(&v0, 0x2::clock::timestamp_ms(arg1));
        0x60839462a074b6bffd0e9903992090cccb95d4eb9db7cc1de7cbb103bbbc0ea6::order::verify_from_chain_is_sui(&v0, 1000001);
        0x60839462a074b6bffd0e9903992090cccb95d4eb9db7cc1de7cbb103bbbc0ea6::order::verify_order_from_amount(&v0, 0x2::coin::value<T0>(&arg2));
        0x60839462a074b6bffd0e9903992090cccb95d4eb9db7cc1de7cbb103bbbc0ea6::order::verify_from_token<T0>(&v0);
        add_created_order<T0>(arg0, v1, arg2);
        0x60839462a074b6bffd0e9903992090cccb95d4eb9db7cc1de7cbb103bbbc0ea6::events::order_created(v1, v0);
    }

    fun decode_hub_payload(arg0: vector<u8>) : (u8, vector<vector<u8>>, address, vector<u256>, vector<u256>, vector<vector<u8>>) {
        let v0 = 0x60839462a074b6bffd0e9903992090cccb95d4eb9db7cc1de7cbb103bbbc0ea6::abi::new_reader(arg0);
        let v1 = vector[];
        let v2 = 0x60839462a074b6bffd0e9903992090cccb95d4eb9db7cc1de7cbb103bbbc0ea6::abi::read_vector_u256(&mut v0);
        0x1::vector::reverse<u256>(&mut v2);
        while (0x1::vector::length<u256>(&v2) != 0) {
            0x1::vector::push_back<vector<u8>>(&mut v1, 0x2::address::to_bytes(0x2::address::from_u256(0x1::vector::pop_back<u256>(&mut v2))));
        };
        0x1::vector::destroy_empty<u256>(v2);
        ((0x60839462a074b6bffd0e9903992090cccb95d4eb9db7cc1de7cbb103bbbc0ea6::abi::read_u256(&mut v0) as u8), v1, 0x2::address::from_bytes(0x60839462a074b6bffd0e9903992090cccb95d4eb9db7cc1de7cbb103bbbc0ea6::abi::read_bytes(&mut v0)), 0x60839462a074b6bffd0e9903992090cccb95d4eb9db7cc1de7cbb103bbbc0ea6::abi::read_vector_u256(&mut v0), 0x60839462a074b6bffd0e9903992090cccb95d4eb9db7cc1de7cbb103bbbc0ea6::abi::read_vector_u256(&mut v0), 0x60839462a074b6bffd0e9903992090cccb95d4eb9db7cc1de7cbb103bbbc0ea6::abi::read_vector_bytes(&mut v0))
    }

    fun encode_forward_settlements_payload(arg0: vector<vector<u8>>) : vector<u8> {
        let v0 = vector[];
        0x1::vector::reverse<vector<u8>>(&mut arg0);
        while (0x1::vector::length<vector<u8>>(&arg0) != 0) {
            0x1::vector::push_back<u256>(&mut v0, 0x2::address::to_u256(0x2::address::from_bytes(0x1::vector::pop_back<vector<u8>>(&mut arg0))));
        };
        0x1::vector::destroy_empty<vector<u8>>(arg0);
        let v1 = 0x60839462a074b6bffd0e9903992090cccb95d4eb9db7cc1de7cbb103bbbc0ea6::abi::new_writer(1);
        0x60839462a074b6bffd0e9903992090cccb95d4eb9db7cc1de7cbb103bbbc0ea6::abi::write_vector_u256(&mut v1, v0);
        0x60839462a074b6bffd0e9903992090cccb95d4eb9db7cc1de7cbb103bbbc0ea6::abi::into_bytes(v1)
    }

    public fun execute(arg0: 0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::channel::ApprovedMessage, arg1: &mut Coral) {
        let (v0, v1, v2, v3) = 0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::channel::consume_approved_message(&arg1.channel, arg0);
        assert!(v0 == 0x1::string::to_ascii(arg1.hub_chain) && v2 == 0x1::string::to_ascii(arg1.hub_address), 9223375206542016534);
        let (v4, v5, v6, v7, v8, v9) = decode_hub_payload(v3);
        store_release_batch(arg1, v1, 0x60839462a074b6bffd0e9903992090cccb95d4eb9db7cc1de7cbb103bbbc0ea6::release_batch::new(v4, v5, v6, v7, v8, v9));
        0x60839462a074b6bffd0e9903992090cccb95d4eb9db7cc1de7cbb103bbbc0ea6::events::received_release_batch(v1, v5);
    }

    entry fun fill_order<T0>(arg0: &mut Coral, arg1: 0x2::coin::Coin<T0>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<u8>, arg8: u256, arg9: u256, arg10: u256, arg11: u256, arg12: u256, arg13: u256, arg14: vector<u8>, arg15: &0x2::tx_context::TxContext) {
        fill_order_internal<T0>(arg0, arg15, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
    }

    fun fill_order_internal<T0>(arg0: &mut Coral, arg1: &0x2::tx_context::TxContext, arg2: 0x2::coin::Coin<T0>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<u8>, arg8: vector<u8>, arg9: u256, arg10: u256, arg11: u256, arg12: u256, arg13: u256, arg14: u256, arg15: vector<u8>) {
        let v0 = 0x60839462a074b6bffd0e9903992090cccb95d4eb9db7cc1de7cbb103bbbc0ea6::order::new(arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15);
        let v1 = 0x60839462a074b6bffd0e9903992090cccb95d4eb9db7cc1de7cbb103bbbc0ea6::order::order_hash(&v0);
        assert_new_settlement<T0>(arg0, v1);
        0x60839462a074b6bffd0e9903992090cccb95d4eb9db7cc1de7cbb103bbbc0ea6::order::verify_filler(&v0, 0x2::tx_context::sender(arg1));
        0x60839462a074b6bffd0e9903992090cccb95d4eb9db7cc1de7cbb103bbbc0ea6::order::verify_to_chain_is_sui(&v0, 1000001);
        add_filled_settlement<T0>(arg0, v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg2, 0x2::address::from_bytes(arg4));
        0x60839462a074b6bffd0e9903992090cccb95d4eb9db7cc1de7cbb103bbbc0ea6::events::order_filled(v1, v0);
    }

    entry fun forward_settlements<T0>(arg0: &mut Coral, arg1: &0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::gateway::Gateway, arg2: &mut 0xc10dd54f42a2f3ebdb8f113bd0a0627934c90e608d1e32e5fd0c7ae4d03d93b3::gas_service::GasService, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: vector<vector<u8>>, arg5: &0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg3) > 0, 9223374966023192588);
        assert!(0x1::vector::length<vector<u8>>(&arg4) > 0, 9223374978907963402);
        let v0 = 0;
        while (v0 < 0x1::vector::length<vector<u8>>(&arg4)) {
            let v1 = get_settlement_by_hash<T0>(arg0, *0x1::vector::borrow<vector<u8>>(&arg4, v0));
            assert!(0x60839462a074b6bffd0e9903992090cccb95d4eb9db7cc1de7cbb103bbbc0ea6::settlement_status::is_filled<T0>(v1), 9223375004678029326);
            add_forwarded_settlement<T0>(arg0, *0x1::vector::borrow<vector<u8>>(&arg4, v0));
            0x60839462a074b6bffd0e9903992090cccb95d4eb9db7cc1de7cbb103bbbc0ea6::events::settlement_forwarded(*0x1::vector::borrow<vector<u8>>(&arg4, v0));
            v0 = v0 + 1;
        };
        let v2 = 0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::gateway::prepare_message(&arg0.channel, 0x1::string::to_ascii(arg0.hub_chain), 0x1::string::to_ascii(arg0.hub_address), encode_forward_settlements_payload(arg4));
        0xc10dd54f42a2f3ebdb8f113bd0a0627934c90e608d1e32e5fd0c7ae4d03d93b3::gas_service::pay_gas(arg2, &v2, arg3, 0x2::tx_context::sender(arg5), b"");
        0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::gateway::send_message(arg1, v2);
    }

    fun get_collected_fee<T0>(arg0: &mut Coral, arg1: 0x1::ascii::String) : 0x2::balance::Balance<T0> {
        0x2::bag::remove<0x1::ascii::String, 0x2::balance::Balance<T0>>(&mut arg0.token_to_collected_fees, arg1)
    }

    fun get_order_by_hash<T0>(arg0: &mut Coral, arg1: vector<u8>) : 0x60839462a074b6bffd0e9903992090cccb95d4eb9db7cc1de7cbb103bbbc0ea6::order_status::OrderStatus<T0> {
        0x2::bag::remove<vector<u8>, 0x60839462a074b6bffd0e9903992090cccb95d4eb9db7cc1de7cbb103bbbc0ea6::order_status::OrderStatus<T0>>(&mut arg0.order_hash_to_status, arg1)
    }

    fun get_release_batch(arg0: &mut Coral, arg1: 0x1::ascii::String) : 0x60839462a074b6bffd0e9903992090cccb95d4eb9db7cc1de7cbb103bbbc0ea6::release_batch::ReleaseBatch {
        0x2::bag::remove<0x1::ascii::String, 0x60839462a074b6bffd0e9903992090cccb95d4eb9db7cc1de7cbb103bbbc0ea6::release_batch::ReleaseBatch>(&mut arg0.message_id_to_release_batch, arg1)
    }

    fun get_settlement_by_hash<T0>(arg0: &mut Coral, arg1: vector<u8>) : 0x60839462a074b6bffd0e9903992090cccb95d4eb9db7cc1de7cbb103bbbc0ea6::settlement_status::SettlementStatus<T0> {
        0x2::bag::remove<vector<u8>, 0x60839462a074b6bffd0e9903992090cccb95d4eb9db7cc1de7cbb103bbbc0ea6::settlement_status::SettlementStatus<T0>>(&mut arg0.settlement_to_status, arg1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = CreatorCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<CreatorCap>(v0, 0x2::tx_context::sender(arg0));
    }

    entry fun refund_order<T0>(arg0: &mut Coral, arg1: &0x2::clock::Clock, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<u8>, arg8: u256, arg9: u256, arg10: u256, arg11: u256, arg12: u256, arg13: u256, arg14: vector<u8>, arg15: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x60839462a074b6bffd0e9903992090cccb95d4eb9db7cc1de7cbb103bbbc0ea6::order::new(arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
        0x60839462a074b6bffd0e9903992090cccb95d4eb9db7cc1de7cbb103bbbc0ea6::order::verify_from_chain_is_sui(&v0, 1000001);
        0x60839462a074b6bffd0e9903992090cccb95d4eb9db7cc1de7cbb103bbbc0ea6::order::verify_order_expired(&v0, 0x2::tx_context::sender(arg15), 0x2::clock::timestamp_ms(arg1));
        let v1 = 0x60839462a074b6bffd0e9903992090cccb95d4eb9db7cc1de7cbb103bbbc0ea6::order::order_hash(&v0);
        let v2 = get_order_by_hash<T0>(arg0, v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x60839462a074b6bffd0e9903992090cccb95d4eb9db7cc1de7cbb103bbbc0ea6::order_status::extract_balance_from_created<T0>(v2), arg15), 0x2::address::from_bytes(arg2));
        add_refunded_order<T0>(arg0, v1);
        0x60839462a074b6bffd0e9903992090cccb95d4eb9db7cc1de7cbb103bbbc0ea6::events::order_refunded(v1);
    }

    entry fun release_batched<T0>(arg0: &mut Coral, arg1: 0x1::ascii::String, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = get_release_batch(arg0, arg1);
        let (v1, v2, v3, v4, v5, v6) = 0x60839462a074b6bffd0e9903992090cccb95d4eb9db7cc1de7cbb103bbbc0ea6::release_batch::consume_release_batch(v0);
        let v7 = v6;
        let v8 = v5;
        let v9 = v4;
        let v10 = v2;
        assert!(0x1::vector::length<vector<u8>>(&v10) > 0, 9223375502893973514);
        assert!(v1 == 0, 9223375515779268624);
        let v11 = if (0x1::vector::length<vector<u8>>(&v7) == 1) {
            if (0x1::vector::length<u256>(&v9) == 1) {
                0x1::vector::length<u256>(&v8) == 1
            } else {
                false
            }
        } else {
            false
        };
        assert!(v11, 9223375528664301586);
        let v12 = 0x2::balance::zero<T0>();
        let v13 = 0;
        while (v13 < 0x1::vector::length<vector<u8>>(&v10)) {
            let v14 = get_order_by_hash<T0>(arg0, *0x1::vector::borrow<vector<u8>>(&v10, v13));
            0x2::balance::join<T0>(&mut v12, 0x60839462a074b6bffd0e9903992090cccb95d4eb9db7cc1de7cbb103bbbc0ea6::order_status::extract_balance_from_created<T0>(v14));
            add_settled_order<T0>(arg0, *0x1::vector::borrow<vector<u8>>(&v10, v13));
            0x60839462a074b6bffd0e9903992090cccb95d4eb9db7cc1de7cbb103bbbc0ea6::events::order_released(*0x1::vector::borrow<vector<u8>>(&v10, v13));
            v13 = v13 + 1;
        };
        assert!(0x2::balance::value<T0>(&v12) == (*0x1::vector::borrow<u256>(&v9, 0) as u64), 9223375648923516948);
        store_collected_fee<T0>(arg0, 0x2::balance::split<T0>(&mut v12, (*0x1::vector::borrow<u256>(&v8, 0) as u64)));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v12, arg2), v3);
    }

    entry fun setup(arg0: CreatorCap, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: address, arg4: &mut 0x2b839b25c7133e5e0f8f585cb2e89bf430a6585a88c4a0343ae3b246372d431c::discovery::RelayerDiscovery, arg5: &mut 0x2::tx_context::TxContext) {
        let CreatorCap { id: v0 } = arg0;
        0x2::object::delete(v0);
        let v1 = Coral{
            id                          : 0x2::object::new(arg5),
            channel                     : 0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::channel::new(arg5),
            order_hash_to_status        : 0x2::bag::new(arg5),
            settlement_to_status        : 0x2::bag::new(arg5),
            token_to_collected_fees     : 0x2::bag::new(arg5),
            hub_chain                   : arg1,
            hub_address                 : arg2,
            message_id_to_release_batch : 0x2::bag::new(arg5),
        };
        let v2 = 0x1::vector::empty<vector<u8>>();
        let v3 = &mut v2;
        0x1::vector::push_back<vector<u8>>(v3, x"02");
        0x1::vector::push_back<vector<u8>>(v3, 0x60839462a074b6bffd0e9903992090cccb95d4eb9db7cc1de7cbb103bbbc0ea6::utils::concat<u8>(x"00", 0x2::address::to_bytes(0x2::object::id_address<Coral>(&v1))));
        let v4 = 0x1::type_name::get<Coral>();
        let v5 = 0x1::type_name::get_address(&v4);
        let v6 = 0x1::vector::empty<0x2b839b25c7133e5e0f8f585cb2e89bf430a6585a88c4a0343ae3b246372d431c::transaction::MoveCall>();
        0x1::vector::push_back<0x2b839b25c7133e5e0f8f585cb2e89bf430a6585a88c4a0343ae3b246372d431c::transaction::MoveCall>(&mut v6, 0x2b839b25c7133e5e0f8f585cb2e89bf430a6585a88c4a0343ae3b246372d431c::transaction::new_move_call(0x2b839b25c7133e5e0f8f585cb2e89bf430a6585a88c4a0343ae3b246372d431c::transaction::new_function(0x2::address::from_bytes(0x2::hex::decode(*0x1::ascii::as_bytes(&v5))), 0x1::ascii::string(b"coral"), 0x1::ascii::string(b"execute")), v2, 0x1::vector::empty<0x1::ascii::String>()));
        0x2b839b25c7133e5e0f8f585cb2e89bf430a6585a88c4a0343ae3b246372d431c::discovery::register_transaction(arg4, &v1.channel, 0x2b839b25c7133e5e0f8f585cb2e89bf430a6585a88c4a0343ae3b246372d431c::transaction::new_transaction(true, v6));
        let v7 = FeeCollectorCap{id: 0x2::object::new(arg5)};
        0x2::transfer::transfer<FeeCollectorCap>(v7, arg3);
        0x2::transfer::share_object<Coral>(v1);
    }

    fun store_collected_fee<T0>(arg0: &mut Coral, arg1: 0x2::balance::Balance<T0>) {
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0x1::type_name::get_address(&v0);
        if (0x2::bag::contains_with_type<0x1::ascii::String, 0x2::balance::Balance<T0>>(&arg0.token_to_collected_fees, v1)) {
            0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::ascii::String, 0x2::balance::Balance<T0>>(&mut arg0.token_to_collected_fees, v1), arg1);
        } else {
            0x2::bag::add<0x1::ascii::String, 0x2::balance::Balance<T0>>(&mut arg0.token_to_collected_fees, v1, arg1);
        };
    }

    fun store_release_batch(arg0: &mut Coral, arg1: 0x1::ascii::String, arg2: 0x60839462a074b6bffd0e9903992090cccb95d4eb9db7cc1de7cbb103bbbc0ea6::release_batch::ReleaseBatch) {
        0x2::bag::add<0x1::ascii::String, 0x60839462a074b6bffd0e9903992090cccb95d4eb9db7cc1de7cbb103bbbc0ea6::release_batch::ReleaseBatch>(&mut arg0.message_id_to_release_batch, arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

