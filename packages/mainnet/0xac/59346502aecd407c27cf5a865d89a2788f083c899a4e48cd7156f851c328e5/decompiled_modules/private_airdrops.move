module 0xac59346502aecd407c27cf5a865d89a2788f083c899a4e48cd7156f851c328e5::private_airdrops {
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
        device_claims: 0x1::option::Option<0x2::table::Table<0x1::string::String, bool>>,
        claimers_list: vector<address>,
        coin: 0x2::coin::Coin<T0>,
        is_closed: bool,
        message: 0x1::string::String,
        distribution_type: u8,
        claim_restriction: u8,
        allocations: 0x2::table::Table<address, u64>,
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

    struct DropletClosed has copy, drop {
        droplet_id: 0x1::string::String,
        sender: address,
        refund_amount: u64,
        reason: 0x1::string::String,
    }

    struct DropletDestroyed has copy, drop {
        droplet_id: 0x1::string::String,
        sender: address,
    }

    struct AllowlistRecorded has copy, drop {
        droplet_id: 0x1::string::String,
        addresses: vector<address>,
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

    public fun authorized_count<T0>(arg0: &Droplet<T0>) : u64 {
        arg0.receiver_limit
    }

    entry fun batch_direct_send<T0>(arg0: &mut 0xac59346502aecd407c27cf5a865d89a2788f083c899a4e48cd7156f851c328e5::types::DropletRegistry, arg1: u8, arg2: vector<address>, arg3: 0x1::option::Option<vector<u64>>, arg4: 0x2::coin::Coin<T0>, arg5: &0x2::clock::Clock, arg6: &0x2::random::Random, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<address>(&arg2);
        assert!(v0 > 0, 26);
        assert!(v0 <= 0xac59346502aecd407c27cf5a865d89a2788f083c899a4e48cd7156f851c328e5::types::max_batch_receivers(), 28);
        assert!(arg1 <= 2, 14);
        let v1 = &arg2;
        let v2 = 0;
        while (v2 < 0x1::vector::length<address>(v1)) {
            assert!(*0x1::vector::borrow<address>(v1, v2) != @0x0, 31);
            v2 = v2 + 1;
        };
        let v3 = 0x2::coin::value<T0>(&arg4);
        let v4 = 0xac59346502aecd407c27cf5a865d89a2788f083c899a4e48cd7156f851c328e5::types::fee_inside_total(v3, 0xac59346502aecd407c27cf5a865d89a2788f083c899a4e48cd7156f851c328e5::types::fee_percentage(arg0));
        let v5 = v3 - v4;
        assert!(v5 >= v0, 2);
        if (v4 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg4, v4, arg7), 0xac59346502aecd407c27cf5a865d89a2788f083c899a4e48cd7156f851c328e5::types::fee_recipient(arg0));
        };
        0xac59346502aecd407c27cf5a865d89a2788f083c899a4e48cd7156f851c328e5::types::accumulate_fee(arg0, 0xac59346502aecd407c27cf5a865d89a2788f083c899a4e48cd7156f851c328e5::types::coin_type_name<T0>(), v4);
        if (arg1 == 0) {
            let v6 = 0;
            while (v6 < v0) {
                let v7 = if (v6 == v0 - 1) {
                    0x2::coin::value<T0>(&arg4)
                } else {
                    v5 / v0
                };
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg4, v7, arg7), *0x1::vector::borrow<address>(&arg2, v6));
                v6 = v6 + 1;
            };
        } else if (arg1 == 1) {
            let v8 = 0x2::random::new_generator(arg6, arg7);
            let v9 = 0;
            while (v9 < v0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg4, 0xac59346502aecd407c27cf5a865d89a2788f083c899a4e48cd7156f851c328e5::types::draw_random_share(0x2::coin::value<T0>(&arg4), v0 - v9, &mut v8), arg7), *0x1::vector::borrow<address>(&arg2, v9));
                v9 = v9 + 1;
            };
        } else {
            assert!(0x1::option::is_some<vector<u64>>(&arg3), 22);
            let v10 = 0x1::option::borrow<vector<u64>>(&arg3);
            assert!(0x1::vector::length<u64>(v10) == v0, 25);
            let v11 = 0;
            let v12 = 0;
            while (v12 < v0) {
                assert!(*0x1::vector::borrow<u64>(v10, v12) > 0, 29);
                v11 = v11 + *0x1::vector::borrow<u64>(v10, v12);
                v12 = v12 + 1;
            };
            assert!(v11 == v5, 23);
            v12 = 0;
            while (v12 < v0) {
                let v13 = if (v12 == v0 - 1) {
                    0x2::coin::value<T0>(&arg4)
                } else {
                    *0x1::vector::borrow<u64>(v10, v12)
                };
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg4, v13, arg7), *0x1::vector::borrow<address>(&arg2, v12));
                v12 = v12 + 1;
            };
        };
        0x2::coin::destroy_zero<T0>(arg4);
        let v14 = BatchSendCompleted{
            sender            : 0x2::tx_context::sender(arg7),
            distribution_type : arg1,
            total_amount      : v5,
            fee_amount        : v4,
            receiver_count    : v0,
            timestamp         : 0x2::clock::timestamp_ms(arg5),
        };
        0x2::event::emit<BatchSendCompleted>(v14);
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

    entry fun claim_private_airdrop<T0>(arg0: &mut 0xac59346502aecd407c27cf5a865d89a2788f083c899a4e48cd7156f851c328e5::types::DropletRegistry, arg1: &mut Droplet<T0>, arg2: 0x1::option::Option<0x1::string::String>, arg3: &0x2::clock::Clock, arg4: &0x2::random::Random, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        assert!(0x2::table::contains<address, u64>(&arg1.allocations, v0), 20);
        assert!(!arg1.is_closed, 6);
        assert!(!0x2::table::contains<address, bool>(&arg1.claimed, v0), 3);
        if (arg1.claim_restriction == 1) {
            assert!(0x1::option::is_some<0x1::string::String>(&arg2), 18);
            assert!(!0x2::table::contains<0x1::string::String, bool>(0x1::option::borrow<0x2::table::Table<0x1::string::String, bool>>(&arg1.device_claims), *0x1::option::borrow<0x1::string::String>(&arg2)), 4);
        };
        assert!(arg1.num_claimed < arg1.receiver_limit, 7);
        assert!(v1 < arg1.expiry_time, 5);
        let v2 = 0x2::coin::value<T0>(&arg1.coin);
        assert!(v2 > 0, 8);
        let v3 = arg1.receiver_limit - arg1.num_claimed;
        let v4 = if (arg1.distribution_type == 2) {
            *0x2::table::borrow<address, u64>(&arg1.allocations, v0)
        } else if (arg1.distribution_type == 1) {
            assert!(v2 >= v3, 8);
            let v5 = 0x2::random::new_generator(arg4, arg5);
            0xac59346502aecd407c27cf5a865d89a2788f083c899a4e48cd7156f851c328e5::types::draw_random_share(v2, v3, &mut v5)
        } else {
            0xac59346502aecd407c27cf5a865d89a2788f083c899a4e48cd7156f851c328e5::types::calculate_claim_amount(v2, v3)
        };
        assert!(v4 > 0, 8);
        let v6 = if (v4 > v2) {
            v2
        } else {
            v4
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg1.coin, v6, arg5), v0);
        0x2::table::add<address, bool>(&mut arg1.claimed, v0, true);
        if (arg1.claim_restriction == 1) {
            0x2::table::add<0x1::string::String, bool>(0x1::option::borrow_mut<0x2::table::Table<0x1::string::String, bool>>(&mut arg1.device_claims), *0x1::option::borrow<0x1::string::String>(&arg2), true);
        };
        0x1::vector::push_back<address>(&mut arg1.claimers_list, v0);
        arg1.num_claimed = arg1.num_claimed + 1;
        arg1.claimed_amount = arg1.claimed_amount + v6;
        0xac59346502aecd407c27cf5a865d89a2788f083c899a4e48cd7156f851c328e5::types::update_user_history(arg0, v0, arg1.droplet_id, false);
        let v7 = DropletClaimed{
            droplet_id         : arg1.droplet_id,
            claimer            : v0,
            token_type         : 0xac59346502aecd407c27cf5a865d89a2788f083c899a4e48cd7156f851c328e5::types::coin_type_name<T0>(),
            claim_amount       : v6,
            message            : arg1.message,
            claimed_at         : v1,
            device_fingerprint : arg2,
        };
        0x2::event::emit<DropletClaimed>(v7);
        if (arg1.num_claimed >= arg1.receiver_limit || 0x2::coin::value<T0>(&arg1.coin) == 0) {
            close_and_refund<T0>(arg1, 0x1::string::utf8(b"completed"), arg5);
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
        close_and_refund<T0>(arg0, 0x1::string::utf8(b"expired"), arg2);
    }

    fun close_and_refund<T0>(arg0: &mut Droplet<T0>, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.is_closed, 6);
        let v0 = 0x2::coin::value<T0>(&arg0.coin);
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg0.coin, v0, arg2), arg0.sender);
        };
        arg0.is_closed = true;
        let v1 = DropletClosed{
            droplet_id    : arg0.droplet_id,
            sender        : arg0.sender,
            refund_amount : v0,
            reason        : arg1,
        };
        0x2::event::emit<DropletClosed>(v1);
    }

    entry fun create_private_airdrop<T0>(arg0: &mut 0xac59346502aecd407c27cf5a865d89a2788f083c899a4e48cd7156f851c328e5::types::DropletRegistry, arg1: u64, arg2: 0x1::option::Option<u64>, arg3: 0x1::string::String, arg4: u8, arg5: u8, arg6: vector<address>, arg7: 0x1::option::Option<vector<u64>>, arg8: 0x2::coin::Coin<T0>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 > 0, 2);
        assert!(arg4 <= 2, 14);
        assert!(arg5 <= 1, 17);
        assert!(0x1::vector::length<address>(&arg6) > 0, 21);
        let v0 = 0x1::vector::length<address>(&arg6);
        assert!(v0 <= 0xac59346502aecd407c27cf5a865d89a2788f083c899a4e48cd7156f851c328e5::types::max_receiver_limit(), 1);
        assert!(arg1 >= v0, 27);
        let v1 = 0x2::tx_context::sender(arg10);
        let v2 = 0x2::clock::timestamp_ms(arg9);
        let v3 = if (0x1::option::is_some<u64>(&arg2)) {
            0x1::option::destroy_some<u64>(arg2)
        } else {
            0x1::option::destroy_none<u64>(arg2);
            0xac59346502aecd407c27cf5a865d89a2788f083c899a4e48cd7156f851c328e5::types::default_expiry_hours()
        };
        let v4 = v2 + v3 * 0xac59346502aecd407c27cf5a865d89a2788f083c899a4e48cd7156f851c328e5::types::ms_per_hour();
        let v5 = 0xac59346502aecd407c27cf5a865d89a2788f083c899a4e48cd7156f851c328e5::types::fee_on_top(arg1, 0xac59346502aecd407c27cf5a865d89a2788f083c899a4e48cd7156f851c328e5::types::fee_percentage(arg0));
        let v6 = arg1 + v5;
        assert!(0x2::coin::value<T0>(&arg8) >= v6, 2);
        let v7 = 0xac59346502aecd407c27cf5a865d89a2788f083c899a4e48cd7156f851c328e5::types::fee_recipient(arg0);
        if (v5 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg8, v5, arg10), v7);
        };
        let v8 = 0x2::coin::value<T0>(&arg8);
        if (v8 > arg1) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg8, v8 - arg1, arg10), v1);
        };
        let v9 = 0x2::coin::value<T0>(&arg8);
        assert!(v9 == arg1, 2);
        let v10 = 0xac59346502aecd407c27cf5a865d89a2788f083c899a4e48cd7156f851c328e5::admin::generate_droplet_id(v1, v2, arg10);
        let v11 = 0xac59346502aecd407c27cf5a865d89a2788f083c899a4e48cd7156f851c328e5::types::coin_type_name<T0>();
        0xac59346502aecd407c27cf5a865d89a2788f083c899a4e48cd7156f851c328e5::types::accumulate_fee(arg0, v11, v5);
        let v12 = arg4 == 2;
        if (v12) {
            assert!(0x1::option::is_some<vector<u64>>(&arg7), 22);
            assert!(0x1::vector::length<u64>(0x1::option::borrow<vector<u64>>(&arg7)) == v0, 22);
        };
        let v13 = 0x2::table::new<address, u64>(arg10);
        let v14 = 0;
        let v15 = 0;
        while (v15 < v0) {
            let v16 = *0x1::vector::borrow<address>(&arg6, v15);
            assert!(!0x2::table::contains<address, u64>(&v13, v16), 24);
            let v17 = if (v12) {
                let v18 = *0x1::vector::borrow<u64>(0x1::option::borrow<vector<u64>>(&arg7), v15);
                assert!(v18 > 0, 29);
                v14 = v14 + v18;
                v18
            } else {
                0
            };
            0x2::table::add<address, u64>(&mut v13, v16, v17);
            v15 = v15 + 1;
        };
        if (v12) {
            assert!(v14 == v9, 23);
        };
        let v19 = if (arg5 == 1) {
            0x1::option::some<0x2::table::Table<0x1::string::String, bool>>(0x2::table::new<0x1::string::String, bool>(arg10))
        } else {
            0x1::option::none<0x2::table::Table<0x1::string::String, bool>>()
        };
        let v20 = Droplet<T0>{
            id                : 0x2::object::new(arg10),
            droplet_id        : v10,
            sender            : v1,
            total_amount      : v9,
            claimed_amount    : 0,
            receiver_limit    : v0,
            num_claimed       : 0,
            created_at        : v2,
            expiry_time       : v4,
            claimed           : 0x2::table::new<address, bool>(arg10),
            device_claims     : v19,
            claimers_list     : vector[],
            coin              : arg8,
            is_closed         : false,
            message           : arg3,
            distribution_type : arg4,
            claim_restriction : arg5,
            allocations       : v13,
        };
        let v21 = 0x2::object::id_address<Droplet<T0>>(&v20);
        0xac59346502aecd407c27cf5a865d89a2788f083c899a4e48cd7156f851c328e5::types::register_droplet(arg0, v10, v21);
        0xac59346502aecd407c27cf5a865d89a2788f083c899a4e48cd7156f851c328e5::types::update_user_history(arg0, v1, v10, true);
        let v22 = FeeCollected{
            droplet_id : v10,
            token_type : v11,
            fee_amount : v5,
            recipient  : v7,
            timestamp  : v2,
        };
        0x2::event::emit<FeeCollected>(v22);
        let v23 = AllowlistRecorded{
            droplet_id : v10,
            addresses  : arg6,
        };
        0x2::event::emit<AllowlistRecorded>(v23);
        let v24 = if (arg4 == 0) {
            0xac59346502aecd407c27cf5a865d89a2788f083c899a4e48cd7156f851c328e5::types::calculate_claim_amount(v9, v0)
        } else {
            0
        };
        let v25 = DropletCreated{
            droplet_id          : v10,
            droplet_object_id   : v21,
            sender              : v1,
            total_amount        : v6,
            fee_amount          : v5,
            net_amount          : v9,
            token_type          : v11,
            receiver_limit      : v0,
            expiry_hours        : v3,
            message             : arg3,
            amount_per_receiver : v24,
            created_at          : v2,
            expiry_time         : v4,
            distribution_type   : arg4,
            claim_restriction   : arg5,
            authorized_count    : v0,
        };
        0x2::event::emit<DropletCreated>(v25);
        0x2::transfer::share_object<Droplet<T0>>(v20);
    }

    public fun custom_allocation<T0>(arg0: &Droplet<T0>, arg1: address) : 0x1::option::Option<u64> {
        if (arg0.distribution_type == 2 && 0x2::table::contains<address, u64>(&arg0.allocations, arg1)) {
            0x1::option::some<u64>(*0x2::table::borrow<address, u64>(&arg0.allocations, arg1))
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

    entry fun destroy_droplet<T0>(arg0: Droplet<T0>, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.sender, 15);
        assert!(arg0.is_closed, 32);
        let Droplet {
            id                : v0,
            droplet_id        : v1,
            sender            : v2,
            total_amount      : _,
            claimed_amount    : _,
            receiver_limit    : _,
            num_claimed       : _,
            created_at        : _,
            expiry_time       : _,
            claimed           : v9,
            device_claims     : v10,
            claimers_list     : _,
            coin              : v12,
            is_closed         : _,
            message           : _,
            distribution_type : _,
            claim_restriction : _,
            allocations       : v17,
        } = arg0;
        let v18 = v17;
        let v19 = v12;
        let v20 = v10;
        let v21 = v9;
        assert!(0x2::table::is_empty<address, bool>(&v21) && 0x2::table::is_empty<address, u64>(&v18), 33);
        assert!(0x2::coin::value<T0>(&v19) == 0, 8);
        0x2::table::destroy_empty<address, bool>(v21);
        0x2::table::destroy_empty<address, u64>(v18);
        if (0x1::option::is_some<0x2::table::Table<0x1::string::String, bool>>(&v20)) {
            let v22 = 0x1::option::destroy_some<0x2::table::Table<0x1::string::String, bool>>(v20);
            assert!(0x2::table::is_empty<0x1::string::String, bool>(&v22), 33);
            0x2::table::destroy_empty<0x1::string::String, bool>(v22);
        } else {
            0x1::option::destroy_none<0x2::table::Table<0x1::string::String, bool>>(v20);
        };
        0x2::coin::destroy_zero<T0>(v19);
        0x2::object::delete(v0);
        let v23 = DropletDestroyed{
            droplet_id : v1,
            sender     : v2,
        };
        0x2::event::emit<DropletDestroyed>(v23);
    }

    public fun distribution_details<T0>(arg0: &Droplet<T0>) : (u8, u8, u64) {
        (arg0.distribution_type, arg0.claim_restriction, arg0.receiver_limit)
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
            authorized_count  : arg0.receiver_limit,
            token_type        : 0xac59346502aecd407c27cf5a865d89a2788f083c899a4e48cd7156f851c328e5::types::coin_type_name<T0>(),
        }
    }

    public fun has_claimed<T0>(arg0: &Droplet<T0>, arg1: address) : bool {
        0x2::table::contains<address, bool>(&arg0.claimed, arg1)
    }

    public fun has_device_claimed<T0>(arg0: &Droplet<T0>, arg1: 0x1::string::String) : bool {
        0x1::option::is_some<0x2::table::Table<0x1::string::String, bool>>(&arg0.device_claims) && 0x2::table::contains<0x1::string::String, bool>(0x1::option::borrow<0x2::table::Table<0x1::string::String, bool>>(&arg0.device_claims), arg1)
    }

    public fun is_authorized<T0>(arg0: &Droplet<T0>, arg1: address) : bool {
        0x2::table::contains<address, u64>(&arg0.allocations, arg1)
    }

    public fun is_expired<T0>(arg0: &Droplet<T0>, arg1: &0x2::clock::Clock) : bool {
        0x2::clock::timestamp_ms(arg1) >= arg0.expiry_time
    }

    entry fun prune_droplet<T0>(arg0: &mut Droplet<T0>, arg1: vector<0x1::string::String>, arg2: vector<address>, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg0.sender, 15);
        assert!(arg0.is_closed, 32);
        assert!(0x1::vector::length<0x1::string::String>(&arg1) + 0x1::vector::length<address>(&arg2) + arg3 <= 1000, 34);
        if (0x1::option::is_some<0x2::table::Table<0x1::string::String, bool>>(&arg0.device_claims)) {
            let v0 = 0x1::option::borrow_mut<0x2::table::Table<0x1::string::String, bool>>(&mut arg0.device_claims);
            let v1 = &arg1;
            let v2 = 0;
            while (v2 < 0x1::vector::length<0x1::string::String>(v1)) {
                let v3 = 0x1::vector::borrow<0x1::string::String>(v1, v2);
                if (0x2::table::contains<0x1::string::String, bool>(v0, *v3)) {
                    0x2::table::remove<0x1::string::String, bool>(v0, *v3);
                };
                v2 = v2 + 1;
            };
        };
        let v4 = &arg2;
        let v5 = 0;
        while (v5 < 0x1::vector::length<address>(v4)) {
            let v6 = 0x1::vector::borrow<address>(v4, v5);
            if (0x2::table::contains<address, u64>(&arg0.allocations, *v6)) {
                0x2::table::remove<address, u64>(&mut arg0.allocations, *v6);
            };
            v5 = v5 + 1;
        };
        let v7 = 0;
        while (v7 < arg3 && !0x1::vector::is_empty<address>(&arg0.claimers_list)) {
            let v8 = 0x1::vector::pop_back<address>(&mut arg0.claimers_list);
            if (0x2::table::contains<address, bool>(&arg0.claimed, v8)) {
                0x2::table::remove<address, bool>(&mut arg0.claimed, v8);
            };
            v7 = v7 + 1;
        };
    }

    public fun remaining_balance<T0>(arg0: &Droplet<T0>) : u64 {
        0x2::coin::value<T0>(&arg0.coin)
    }

    // decompiled from Move bytecode v7
}

