module 0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::studio {
    struct NewStudioEvent has copy, drop {
        owner: address,
        studio_id: 0x2::object::ID,
    }

    struct STUDIO has drop {
        dummy_field: bool,
    }

    struct Studio has key {
        id: 0x2::object::UID,
        owner: address,
        period: Period,
        monthly_subscription_fee: 0x2::vec_map::VecMap<u8, u64>,
        membership: 0x176ca50788521662366802f5847edd1e41abb2532cc65d4d69b583a47f5444cd::derived_table::DerivedTable<address, Member>,
        works: 0x176ca50788521662366802f5847edd1e41abb2532cc65d4d69b583a47f5444cd::derived_object_bag::DerivedObjectBag,
        encrypted_file_key: 0x1::option::Option<vector<u8>>,
        earnings: 0x2::vec_map::VecMap<0x1::ascii::String, u64>,
    }

    struct Period has copy, drop, store {
        pos0: u64,
        pos1: u64,
    }

    struct Member has store {
        level: u8,
        expired_at: u64,
    }

    public fun new(arg0: &mut 0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::config::Config, arg1: &mut 0x2::tx_context::TxContext) : (Studio, 0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::storage::StorageSpace) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(!studio_exists(arg0, v0), 102);
        0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::config::assert_version(arg0);
        0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::config::assert_not_paused(arg0);
        let v1 = 0x2::derived_object::claim<address>(0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::config::uid_mut(arg0), v0);
        let v2 = Period{
            pos0 : 0,
            pos1 : 0,
        };
        let v3 = Studio{
            id                       : v1,
            owner                    : v0,
            period                   : v2,
            monthly_subscription_fee : 0x2::vec_map::empty<u8, u64>(),
            membership               : 0x176ca50788521662366802f5847edd1e41abb2532cc65d4d69b583a47f5444cd::derived_table::new<vector<u8>, address, Member>(&mut v1, b"membership"),
            works                    : 0x176ca50788521662366802f5847edd1e41abb2532cc65d4d69b583a47f5444cd::derived_object_bag::new<vector<u8>>(&mut v1, b"works"),
            encrypted_file_key       : 0x1::option::none<vector<u8>>(),
            earnings                 : 0x2::vec_map::empty<0x1::ascii::String, u64>(),
        };
        let v4 = NewStudioEvent{
            owner     : v0,
            studio_id : 0x2::object::id<Studio>(&v3),
        };
        0x2::event::emit<NewStudioEvent>(v4);
        (v3, 0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::storage::new(&mut v1, v0))
    }

    public(friend) fun uid_borrow(arg0: &Studio) : &0x2::object::UID {
        &arg0.id
    }

    public(friend) fun uid_mut(arg0: &mut Studio) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    public(friend) fun add_asset<T0: store + key>(arg0: &mut Studio, arg1: &0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::config::Config, arg2: T0, arg3: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg3), 101);
        0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::config::assert_allowed_works<T0>(arg1);
        0x176ca50788521662366802f5847edd1e41abb2532cc65d4d69b583a47f5444cd::derived_object_bag::add<0x2::object::ID, T0>(&mut arg0.works, 0x2::object::id<T0>(&arg2), arg2);
    }

    public(friend) fun add_earnings(arg0: &mut Studio, arg1: vector<u8>, arg2: u64) {
        let v0 = 0x1::ascii::string(arg1);
        if (0x2::vec_map::contains<0x1::ascii::String, u64>(&arg0.earnings, &v0)) {
            *0x2::vec_map::get_mut<0x1::ascii::String, u64>(&mut arg0.earnings, &v0) = *0x2::vec_map::get<0x1::ascii::String, u64>(&arg0.earnings, &v0) + arg2;
        } else {
            0x2::vec_map::insert<0x1::ascii::String, u64>(&mut arg0.earnings, v0, arg2);
        };
    }

    public(friend) fun add_membership(arg0: &mut Studio, arg1: address, arg2: u8, arg3: u64, arg4: &0x2::clock::Clock) : u64 {
        if (!0x176ca50788521662366802f5847edd1e41abb2532cc65d4d69b583a47f5444cd::derived_table::contains<address, Member>(&arg0.membership, arg1)) {
            let v0 = Member{
                level      : arg2,
                expired_at : 0x2::clock::timestamp_ms(arg4) + arg3,
            };
            0x176ca50788521662366802f5847edd1e41abb2532cc65d4d69b583a47f5444cd::derived_table::add<address, Member>(&mut arg0.membership, arg1, v0);
        } else {
            0x176ca50788521662366802f5847edd1e41abb2532cc65d4d69b583a47f5444cd::derived_table::borrow_mut<address, Member>(&mut arg0.membership, arg1).expired_at = 0x1::u64::max(0x2::clock::timestamp_ms(arg4), 0x176ca50788521662366802f5847edd1e41abb2532cc65d4d69b583a47f5444cd::derived_table::borrow<address, Member>(&arg0.membership, arg1).expired_at) + arg3;
            0x176ca50788521662366802f5847edd1e41abb2532cc65d4d69b583a47f5444cd::derived_table::borrow_mut<address, Member>(&mut arg0.membership, arg1).level = arg2;
        };
        0x176ca50788521662366802f5847edd1e41abb2532cc65d4d69b583a47f5444cd::derived_table::borrow<address, Member>(&arg0.membership, arg1).expired_at
    }

    public(friend) fun assert_owner(arg0: &Studio, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg1), 101);
    }

    public(friend) fun assert_studio_time_validity(arg0: &Studio, arg1: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        assert!(v0 >= arg0.period.pos0 && v0 < arg0.period.pos1, 104);
    }

    public(friend) fun assert_subscription_level_setup(arg0: &Studio, arg1: u8) {
        assert!(0x2::vec_map::contains<u8, u64>(&arg0.monthly_subscription_fee, &arg1), 103);
    }

    public fun asset_of<T0: store + key>(arg0: &Studio, arg1: 0x2::object::ID) : &T0 {
        0x176ca50788521662366802f5847edd1e41abb2532cc65d4d69b583a47f5444cd::derived_object_bag::borrow<0x2::object::ID, T0>(&arg0.works, arg1)
    }

    public(friend) fun asset_of_mut<T0: store + key>(arg0: &mut Studio, arg1: 0x2::object::ID) : &mut T0 {
        0x176ca50788521662366802f5847edd1e41abb2532cc65d4d69b583a47f5444cd::derived_object_bag::borrow_mut<0x2::object::ID, T0>(&mut arg0.works, arg1)
    }

    fun check_studio_owner_policy(arg0: vector<u8>, arg1: &Studio, arg2: &0x2::tx_context::TxContext) : bool {
        is_prefix(arg0, 0x2::object::uid_to_bytes(&arg1.id)) && 0x2::tx_context::sender(arg2) == arg1.owner
    }

    public fun donation_earning_key() : vector<u8> {
        b"donation"
    }

    public fun earnings(arg0: &Studio) : 0x2::vec_map::VecMap<0x1::ascii::String, u64> {
        arg0.earnings
    }

    public fun encrypted_file_key(arg0: &Studio) : &0x1::option::Option<vector<u8>> {
        &arg0.encrypted_file_key
    }

    public fun end_at(arg0: &Studio) : u64 {
        arg0.period.pos1
    }

    fun init(arg0: STUDIO, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<STUDIO>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    public fun is_in_valid_period(arg0: &Studio, arg1: &0x2::clock::Clock) : bool {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        v0 >= arg0.period.pos0 && v0 < arg0.period.pos1
    }

    public fun is_membership(arg0: &Studio, arg1: address, arg2: &0x2::clock::Clock) : bool {
        arg0.owner == arg1 || 0x176ca50788521662366802f5847edd1e41abb2532cc65d4d69b583a47f5444cd::derived_table::contains<address, Member>(&arg0.membership, arg1) && 0x176ca50788521662366802f5847edd1e41abb2532cc65d4d69b583a47f5444cd::derived_table::borrow<address, Member>(&arg0.membership, arg1).expired_at > 0x2::clock::timestamp_ms(arg2)
    }

    public(friend) fun is_prefix(arg0: vector<u8>, arg1: vector<u8>) : bool {
        if (0x1::vector::length<u8>(&arg1) > 0x1::vector::length<u8>(&arg0)) {
            return false
        };
        let v0 = 0;
        while (v0 < 0x1::vector::length<u8>(&arg1)) {
            if (*0x1::vector::borrow<u8>(&arg1, v0) != *0x1::vector::borrow<u8>(&arg0, v0)) {
                return false
            };
            v0 = v0 + 1;
        };
        true
    }

    public fun member_expired_at(arg0: &Member) : u64 {
        arg0.expired_at
    }

    public fun member_level(arg0: &Member) : u8 {
        arg0.level
    }

    public fun membership(arg0: &Studio) : &0x176ca50788521662366802f5847edd1e41abb2532cc65d4d69b583a47f5444cd::derived_table::DerivedTable<address, Member> {
        &arg0.membership
    }

    public fun membership_level(arg0: &Studio, arg1: address, arg2: &0x2::clock::Clock) : 0x1::option::Option<u8> {
        if (!is_membership(arg0, arg1, arg2)) {
            0x1::option::none<u8>()
        } else {
            0x1::option::some<u8>(0x176ca50788521662366802f5847edd1e41abb2532cc65d4d69b583a47f5444cd::derived_table::borrow<address, Member>(&arg0.membership, arg1).level)
        }
    }

    public(friend) fun membership_mut(arg0: &mut Studio) : &mut 0x176ca50788521662366802f5847edd1e41abb2532cc65d4d69b583a47f5444cd::derived_table::DerivedTable<address, Member> {
        &mut arg0.membership
    }

    public fun membership_subscription_earning_key() : vector<u8> {
        b"membership_subscription"
    }

    public fun monthly_subscription_fee(arg0: &Studio) : 0x2::vec_map::VecMap<u8, u64> {
        arg0.monthly_subscription_fee
    }

    public fun owner(arg0: &Studio) : address {
        arg0.owner
    }

    public fun period(arg0: &Studio) : Period {
        arg0.period
    }

    public(friend) fun remove_asset<T0: store + key>(arg0: &mut Studio, arg1: 0x2::object::ID) : T0 {
        0x176ca50788521662366802f5847edd1e41abb2532cc65d4d69b583a47f5444cd::derived_object_bag::remove<0x2::object::ID, T0>(&mut arg0.works, arg1)
    }

    entry fun seal_approve_manager(arg0: vector<u8>, arg1: &0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::config::Config, arg2: &Studio, arg3: &0x2::tx_context::TxContext) {
        0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::config::assert_version(arg1);
        0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::config::assert_not_paused(arg1);
        let v0 = 0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::config::managers(arg1);
        let v1 = 0x2::tx_context::sender(arg3);
        assert!(is_prefix(arg0, 0x2::object::uid_to_bytes(&arg2.id)) && 0x2::vec_set::contains<address>(&v0, &v1), 1);
    }

    entry fun seal_approve_studio_owner(arg0: vector<u8>, arg1: &0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::config::Config, arg2: &Studio, arg3: &0x2::tx_context::TxContext) {
        0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::config::assert_version(arg1);
        0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::config::assert_not_paused(arg1);
        assert!(check_studio_owner_policy(arg0, arg2, arg3), 1);
    }

    public fun share_studio(arg0: Studio) {
        0x2::transfer::share_object<Studio>(arg0);
    }

    public fun start_at(arg0: &Studio) : u64 {
        arg0.period.pos0
    }

    public fun studio_exists(arg0: &0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::config::Config, arg1: address) : bool {
        0x2::derived_object::exists<address>(0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::config::uid_borrow(arg0), arg1)
    }

    public fun studio_of(arg0: &0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::config::Config, arg1: address) : 0x2::object::ID {
        0x2::object::id_from_address(0x2::derived_object::derive_address<address>(0x2::object::id<0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::config::Config>(arg0), arg1))
    }

    public fun total_earning(arg0: &Studio) : u64 {
        let (_, v1) = 0x2::vec_map::into_keys_values<0x1::ascii::String, u64>(arg0.earnings);
        let v2 = 0;
        let v3 = v1;
        0x1::vector::reverse<u64>(&mut v3);
        let v4 = 0;
        while (v4 < 0x1::vector::length<u64>(&v3)) {
            v2 = v2 + 0x1::vector::pop_back<u64>(&mut v3);
            v4 = v4 + 1;
        };
        0x1::vector::destroy_empty<u64>(v3);
        v2
    }

    public(friend) fun update_encrypted_file_key(arg0: &mut Studio, arg1: vector<u8>) {
        assert!(0x1::vector::length<u8>(&arg1) == 380, 105);
        0x1::option::swap_or_fill<vector<u8>>(&mut arg0.encrypted_file_key, arg1);
    }

    public(friend) fun update_end_at(arg0: &mut Studio, arg1: u64) {
        arg0.period.pos1 = arg1;
    }

    public(friend) fun update_monthly_subscription_fee(arg0: &mut Studio, arg1: u8, arg2: u64) {
        if (0x2::vec_map::contains<u8, u64>(&arg0.monthly_subscription_fee, &arg1)) {
            *0x2::vec_map::get_mut<u8, u64>(&mut arg0.monthly_subscription_fee, &arg1) = arg2;
        } else {
            0x2::vec_map::insert<u8, u64>(&mut arg0.monthly_subscription_fee, arg1, arg2);
        };
    }

    public(friend) fun update_start_at(arg0: &mut Studio, arg1: u64) {
        arg0.period.pos0 = arg1;
    }

    public fun works(arg0: &Studio) : &0x176ca50788521662366802f5847edd1e41abb2532cc65d4d69b583a47f5444cd::derived_object_bag::DerivedObjectBag {
        &arg0.works
    }

    // decompiled from Move bytecode v6
}

