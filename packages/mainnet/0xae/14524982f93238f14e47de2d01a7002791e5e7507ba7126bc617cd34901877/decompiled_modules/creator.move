module 0xae14524982f93238f14e47de2d01a7002791e5e7507ba7126bc617cd34901877::creator {
    struct CreatorRegistry has key {
        id: 0x2::object::UID,
        creators: 0x2::table::Table<address, 0x2::object::ID>,
        total_creators: u64,
    }

    struct CreatorProfile<phantom T0> has store, key {
        id: 0x2::object::UID,
        owner: address,
        name: 0x1::string::String,
        bio: 0x1::string::String,
        avatar_url: 0x1::string::String,
        total_tips_received: u64,
        tip_count: u64,
        balance: 0x2::balance::Balance<T0>,
        created_at: u64,
        updated_at: u64,
    }

    struct CreatorRegistered has copy, drop {
        creator_address: address,
        profile_id: 0x2::object::ID,
        name: 0x1::string::String,
    }

    struct CreatorProfileUpdated has copy, drop {
        profile_id: 0x2::object::ID,
        name: 0x1::string::String,
    }

    struct TipsWithdrawn has copy, drop {
        creator_address: address,
        amount: u64,
    }

    public fun withdraw_all<T0>(arg0: &mut CreatorProfile<T0>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg0.owner == 0x2::tx_context::sender(arg1), 2);
        let v0 = 0x2::balance::value<T0>(&arg0.balance);
        assert!(v0 > 0, 4);
        let v1 = TipsWithdrawn{
            creator_address : arg0.owner,
            amount          : v0,
        };
        0x2::event::emit<TipsWithdrawn>(v1);
        0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg0.balance), arg1)
    }

    public fun get_avatar_url<T0>(arg0: &CreatorProfile<T0>) : 0x1::string::String {
        arg0.avatar_url
    }

    public fun get_balance<T0>(arg0: &CreatorProfile<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    public fun get_bio<T0>(arg0: &CreatorProfile<T0>) : 0x1::string::String {
        arg0.bio
    }

    public fun get_created_at<T0>(arg0: &CreatorProfile<T0>) : u64 {
        arg0.created_at
    }

    public fun get_name<T0>(arg0: &CreatorProfile<T0>) : 0x1::string::String {
        arg0.name
    }

    public fun get_owner<T0>(arg0: &CreatorProfile<T0>) : address {
        arg0.owner
    }

    public fun get_profile_id(arg0: &CreatorRegistry, arg1: address) : 0x2::object::ID {
        assert!(0x2::table::contains<address, 0x2::object::ID>(&arg0.creators, arg1), 1);
        *0x2::table::borrow<address, 0x2::object::ID>(&arg0.creators, arg1)
    }

    public fun get_tip_count<T0>(arg0: &CreatorProfile<T0>) : u64 {
        arg0.tip_count
    }

    public fun get_total_creators(arg0: &CreatorRegistry) : u64 {
        arg0.total_creators
    }

    public fun get_total_tips_received<T0>(arg0: &CreatorProfile<T0>) : u64 {
        arg0.total_tips_received
    }

    public fun get_updated_at<T0>(arg0: &CreatorProfile<T0>) : u64 {
        arg0.updated_at
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = CreatorRegistry{
            id             : 0x2::object::new(arg0),
            creators       : 0x2::table::new<address, 0x2::object::ID>(arg0),
            total_creators : 0,
        };
        0x2::transfer::share_object<CreatorRegistry>(v0);
    }

    public fun is_registered(arg0: &CreatorRegistry, arg1: address) : bool {
        0x2::table::contains<address, 0x2::object::ID>(&arg0.creators, arg1)
    }

    public(friend) fun receive_tip<T0>(arg0: &mut CreatorProfile<T0>, arg1: 0x2::balance::Balance<T0>) {
        arg0.total_tips_received = arg0.total_tips_received + 0x2::balance::value<T0>(&arg1);
        arg0.tip_count = arg0.tip_count + 1;
        0x2::balance::join<T0>(&mut arg0.balance, arg1);
    }

    public fun register<T0>(arg0: &mut CreatorRegistry, arg1: &mut 0xae14524982f93238f14e47de2d01a7002791e5e7507ba7126bc617cd34901877::platform::Platform, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        assert!(!0x2::table::contains<address, 0x2::object::ID>(&arg0.creators, v0), 0);
        let v1 = 0x1::vector::length<u8>(&arg2);
        assert!(v1 >= 1 && v1 <= 64, 3);
        let v2 = 0x2::clock::timestamp_ms(arg5);
        let v3 = CreatorProfile<T0>{
            id                  : 0x2::object::new(arg6),
            owner               : v0,
            name                : 0x1::string::utf8(arg2),
            bio                 : 0x1::string::utf8(arg3),
            avatar_url          : 0x1::string::utf8(arg4),
            total_tips_received : 0,
            tip_count           : 0,
            balance             : 0x2::balance::zero<T0>(),
            created_at          : v2,
            updated_at          : v2,
        };
        let v4 = 0x2::object::id<CreatorProfile<T0>>(&v3);
        0x2::table::add<address, 0x2::object::ID>(&mut arg0.creators, v0, v4);
        arg0.total_creators = arg0.total_creators + 1;
        0xae14524982f93238f14e47de2d01a7002791e5e7507ba7126bc617cd34901877::platform::increment_creator_count(arg1);
        let v5 = CreatorRegistered{
            creator_address : v0,
            profile_id      : v4,
            name            : v3.name,
        };
        0x2::event::emit<CreatorRegistered>(v5);
        0x2::transfer::public_transfer<CreatorProfile<T0>>(v3, v0);
    }

    public fun update_profile<T0>(arg0: &mut CreatorProfile<T0>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg5), 2);
        let v0 = 0x1::vector::length<u8>(&arg1);
        assert!(v0 >= 1 && v0 <= 64, 3);
        arg0.name = 0x1::string::utf8(arg1);
        arg0.bio = 0x1::string::utf8(arg2);
        arg0.avatar_url = 0x1::string::utf8(arg3);
        arg0.updated_at = 0x2::clock::timestamp_ms(arg4);
        let v1 = CreatorProfileUpdated{
            profile_id : 0x2::object::id<CreatorProfile<T0>>(arg0),
            name       : arg0.name,
        };
        0x2::event::emit<CreatorProfileUpdated>(v1);
    }

    public fun withdraw<T0>(arg0: &mut CreatorProfile<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 2);
        assert!(0x2::balance::value<T0>(&arg0.balance) >= arg1, 4);
        let v0 = TipsWithdrawn{
            creator_address : arg0.owner,
            amount          : arg1,
        };
        0x2::event::emit<TipsWithdrawn>(v0);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, arg1), arg2)
    }

    // decompiled from Move bytecode v6
}

