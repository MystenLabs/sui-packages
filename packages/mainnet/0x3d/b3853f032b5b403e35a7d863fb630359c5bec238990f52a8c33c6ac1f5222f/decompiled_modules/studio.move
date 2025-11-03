module 0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::studio {
    struct NewStudioEvent has copy, drop {
        owner: address,
        studio_id: 0x2::object::ID,
    }

    struct MembershipSubscribeEvent has copy, drop {
        owner: address,
        member: address,
        extended_time_ms: u64,
        expired_at: u64,
    }

    struct STUDIO has drop {
        dummy_field: bool,
    }

    struct Studio has key {
        id: 0x2::object::UID,
        owner: address,
        period: Period,
        monthly_subscription_fee: 0x1::option::Option<u64>,
        membership: 0x58c2589e21157bac347513cb4c392ffa34af0e1a630f5a77c0ee92f141057d01::derived_table::DerivedTable<address, u64>,
        works: 0x58c2589e21157bac347513cb4c392ffa34af0e1a630f5a77c0ee92f141057d01::derived_object_bag::DerivedObjectBag,
    }

    struct Period has copy, drop, store {
        pos0: u64,
        pos1: u64,
    }

    public fun new(arg0: &mut 0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::config::Config, arg1: &mut 0x2::tx_context::TxContext) : (Studio, 0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::storage::StorageSpace) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(!studio_exists(arg0, v0), 102);
        0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::config::assert_version(arg0);
        let v1 = 0x2::derived_object::claim<address>(0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::config::uid_mut(arg0), v0);
        let v2 = Period{
            pos0 : 0,
            pos1 : 0,
        };
        let v3 = Studio{
            id                       : v1,
            owner                    : v0,
            period                   : v2,
            monthly_subscription_fee : 0x1::option::none<u64>(),
            membership               : 0x58c2589e21157bac347513cb4c392ffa34af0e1a630f5a77c0ee92f141057d01::derived_table::new<vector<u8>, address, u64>(&mut v1, b"membership"),
            works                    : 0x58c2589e21157bac347513cb4c392ffa34af0e1a630f5a77c0ee92f141057d01::derived_object_bag::new<vector<u8>>(&mut v1, b"works"),
        };
        let v4 = NewStudioEvent{
            owner     : v0,
            studio_id : 0x2::object::id<Studio>(&v3),
        };
        0x2::event::emit<NewStudioEvent>(v4);
        (v3, 0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::storage::new(&mut v1, v0))
    }

    public(friend) fun add_asset<T0: store + key>(arg0: &mut Studio, arg1: &0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::config::Config, arg2: T0, arg3: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg3), 101);
        0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::config::assert_allowed_works<T0>(arg1);
        0x58c2589e21157bac347513cb4c392ffa34af0e1a630f5a77c0ee92f141057d01::derived_object_bag::add<0x2::object::ID, T0>(&mut arg0.works, 0x2::object::id<T0>(&arg2), arg2);
    }

    public(friend) fun add_membership(arg0: &mut Studio, arg1: address, arg2: u64, arg3: &0x2::clock::Clock) {
        if (!0x58c2589e21157bac347513cb4c392ffa34af0e1a630f5a77c0ee92f141057d01::derived_table::contains<address, u64>(&arg0.membership, arg1)) {
            0x58c2589e21157bac347513cb4c392ffa34af0e1a630f5a77c0ee92f141057d01::derived_table::add<address, u64>(&mut arg0.membership, arg1, 0x2::clock::timestamp_ms(arg3) + arg2);
        } else {
            *0x58c2589e21157bac347513cb4c392ffa34af0e1a630f5a77c0ee92f141057d01::derived_table::borrow_mut<address, u64>(&mut arg0.membership, arg1) = 0x1::u64::max(0x2::clock::timestamp_ms(arg3), *0x58c2589e21157bac347513cb4c392ffa34af0e1a630f5a77c0ee92f141057d01::derived_table::borrow<address, u64>(&arg0.membership, arg1)) + arg2;
        };
        let v0 = MembershipSubscribeEvent{
            owner            : arg0.owner,
            member           : arg1,
            extended_time_ms : arg2,
            expired_at       : *0x58c2589e21157bac347513cb4c392ffa34af0e1a630f5a77c0ee92f141057d01::derived_table::borrow<address, u64>(&arg0.membership, arg1),
        };
        0x2::event::emit<MembershipSubscribeEvent>(v0);
    }

    public(friend) fun assert_content_is_accessible(arg0: &Studio) {
        assert!(is_content_accessible(arg0), 106);
    }

    public(friend) fun assert_owner(arg0: &Studio, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg1), 101);
    }

    public(friend) fun assert_studio_time_validity(arg0: &Studio, arg1: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        assert!(v0 >= arg0.period.pos0 && v0 < arg0.period.pos1, 105);
    }

    public fun asset_of<T0: store + key>(arg0: &Studio, arg1: 0x2::object::ID) : &T0 {
        0x58c2589e21157bac347513cb4c392ffa34af0e1a630f5a77c0ee92f141057d01::derived_object_bag::borrow<0x2::object::ID, T0>(&arg0.works, arg1)
    }

    public(friend) fun asset_of_mut<T0: store + key>(arg0: &mut Studio, arg1: 0x2::object::ID) : &mut T0 {
        0x58c2589e21157bac347513cb4c392ffa34af0e1a630f5a77c0ee92f141057d01::derived_object_bag::borrow_mut<0x2::object::ID, T0>(&mut arg0.works, arg1)
    }

    public(friend) fun check_policy(arg0: vector<u8>, arg1: &Studio, arg2: &0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::config::Config, arg3: address, arg4: &0x2::clock::Clock) : bool {
        0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::config::assert_version(arg2);
        let v0 = 0x2::object::uid_to_bytes(&arg1.id);
        let v1 = 0;
        if (0x1::vector::length<u8>(&v0) > 0x1::vector::length<u8>(&arg0)) {
            return false
        };
        while (v1 < 0x1::vector::length<u8>(&v0)) {
            if (*0x1::vector::borrow<u8>(&v0, v1) != *0x1::vector::borrow<u8>(&arg0, v1)) {
                return false
            };
            v1 = v1 + 1;
        };
        is_membership(arg1, arg3, arg4) && is_content_accessible(arg1)
    }

    public fun end_at(arg0: &Studio) : u64 {
        arg0.period.pos1
    }

    fun init(arg0: STUDIO, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<STUDIO>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    public fun is_content_accessible(arg0: &Studio) : bool {
        0x1::option::is_some<u64>(&arg0.monthly_subscription_fee)
    }

    public fun is_in_valid_period(arg0: &Studio, arg1: &0x2::clock::Clock) : bool {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        v0 >= arg0.period.pos0 && v0 < arg0.period.pos1
    }

    public fun is_membership(arg0: &Studio, arg1: address, arg2: &0x2::clock::Clock) : bool {
        arg0.owner == arg1 || 0x58c2589e21157bac347513cb4c392ffa34af0e1a630f5a77c0ee92f141057d01::derived_table::contains<address, u64>(&arg0.membership, arg1) && *0x58c2589e21157bac347513cb4c392ffa34af0e1a630f5a77c0ee92f141057d01::derived_table::borrow<address, u64>(&arg0.membership, arg1) > 0x2::clock::timestamp_ms(arg2)
    }

    public fun membership(arg0: &Studio) : &0x58c2589e21157bac347513cb4c392ffa34af0e1a630f5a77c0ee92f141057d01::derived_table::DerivedTable<address, u64> {
        &arg0.membership
    }

    public(friend) fun membership_mut(arg0: &mut Studio) : &mut 0x58c2589e21157bac347513cb4c392ffa34af0e1a630f5a77c0ee92f141057d01::derived_table::DerivedTable<address, u64> {
        &mut arg0.membership
    }

    public fun monthly_subscription_fee(arg0: &Studio) : 0x1::option::Option<u64> {
        arg0.monthly_subscription_fee
    }

    public fun owner(arg0: &Studio) : address {
        arg0.owner
    }

    public fun period(arg0: &Studio) : Period {
        arg0.period
    }

    public(friend) fun remove_asset<T0: store + key>(arg0: &mut Studio, arg1: 0x2::object::ID) : T0 {
        0x58c2589e21157bac347513cb4c392ffa34af0e1a630f5a77c0ee92f141057d01::derived_object_bag::remove<0x2::object::ID, T0>(&mut arg0.works, arg1)
    }

    entry fun seal_approve(arg0: &0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::config::Config, arg1: vector<u8>, arg2: &Studio, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert!(check_policy(arg1, arg2, arg0, 0x2::tx_context::sender(arg4), arg3), 2);
    }

    public fun share_studio(arg0: Studio) {
        0x2::transfer::share_object<Studio>(arg0);
    }

    public fun start_at(arg0: &Studio) : u64 {
        arg0.period.pos0
    }

    public fun studio_exists(arg0: &0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::config::Config, arg1: address) : bool {
        0x2::derived_object::exists<address>(0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::config::uid_borrow(arg0), arg1)
    }

    public fun studio_of(arg0: &0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::config::Config, arg1: address) : 0x2::object::ID {
        0x2::object::id_from_address(0x2::derived_object::derive_address<address>(0x2::object::id<0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::config::Config>(arg0), arg1))
    }

    public(friend) fun update_end_at(arg0: &mut Studio, arg1: u64) {
        arg0.period.pos1 = arg1;
    }

    public(friend) fun update_monthly_subscription_fee(arg0: &mut Studio, arg1: 0x1::option::Option<u64>) {
        arg0.monthly_subscription_fee = arg1;
    }

    public(friend) fun update_start_at(arg0: &mut Studio, arg1: u64) {
        arg0.period.pos0 = arg1;
    }

    public fun works(arg0: &Studio) : &0x58c2589e21157bac347513cb4c392ffa34af0e1a630f5a77c0ee92f141057d01::derived_object_bag::DerivedObjectBag {
        &arg0.works
    }

    // decompiled from Move bytecode v6
}

