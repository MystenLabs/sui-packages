module 0xa7aeb8099c46d82355d5a90b4282d376fa83ac76cf62d19c64b55944f215164e::types {
    struct DropletRegistry has key {
        id: 0x2::object::UID,
        droplets: 0x2::table::Table<0x1::string::String, address>,
        fee_percentage: u64,
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

    public(friend) fun contract_owner() : address {
        @0xe2bf986ccb385f8e5d9500ce8332b69a5cee19579152c240c09213e80e9355b8
    }

    public(friend) fun default_expiry_hours() : u64 {
        48
    }

    public fun droplet_address(arg0: &DropletRegistry, arg1: 0x1::string::String) : 0x1::option::Option<address> {
        if (0x2::table::contains<0x1::string::String, address>(&arg0.droplets, arg1)) {
            0x1::option::some<address>(*0x2::table::borrow<0x1::string::String, address>(&arg0.droplets, arg1))
        } else {
            0x1::option::none<address>()
        }
    }

    public fun fee_percentage(arg0: &DropletRegistry) : u64 {
        arg0.fee_percentage
    }

    public fun find_droplet(arg0: &DropletRegistry, arg1: 0x1::string::String) : address {
        assert!(0x1::string::length(&arg1) == 6, 11);
        assert!(0x2::table::contains<0x1::string::String, address>(&arg0.droplets, arg1), 9);
        *0x2::table::borrow<0x1::string::String, address>(&arg0.droplets, arg1)
    }

    public(friend) fun generate_random_weight(arg0: address, arg1: u64, arg2: u64, arg3: 0x1::string::String) : u64 {
        let v0 = b"";
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(arg0));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg1));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg2));
        0x1::vector::append<u8>(&mut v0, *0x1::string::as_bytes(&arg3));
        let v1 = 0x2::hash::keccak256(&v0);
        if (0x1::vector::length<u8>(&v1) >= 8) {
            let v3 = 0;
            let v4 = 0;
            while (v4 < 8) {
                let v5 = v3 * 256;
                v3 = v5 + (*0x1::vector::borrow<u8>(&v1, v4) as u64);
                v4 = v4 + 1;
            };
            v3 % 10000 + 1
        } else {
            5000
        }
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = DropletRegistry{
            id                     : 0x2::object::new(arg0),
            droplets               : 0x2::table::new<0x1::string::String, address>(arg0),
            fee_percentage         : 130,
            total_droplets_created : 0,
            total_fees_collected   : 0x2::table::new<0x1::string::String, u64>(arg0),
            user_created_droplets  : 0x2::table::new<address, vector<0x1::string::String>>(arg0),
            user_claimed_droplets  : 0x2::table::new<address, vector<0x1::string::String>>(arg0),
        };
        0x2::transfer::share_object<DropletRegistry>(v0);
    }

    public(friend) fun max_receiver_limit() : u64 {
        100000
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

    // decompiled from Move bytecode v6
}

