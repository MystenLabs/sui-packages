module 0xac59346502aecd407c27cf5a865d89a2788f083c899a4e48cd7156f851c328e5::types {
    struct DropletRegistry has key {
        id: 0x2::object::UID,
        droplets: 0x2::table::Table<0x1::string::String, address>,
        fee_percentage: u64,
        fee_recipient: address,
        total_droplets_created: u64,
        total_fees_collected: 0x2::table::Table<0x1::string::String, u64>,
        user_created_droplets: 0x2::table::Table<address, vector<0x1::string::String>>,
        user_claimed_droplets: 0x2::table::Table<address, vector<0x1::string::String>>,
    }

    public(friend) fun accumulate_fee(arg0: &mut DropletRegistry, arg1: 0x1::string::String, arg2: u64) {
        if (!0x2::table::contains<0x1::string::String, u64>(&arg0.total_fees_collected, arg1)) {
            0x2::table::add<0x1::string::String, u64>(&mut arg0.total_fees_collected, arg1, 0);
        };
        let v0 = 0x2::table::borrow_mut<0x1::string::String, u64>(&mut arg0.total_fees_collected, arg1);
        *v0 = *v0 + arg2;
    }

    public(friend) fun calculate_claim_amount(arg0: u64, arg1: u64) : u64 {
        if (arg1 == 0) {
            0
        } else {
            arg0 / arg1
        }
    }

    public(friend) fun coin_type_name<T0>() : 0x1::string::String {
        0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()))
    }

    public(friend) fun default_expiry_hours() : u64 {
        48
    }

    public(friend) fun draw_random_share(arg0: u64, arg1: u64, arg2: &mut 0x2::random::RandomGenerator) : u64 {
        if (arg1 <= 1) {
            return arg0
        };
        let v0 = arg0 - arg1 - 1;
        let v1 = (((arg0 as u128) * 2 / (arg1 as u128)) as u64);
        let v2 = if (v1 < v0) {
            v1
        } else {
            v0
        };
        0x2::random::generate_u64_in_range(arg2, 1, v2)
    }

    public fun droplet_address(arg0: &DropletRegistry, arg1: 0x1::string::String) : 0x1::option::Option<address> {
        if (0x2::table::contains<0x1::string::String, address>(&arg0.droplets, arg1)) {
            0x1::option::some<address>(*0x2::table::borrow<0x1::string::String, address>(&arg0.droplets, arg1))
        } else {
            0x1::option::none<address>()
        }
    }

    public(friend) fun fee_inside_total(arg0: u64, arg1: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (10000 + (arg1 as u128))) as u64)
    }

    public(friend) fun fee_on_top(arg0: u64, arg1: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / 10000) as u64)
    }

    public fun fee_percentage(arg0: &DropletRegistry) : u64 {
        arg0.fee_percentage
    }

    public fun fee_recipient(arg0: &DropletRegistry) : address {
        arg0.fee_recipient
    }

    public fun find_droplet(arg0: &DropletRegistry, arg1: 0x1::string::String) : address {
        assert!(0x1::string::length(&arg1) == 6, 11);
        assert!(0x2::table::contains<0x1::string::String, address>(&arg0.droplets, arg1), 9);
        *0x2::table::borrow<0x1::string::String, address>(&arg0.droplets, arg1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = DropletRegistry{
            id                     : 0x2::object::new(arg0),
            droplets               : 0x2::table::new<0x1::string::String, address>(arg0),
            fee_percentage         : 130,
            fee_recipient          : 0x2::tx_context::sender(arg0),
            total_droplets_created : 0,
            total_fees_collected   : 0x2::table::new<0x1::string::String, u64>(arg0),
            user_created_droplets  : 0x2::table::new<address, vector<0x1::string::String>>(arg0),
            user_claimed_droplets  : 0x2::table::new<address, vector<0x1::string::String>>(arg0),
        };
        0x2::transfer::share_object<DropletRegistry>(v0);
    }

    public(friend) fun max_batch_receivers() : u64 {
        500
    }

    public(friend) fun max_receiver_limit() : u64 {
        5000
    }

    public(friend) fun ms_per_hour() : u64 {
        3600000
    }

    fun paginate(arg0: vector<0x1::string::String>, arg1: u64, arg2: u64) : vector<0x1::string::String> {
        let v0 = 0x1::vector::length<0x1::string::String>(&arg0);
        if (arg1 >= v0) {
            return 0x1::vector::empty<0x1::string::String>()
        };
        let v1 = if (arg1 + arg2 > v0) {
            v0
        } else {
            arg1 + arg2
        };
        let v2 = 0x1::vector::empty<0x1::string::String>();
        while (arg1 < v1) {
            0x1::vector::push_back<0x1::string::String>(&mut v2, *0x1::vector::borrow<0x1::string::String>(&arg0, arg1));
            arg1 = arg1 + 1;
        };
        v2
    }

    public fun platform_stats(arg0: &DropletRegistry) : (u64, u64) {
        (arg0.total_droplets_created, arg0.fee_percentage)
    }

    public(friend) fun register_droplet(arg0: &mut DropletRegistry, arg1: 0x1::string::String, arg2: address) {
        0x2::table::add<0x1::string::String, address>(&mut arg0.droplets, arg1, arg2);
        arg0.total_droplets_created = arg0.total_droplets_created + 1;
    }

    public(friend) fun set_fee_percentage_internal(arg0: &mut DropletRegistry, arg1: u64) {
        arg0.fee_percentage = arg1;
    }

    public(friend) fun set_fee_recipient_internal(arg0: &mut DropletRegistry, arg1: address) {
        assert!(arg1 != @0x0, 30);
        arg0.fee_recipient = arg1;
    }

    public(friend) fun update_user_history(arg0: &mut DropletRegistry, arg1: address, arg2: 0x1::string::String, arg3: bool) {
        if (arg3) {
            if (!0x2::table::contains<address, vector<0x1::string::String>>(&arg0.user_created_droplets, arg1)) {
                0x2::table::add<address, vector<0x1::string::String>>(&mut arg0.user_created_droplets, arg1, 0x1::vector::empty<0x1::string::String>());
            };
            0x1::vector::push_back<0x1::string::String>(0x2::table::borrow_mut<address, vector<0x1::string::String>>(&mut arg0.user_created_droplets, arg1), arg2);
        } else {
            if (!0x2::table::contains<address, vector<0x1::string::String>>(&arg0.user_claimed_droplets, arg1)) {
                0x2::table::add<address, vector<0x1::string::String>>(&mut arg0.user_claimed_droplets, arg1, 0x1::vector::empty<0x1::string::String>());
            };
            0x1::vector::push_back<0x1::string::String>(0x2::table::borrow_mut<address, vector<0x1::string::String>>(&mut arg0.user_claimed_droplets, arg1), arg2);
        };
    }

    public fun user_activity_summary(arg0: &DropletRegistry, arg1: address) : (vector<0x1::string::String>, vector<0x1::string::String>, u64, u64) {
        let v0 = user_created_droplets(arg0, arg1);
        let v1 = user_claimed_droplets(arg0, arg1);
        (v0, v1, 0x1::vector::length<0x1::string::String>(&v0), 0x1::vector::length<0x1::string::String>(&v1))
    }

    public fun user_claimed_count(arg0: &DropletRegistry, arg1: address) : u64 {
        let v0 = user_claimed_droplets(arg0, arg1);
        0x1::vector::length<0x1::string::String>(&v0)
    }

    public fun user_claimed_droplets(arg0: &DropletRegistry, arg1: address) : vector<0x1::string::String> {
        if (0x2::table::contains<address, vector<0x1::string::String>>(&arg0.user_claimed_droplets, arg1)) {
            *0x2::table::borrow<address, vector<0x1::string::String>>(&arg0.user_claimed_droplets, arg1)
        } else {
            0x1::vector::empty<0x1::string::String>()
        }
    }

    public fun user_claimed_droplets_paginated(arg0: &DropletRegistry, arg1: address, arg2: u64, arg3: u64) : vector<0x1::string::String> {
        paginate(user_claimed_droplets(arg0, arg1), arg2, arg3)
    }

    public fun user_created_count(arg0: &DropletRegistry, arg1: address) : u64 {
        let v0 = user_created_droplets(arg0, arg1);
        0x1::vector::length<0x1::string::String>(&v0)
    }

    public fun user_created_droplets(arg0: &DropletRegistry, arg1: address) : vector<0x1::string::String> {
        if (0x2::table::contains<address, vector<0x1::string::String>>(&arg0.user_created_droplets, arg1)) {
            *0x2::table::borrow<address, vector<0x1::string::String>>(&arg0.user_created_droplets, arg1)
        } else {
            0x1::vector::empty<0x1::string::String>()
        }
    }

    public fun user_created_droplets_paginated(arg0: &DropletRegistry, arg1: address, arg2: u64, arg3: u64) : vector<0x1::string::String> {
        paginate(user_created_droplets(arg0, arg1), arg2, arg3)
    }

    public fun user_has_activity(arg0: &DropletRegistry, arg1: address) : bool {
        0x2::table::contains<address, vector<0x1::string::String>>(&arg0.user_created_droplets, arg1) || 0x2::table::contains<address, vector<0x1::string::String>>(&arg0.user_claimed_droplets, arg1)
    }

    // decompiled from Move bytecode v7
}

