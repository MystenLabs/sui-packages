module 0xa7aeb8099c46d82355d5a90b4282d376fa83ac76cf62d19c64b55944f215164e::private_airdrops {
    struct Droplet<phantom T0> has store, key {
        id: 0x2::object::UID,
        droplet_id: 0x1::string::String,
        sender: address,
        total_amount: u64,
        claimed_amount: u64,
        receiver_limit: u64,
        num_claimed: u64,
        created_at: u64,
        expiry_time: u64,
        claimed: 0x2::table::Table<address, bool>,
        device_claims: 0x2::table::Table<0x1::string::String, bool>,
        claimers_list: vector<address>,
        coin: 0x2::coin::Coin<T0>,
        is_closed: bool,
        message: 0x1::string::String,
        distribution_type: u8,
        claim_restriction: u8,
        authorized_addresses: 0x2::vec_set::VecSet<address>,
        allocation_amounts: 0x2::table::Table<address, u64>,
        random_shares: 0x2::table::Table<u64, u64>,
        address_to_index: 0x2::table::Table<address, u64>,
        token_type_name: 0x1::string::String,
    }

    struct DropletInfo has copy, drop {
        droplet_id: 0x1::string::String,
        sender: address,
        total_amount: u64,
        claimed_amount: u64,
        remaining_amount: u64,
        receiver_limit: u64,
        num_claimed: u64,
        created_at: u64,
        expiry_time: u64,
        is_expired: bool,
        is_closed: bool,
        message: 0x1::string::String,
        claimers: vector<address>,
        distribution_type: u8,
        claim_restriction: u8,
        authorized_count: u64,
        token_type: 0x1::string::String,
    }

    struct DropletCreated has copy, drop {
        droplet_id: 0x1::string::String,
        droplet_object_id: address,
        sender: address,
        total_amount: u64,
        fee_amount: u64,
        net_amount: u64,
        token_type: 0x1::string::String,
        receiver_limit: u64,
        expiry_hours: u64,
        message: 0x1::string::String,
        amount_per_receiver: u64,
        created_at: u64,
        expiry_time: u64,
        distribution_type: u8,
        claim_restriction: u8,
        authorized_count: u64,
    }

    struct DropletClaimed has copy, drop {
        droplet_id: 0x1::string::String,
        claimer: address,
        token_type: 0x1::string::String,
        claim_amount: u64,
        message: 0x1::string::String,
        claimed_at: u64,
        device_fingerprint: 0x1::option::Option<0x1::string::String>,
    }

    struct AirdropDeleted has copy, drop {
        droplet_id: 0x1::string::String,
        sender: address,
        refund_amount: u64,
        deleted_at: u64,
    }

    struct AuthorizedAddressRemoved has copy, drop {
        droplet_id: 0x1::string::String,
        address: address,
        removed_by: address,
        timestamp: u64,
    }

    struct FeeCollected has copy, drop {
        droplet_id: 0x1::string::String,
        token_type: 0x1::string::String,
        fee_amount: u64,
        recipient: address,
        timestamp: u64,
    }

    struct BatchSendCompleted has copy, drop {
        sender: address,
        distribution_type: u8,
        total_amount: u64,
        fee_amount: u64,
        receiver_count: u64,
        timestamp: u64,
    }

    public fun all_random_shares<T0>(arg0: &Droplet<T0>) : vector<u64> {
        let v0 = vector[];
        if (arg0.distribution_type == 1) {
            let v1 = 0;
            while (v1 < arg0.receiver_limit) {
                if (0x2::table::contains<u64, u64>(&arg0.random_shares, v1)) {
                    0x1::vector::push_back<u64>(&mut v0, *0x2::table::borrow<u64, u64>(&arg0.random_shares, v1));
                };
                v1 = v1 + 1;
            };
        };
        v0
    }

    public fun authorized_count<T0>(arg0: &Droplet<T0>) : u64 {
        0x2::vec_set::length<address>(&arg0.authorized_addresses)
    }

    entry fun batch_direct_send<T0>(arg0: &mut 0xa7aeb8099c46d82355d5a90b4282d376fa83ac76cf62d19c64b55944f215164e::types::DropletRegistry, arg1: u8, arg2: vector<address>, arg3: 0x1::option::Option<vector<u64>>, arg4: 0x2::coin::Coin<T0>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<address>(&arg2);
        assert!(v0 > 0, 26);
        assert!(arg1 <= 2, 14);
        let v1 = 0x2::tx_context::sender(arg6);
        let v2 = 0x2::clock::timestamp_ms(arg5);
        let v3 = 0x2::coin::value<T0>(&arg4);
        let v4 = v3 * 0xa7aeb8099c46d82355d5a90b4282d376fa83ac76cf62d19c64b55944f215164e::types::fee_percentage(arg0) / (10000 + 0xa7aeb8099c46d82355d5a90b4282d376fa83ac76cf62d19c64b55944f215164e::types::fee_percentage(arg0));
        let v5 = v3 - v4;
        assert!(v5 > 0, 2);
        if (v4 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg4, v4, arg6), 0xa7aeb8099c46d82355d5a90b4282d376fa83ac76cf62d19c64b55944f215164e::types::contract_owner());
        };
        0xa7aeb8099c46d82355d5a90b4282d376fa83ac76cf62d19c64b55944f215164e::types::accumulate_fee(arg0, 0xa7aeb8099c46d82355d5a90b4282d376fa83ac76cf62d19c64b55944f215164e::types::coin_type_name<T0>(), v4);
        if (arg1 == 0) {
            let v6 = v5 / v0;
            assert!(v6 > 0, 2);
            let v7 = 0;
            while (v7 < v0) {
                let v8 = if (v7 == v0 - 1) {
                    0x2::coin::value<T0>(&arg4)
                } else {
                    v6
                };
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg4, v8, arg6), *0x1::vector::borrow<address>(&arg2, v7));
                v7 = v7 + 1;
            };
        } else if (arg1 == 1) {
            assert!(v5 >= v0 * (v0 + 1) / 2, 19);
            let v9 = vector[];
            let v10 = 0;
            let v11 = 0;
            while (v11 < v0) {
                let v12 = 0xa7aeb8099c46d82355d5a90b4282d376fa83ac76cf62d19c64b55944f215164e::types::generate_random_weight(v1, v11, v2, 0x1::string::utf8(b"BATCH"));
                0x1::vector::push_back<u64>(&mut v9, v12);
                v10 = v10 + v12;
                v11 = v11 + 1;
            };
            let v13 = 0;
            v11 = 1;
            while (v11 <= v0) {
                v13 = v13 + v11;
                v11 = v11 + 1;
            };
            let v14 = v5 - v13;
            let v15 = vector[];
            let v16 = vector[];
            let v17 = 0;
            v11 = 0;
            while (v11 < v0) {
                let v18 = *0x1::vector::borrow<u64>(&v9, v11);
                let v19 = v14 * v18 / v10;
                0x1::vector::push_back<u64>(&mut v15, v19);
                0x1::vector::push_back<u64>(&mut v16, (((v14 as u128) * (v18 as u128) * 10000 / (v10 as u128) % 10000) as u64));
                v17 = v17 + v19;
                v11 = v11 + 1;
            };
            let v20 = vector[];
            v11 = 0;
            while (v11 < v0) {
                0x1::vector::push_back<u64>(&mut v20, 0);
                v11 = v11 + 1;
            };
            let v21 = 0;
            while (v21 < v14 - v17) {
                let v22 = 0;
                let v23 = false;
                v11 = 0;
                while (v11 < v0) {
                    if (*0x1::vector::borrow<u64>(&v20, v11) == 0) {
                        if (!v23 || *0x1::vector::borrow<u64>(&v16, v11) > v22) {
                            v22 = *0x1::vector::borrow<u64>(&v16, v11);
                            v23 = true;
                        };
                    };
                    v11 = v11 + 1;
                };
                if (v23) {
                    *0x1::vector::borrow_mut<u64>(&mut v20, 0) = 1;
                };
                v21 = v21 + 1;
            };
            v11 = 0;
            while (v11 < v0) {
                let v24 = if (v11 == v0 - 1) {
                    0x2::coin::value<T0>(&arg4)
                } else {
                    v11 + 1 + *0x1::vector::borrow<u64>(&v15, v11) + *0x1::vector::borrow<u64>(&v20, v11)
                };
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg4, v24, arg6), *0x1::vector::borrow<address>(&arg2, v11));
                v11 = v11 + 1;
            };
        } else {
            assert!(0x1::option::is_some<vector<u64>>(&arg3), 22);
            let v25 = 0x1::option::borrow<vector<u64>>(&arg3);
            assert!(0x1::vector::length<u64>(v25) == v0, 25);
            let v26 = 0;
            let v27 = 0;
            while (v27 < v0) {
                v26 = v26 + *0x1::vector::borrow<u64>(v25, v27);
                v27 = v27 + 1;
            };
            assert!(v26 == v5, 23);
            v27 = 0;
            while (v27 < v0) {
                let v28 = if (v27 == v0 - 1) {
                    0x2::coin::value<T0>(&arg4)
                } else {
                    *0x1::vector::borrow<u64>(v25, v27)
                };
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg4, v28, arg6), *0x1::vector::borrow<address>(&arg2, v27));
                v27 = v27 + 1;
            };
        };
        0x2::coin::destroy_zero<T0>(arg4);
        let v29 = BatchSendCompleted{
            sender            : v1,
            distribution_type : arg1,
            total_amount      : v5,
            fee_amount        : v4,
            receiver_count    : v0,
            timestamp         : v2,
        };
        0x2::event::emit<BatchSendCompleted>(v29);
    }

    public fun can_delete<T0>(arg0: &Droplet<T0>, arg1: address) : bool {
        if (arg1 == arg0.sender) {
            if (arg0.num_claimed == 0) {
                !arg0.is_closed
            } else {
                false
            }
        } else {
            false
        }
    }

    public fun check_addresses_authorization<T0>(arg0: &Droplet<T0>, arg1: vector<address>) : vector<bool> {
        let v0 = vector[];
        let v1 = 0;
        while (v1 < 0x1::vector::length<address>(&arg1)) {
            0x1::vector::push_back<bool>(&mut v0, is_authorized<T0>(arg0, *0x1::vector::borrow<address>(&arg1, v1)));
            v1 = v1 + 1;
        };
        v0
    }

    public fun check_distinct_shares<T0>(arg0: &Droplet<T0>) : bool {
        if (arg0.distribution_type != 1) {
            return false
        };
        let v0 = all_random_shares<T0>(arg0);
        let v1 = 0x1::vector::length<u64>(&v0);
        let v2 = 0;
        while (v2 < v1) {
            let v3 = v2 + 1;
            while (v3 < v1) {
                if (*0x1::vector::borrow<u64>(&v0, v2) == *0x1::vector::borrow<u64>(&v0, v3)) {
                    return false
                };
                v3 = v3 + 1;
            };
            v2 = v2 + 1;
        };
        true
    }

    entry fun claim_private_airdrop<T0>(arg0: &mut 0xa7aeb8099c46d82355d5a90b4282d376fa83ac76cf62d19c64b55944f215164e::types::DropletRegistry, arg1: &mut Droplet<T0>, arg2: 0x1::option::Option<0x1::string::String>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        assert!(0x2::vec_set::contains<address>(&arg1.authorized_addresses, &v0), 20);
        assert!(!arg1.is_closed, 6);
        assert!(!0x2::table::contains<address, bool>(&arg1.claimed, v0), 3);
        if (arg1.claim_restriction == 1) {
            assert!(0x1::option::is_some<0x1::string::String>(&arg2), 18);
            if (0x2::table::contains<0x1::string::String, bool>(&arg1.device_claims, *0x1::option::borrow<0x1::string::String>(&arg2))) {
                abort 4
            };
        };
        assert!(arg1.num_claimed < arg1.receiver_limit, 7);
        if (v1 >= arg1.expiry_time) {
            cleanup_expired_droplet<T0>(arg1, arg4);
            abort 5
        };
        let v2 = 0x2::coin::value<T0>(&arg1.coin);
        assert!(v2 > 0, 8);
        let v3 = if (arg1.distribution_type == 2) {
            *0x2::table::borrow<address, u64>(&arg1.allocation_amounts, v0)
        } else if (arg1.distribution_type == 1) {
            *0x2::table::borrow<u64, u64>(&arg1.random_shares, *0x2::table::borrow<address, u64>(&arg1.address_to_index, v0))
        } else {
            0xa7aeb8099c46d82355d5a90b4282d376fa83ac76cf62d19c64b55944f215164e::types::calculate_claim_amount(v2, arg1.receiver_limit - arg1.num_claimed)
        };
        assert!(v3 > 0, 8);
        let v4 = if (v3 > v2) {
            v2
        } else {
            v3
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg1.coin, v4, arg4), v0);
        0x2::table::add<address, bool>(&mut arg1.claimed, v0, true);
        if (arg1.claim_restriction == 1 && 0x1::option::is_some<0x1::string::String>(&arg2)) {
            0x2::table::add<0x1::string::String, bool>(&mut arg1.device_claims, *0x1::option::borrow<0x1::string::String>(&arg2), true);
        };
        0x1::vector::push_back<address>(&mut arg1.claimers_list, v0);
        arg1.num_claimed = arg1.num_claimed + 1;
        arg1.claimed_amount = arg1.claimed_amount + v4;
        0xa7aeb8099c46d82355d5a90b4282d376fa83ac76cf62d19c64b55944f215164e::types::update_user_history(arg0, v0, arg1.droplet_id, false);
        let v5 = DropletClaimed{
            droplet_id         : arg1.droplet_id,
            claimer            : v0,
            token_type         : 0xa7aeb8099c46d82355d5a90b4282d376fa83ac76cf62d19c64b55944f215164e::types::coin_type_name<T0>(),
            claim_amount       : v4,
            message            : arg1.message,
            claimed_at         : v1,
            device_fingerprint : arg2,
        };
        0x2::event::emit<DropletClaimed>(v5);
        if (arg1.num_claimed >= arg1.receiver_limit || 0x2::coin::value<T0>(&arg1.coin) == 0) {
            cleanup_expired_droplet<T0>(arg1, arg4);
        };
    }

    public fun claim_restriction_address() : u8 {
        0
    }

    public fun claim_restriction_device() : u8 {
        1
    }

    public fun claimers<T0>(arg0: &Droplet<T0>) : vector<address> {
        arg0.claimers_list
    }

    entry fun cleanup_droplet<T0>(arg0: &mut Droplet<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg1) >= arg0.expiry_time, 5);
        assert!(!arg0.is_closed, 6);
        cleanup_expired_droplet<T0>(arg0, arg2);
    }

    fun cleanup_expired_droplet<T0>(arg0: &mut Droplet<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.is_closed, 6);
        let v0 = 0x2::coin::value<T0>(&arg0.coin);
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg0.coin, v0, arg1), arg0.sender);
        };
        arg0.is_closed = true;
    }

    entry fun create_private_airdrop<T0>(arg0: &mut 0xa7aeb8099c46d82355d5a90b4282d376fa83ac76cf62d19c64b55944f215164e::types::DropletRegistry, arg1: u64, arg2: 0x1::option::Option<u64>, arg3: 0x1::string::String, arg4: u8, arg5: u8, arg6: vector<address>, arg7: 0x1::option::Option<vector<u64>>, arg8: 0x2::coin::Coin<T0>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 > 0, 2);
        assert!(arg4 <= 2, 14);
        assert!(arg5 <= 1, 17);
        assert!(0x1::vector::length<address>(&arg6) > 0, 21);
        let v0 = 0x1::vector::length<address>(&arg6);
        assert!(v0 <= 0xa7aeb8099c46d82355d5a90b4282d376fa83ac76cf62d19c64b55944f215164e::types::max_receiver_limit(), 1);
        let v1 = 0x2::tx_context::sender(arg10);
        let v2 = 0x2::clock::timestamp_ms(arg9);
        let v3 = if (0x1::option::is_some<u64>(&arg2)) {
            0x1::option::destroy_some<u64>(arg2)
        } else {
            0x1::option::destroy_none<u64>(arg2);
            0xa7aeb8099c46d82355d5a90b4282d376fa83ac76cf62d19c64b55944f215164e::types::default_expiry_hours()
        };
        let v4 = v2 + v3 * 0xa7aeb8099c46d82355d5a90b4282d376fa83ac76cf62d19c64b55944f215164e::types::ms_per_hour();
        let v5 = arg1 * 0xa7aeb8099c46d82355d5a90b4282d376fa83ac76cf62d19c64b55944f215164e::types::fee_percentage(arg0) / 10000;
        let v6 = arg1 + v5;
        assert!(0x2::coin::value<T0>(&arg8) >= v6, 2);
        if (v5 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg8, v5, arg10), 0xa7aeb8099c46d82355d5a90b4282d376fa83ac76cf62d19c64b55944f215164e::types::contract_owner());
        };
        let v7 = 0x2::coin::value<T0>(&arg8);
        if (v7 > arg1) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg8, v7 - arg1, arg10), v1);
        };
        let v8 = 0x2::coin::value<T0>(&arg8);
        assert!(v8 == arg1, 2);
        let v9 = 0xa7aeb8099c46d82355d5a90b4282d376fa83ac76cf62d19c64b55944f215164e::admin::generate_droplet_id(v1, v2, arg10);
        let v10 = 0xa7aeb8099c46d82355d5a90b4282d376fa83ac76cf62d19c64b55944f215164e::types::coin_type_name<T0>();
        0xa7aeb8099c46d82355d5a90b4282d376fa83ac76cf62d19c64b55944f215164e::types::accumulate_fee(arg0, v10, v5);
        let v11 = 0x2::vec_set::empty<address>();
        let v12 = 0;
        while (v12 < 0x1::vector::length<address>(&arg6)) {
            let v13 = *0x1::vector::borrow<address>(&arg6, v12);
            assert!(!0x2::vec_set::contains<address>(&v11, &v13), 24);
            0x2::vec_set::insert<address>(&mut v11, v13);
            v12 = v12 + 1;
        };
        let v14 = Droplet<T0>{
            id                   : 0x2::object::new(arg10),
            droplet_id           : v9,
            sender               : v1,
            total_amount         : v8,
            claimed_amount       : 0,
            receiver_limit       : v0,
            num_claimed          : 0,
            created_at           : v2,
            expiry_time          : v4,
            claimed              : 0x2::table::new<address, bool>(arg10),
            device_claims        : 0x2::table::new<0x1::string::String, bool>(arg10),
            claimers_list        : vector[],
            coin                 : arg8,
            is_closed            : false,
            message              : arg3,
            distribution_type    : arg4,
            claim_restriction    : arg5,
            authorized_addresses : v11,
            allocation_amounts   : 0x2::table::new<address, u64>(arg10),
            random_shares        : 0x2::table::new<u64, u64>(arg10),
            address_to_index     : 0x2::table::new<address, u64>(arg10),
            token_type_name      : v10,
        };
        v12 = 0;
        while (v12 < 0x1::vector::length<address>(&arg6)) {
            0x2::table::add<address, u64>(&mut v14.address_to_index, *0x1::vector::borrow<address>(&arg6, v12), v12);
            v12 = v12 + 1;
        };
        if (arg4 == 2) {
            assert!(0x1::option::is_some<vector<u64>>(&arg7), 22);
            let v15 = 0x1::option::borrow<vector<u64>>(&arg7);
            assert!(0x1::vector::length<u64>(v15) == v0, 22);
            let v16 = 0;
            v12 = 0;
            while (v12 < v0) {
                let v17 = *0x1::vector::borrow<u64>(v15, v12);
                v16 = v16 + v17;
                0x2::table::add<address, u64>(&mut v14.allocation_amounts, *0x1::vector::borrow<address>(&arg6, v12), v17);
                v12 = v12 + 1;
            };
            assert!(v16 == v8, 23);
        } else if (arg4 == 1) {
            let v18 = &mut v14;
            precalculate_random_distribution<T0>(v18, arg10);
        };
        let v19 = 0x2::object::id_address<Droplet<T0>>(&v14);
        0xa7aeb8099c46d82355d5a90b4282d376fa83ac76cf62d19c64b55944f215164e::types::register_droplet(arg0, v9, v19);
        0xa7aeb8099c46d82355d5a90b4282d376fa83ac76cf62d19c64b55944f215164e::types::update_user_history(arg0, v1, v9, true);
        let v20 = FeeCollected{
            droplet_id : v9,
            token_type : v10,
            fee_amount : v5,
            recipient  : 0xa7aeb8099c46d82355d5a90b4282d376fa83ac76cf62d19c64b55944f215164e::types::contract_owner(),
            timestamp  : v2,
        };
        0x2::event::emit<FeeCollected>(v20);
        let v21 = if (arg4 == 0) {
            0xa7aeb8099c46d82355d5a90b4282d376fa83ac76cf62d19c64b55944f215164e::types::calculate_claim_amount(v8, v0)
        } else {
            0
        };
        let v22 = DropletCreated{
            droplet_id          : v9,
            droplet_object_id   : v19,
            sender              : v1,
            total_amount        : v6,
            fee_amount          : v5,
            net_amount          : v8,
            token_type          : v10,
            receiver_limit      : v0,
            expiry_hours        : v3,
            message             : arg3,
            amount_per_receiver : v21,
            created_at          : v2,
            expiry_time         : v4,
            distribution_type   : arg4,
            claim_restriction   : arg5,
            authorized_count    : v0,
        };
        0x2::event::emit<DropletCreated>(v22);
        0x2::transfer::share_object<Droplet<T0>>(v14);
    }

    public fun custom_allocation<T0>(arg0: &Droplet<T0>, arg1: address) : 0x1::option::Option<u64> {
        if (arg0.distribution_type == 2 && 0x2::table::contains<address, u64>(&arg0.allocation_amounts, arg1)) {
            0x1::option::some<u64>(*0x2::table::borrow<address, u64>(&arg0.allocation_amounts, arg1))
        } else {
            0x1::option::none<u64>()
        }
    }

    entry fun delete_airdrop<T0>(arg0: &mut Droplet<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.sender, 15);
        assert!(arg0.num_claimed == 0, 16);
        assert!(!arg0.is_closed, 6);
        let v0 = 0x2::coin::value<T0>(&arg0.coin);
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg0.coin, v0, arg2), arg0.sender);
        };
        arg0.is_closed = true;
        let v1 = AirdropDeleted{
            droplet_id    : arg0.droplet_id,
            sender        : arg0.sender,
            refund_amount : v0,
            deleted_at    : 0x2::clock::timestamp_ms(arg1),
        };
        0x2::event::emit<AirdropDeleted>(v1);
    }

    public fun distribution_details<T0>(arg0: &Droplet<T0>) : (u8, u8, u64) {
        (arg0.distribution_type, arg0.claim_restriction, 0x2::vec_set::length<address>(&arg0.authorized_addresses))
    }

    public fun distribution_type_custom() : u8 {
        2
    }

    public fun distribution_type_equal() : u8 {
        0
    }

    public fun distribution_type_random() : u8 {
        1
    }

    public fun droplet_info<T0>(arg0: &Droplet<T0>, arg1: &0x2::clock::Clock) : DropletInfo {
        DropletInfo{
            droplet_id        : arg0.droplet_id,
            sender            : arg0.sender,
            total_amount      : arg0.total_amount,
            claimed_amount    : arg0.claimed_amount,
            remaining_amount  : 0x2::coin::value<T0>(&arg0.coin),
            receiver_limit    : arg0.receiver_limit,
            num_claimed       : arg0.num_claimed,
            created_at        : arg0.created_at,
            expiry_time       : arg0.expiry_time,
            is_expired        : 0x2::clock::timestamp_ms(arg1) >= arg0.expiry_time,
            is_closed         : arg0.is_closed,
            message           : arg0.message,
            claimers          : arg0.claimers_list,
            distribution_type : arg0.distribution_type,
            claim_restriction : arg0.claim_restriction,
            authorized_count  : 0x2::vec_set::length<address>(&arg0.authorized_addresses),
            token_type        : 0xa7aeb8099c46d82355d5a90b4282d376fa83ac76cf62d19c64b55944f215164e::types::coin_type_name<T0>(),
        }
    }

    public fun has_claimed<T0>(arg0: &Droplet<T0>, arg1: address) : bool {
        0x2::table::contains<address, bool>(&arg0.claimed, arg1)
    }

    public fun has_device_claimed<T0>(arg0: &Droplet<T0>, arg1: 0x1::string::String) : bool {
        0x2::table::contains<0x1::string::String, bool>(&arg0.device_claims, arg1)
    }

    public fun is_authorized<T0>(arg0: &Droplet<T0>, arg1: address) : bool {
        0x2::vec_set::contains<address>(&arg0.authorized_addresses, &arg1)
    }

    public fun is_expired<T0>(arg0: &Droplet<T0>, arg1: &0x2::clock::Clock) : bool {
        0x2::clock::timestamp_ms(arg1) >= arg0.expiry_time
    }

    fun precalculate_random_distribution<T0>(arg0: &mut Droplet<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = arg0.total_amount;
        let v1 = arg0.receiver_limit;
        assert!(v0 >= v1 * (v1 + 1) / 2, 19);
        let v2 = 0;
        let v3 = 1;
        while (v3 <= v1) {
            v2 = v2 + v3;
            v3 = v3 + 1;
        };
        let v4 = v0 - v2;
        let v5 = vector[];
        let v6 = 0;
        v3 = 0;
        while (v3 < v1) {
            let v7 = 0xa7aeb8099c46d82355d5a90b4282d376fa83ac76cf62d19c64b55944f215164e::types::generate_random_weight(arg0.sender, v3, arg0.created_at, arg0.droplet_id);
            0x1::vector::push_back<u64>(&mut v5, v7);
            v6 = v6 + v7;
            v3 = v3 + 1;
        };
        let v8 = vector[];
        let v9 = vector[];
        let v10 = 0;
        v3 = 0;
        while (v3 < v1) {
            let v11 = *0x1::vector::borrow<u64>(&v5, v3);
            let v12 = v4 * v11 / v6;
            0x1::vector::push_back<u64>(&mut v8, v12);
            0x1::vector::push_back<u64>(&mut v9, (((v4 as u128) * (v11 as u128) * 10000 / (v6 as u128) % 10000) as u64));
            v10 = v10 + v12;
            v3 = v3 + 1;
        };
        let v13 = vector[];
        v3 = 0;
        while (v3 < v1) {
            0x1::vector::push_back<u64>(&mut v13, 0);
            v3 = v3 + 1;
        };
        let v14 = 0;
        while (v14 < v4 - v10) {
            let v15 = 0;
            let v16 = false;
            v3 = 0;
            while (v3 < v1) {
                if (*0x1::vector::borrow<u64>(&v13, v3) == 0) {
                    if (!v16 || *0x1::vector::borrow<u64>(&v9, v3) > v15) {
                        v15 = *0x1::vector::borrow<u64>(&v9, v3);
                        v16 = true;
                    };
                };
                v3 = v3 + 1;
            };
            if (v16) {
                *0x1::vector::borrow_mut<u64>(&mut v13, 0) = 1;
            };
            v14 = v14 + 1;
        };
        v3 = 0;
        while (v3 < v1) {
            0x2::table::add<u64, u64>(&mut arg0.random_shares, v3, v3 + 1 + *0x1::vector::borrow<u64>(&v8, v3) + *0x1::vector::borrow<u64>(&v13, v3));
            v3 = v3 + 1;
        };
    }

    public fun random_share<T0>(arg0: &Droplet<T0>, arg1: u64) : 0x1::option::Option<u64> {
        if (arg0.distribution_type == 1 && 0x2::table::contains<u64, u64>(&arg0.random_shares, arg1)) {
            0x1::option::some<u64>(*0x2::table::borrow<u64, u64>(&arg0.random_shares, arg1))
        } else {
            0x1::option::none<u64>()
        }
    }

    public fun remaining_balance<T0>(arg0: &Droplet<T0>) : u64 {
        0x2::coin::value<T0>(&arg0.coin)
    }

    entry fun remove_authorized_address<T0>(arg0: &mut Droplet<T0>, arg1: address, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(v0 == arg0.sender, 15);
        assert!(!arg0.is_closed, 6);
        assert!(0x2::vec_set::contains<address>(&arg0.authorized_addresses, &arg1), 20);
        assert!(!0x2::table::contains<address, bool>(&arg0.claimed, arg1), 3);
        0x2::vec_set::remove<address>(&mut arg0.authorized_addresses, &arg1);
        arg0.receiver_limit = arg0.receiver_limit - 1;
        if (0x2::table::contains<address, u64>(&arg0.allocation_amounts, arg1)) {
            0x2::table::remove<address, u64>(&mut arg0.allocation_amounts, arg1);
        };
        if (0x2::table::contains<address, u64>(&arg0.address_to_index, arg1)) {
            0x2::table::remove<address, u64>(&mut arg0.address_to_index, arg1);
        };
        let v1 = AuthorizedAddressRemoved{
            droplet_id : arg0.droplet_id,
            address    : arg1,
            removed_by : v0,
            timestamp  : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<AuthorizedAddressRemoved>(v1);
    }

    public fun verify_custom_distribution<T0>(arg0: &Droplet<T0>) : (bool, u64, u64) {
        if (arg0.distribution_type != 2) {
            return (false, 0, 0)
        };
        (true, arg0.total_amount, arg0.total_amount)
    }

    public fun verify_random_distribution<T0>(arg0: &Droplet<T0>) : (bool, u64, u64) {
        if (arg0.distribution_type != 1) {
            return (false, 0, 0)
        };
        let v0 = 0;
        let v1 = 0;
        while (v1 < arg0.receiver_limit) {
            if (0x2::table::contains<u64, u64>(&arg0.random_shares, v1)) {
                v0 = v0 + *0x2::table::borrow<u64, u64>(&arg0.random_shares, v1);
            };
            v1 = v1 + 1;
        };
        (v0 == arg0.total_amount, v0, arg0.total_amount)
    }

    // decompiled from Move bytecode v6
}

