module 0x8cfc70c099cd1b4ee44aaa45c48acf80c217064f767f30bb97bc8cd5ddc87e48::types {
    struct UserProfile has store, key {
        id: 0x2::object::UID,
        address: address,
        name: 0x1::string::String,
        bio: 0x1::string::String,
        twitter_handle: 0x1::string::String,
        total_received: u64,
        total_sent: u64,
        tips_received_count: u64,
        tips_sent_count: u64,
    }

    struct Tip has copy, drop, store {
        from: address,
        to: address,
        amount: u64,
        message: 0x1::string::String,
        timestamp: u64,
    }

    struct TippingSystem has key {
        id: 0x2::object::UID,
        total_tips: u64,
        total_volume: u64,
        history: vector<Tip>,
        twitter_registry: 0x2::table::Table<vector<u8>, address>,
        address_registry: 0x2::table::Table<address, vector<u8>>,
    }

    public fun add_tip_to_history(arg0: &mut TippingSystem, arg1: Tip) {
        0x1::vector::push_back<Tip>(&mut arg0.history, arg1);
    }

    public fun clone_bytes(arg0: &vector<u8>) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<u8>(arg0)) {
            0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(arg0, v1));
            v1 = v1 + 1;
        };
        v0
    }

    public fun create_profile(arg0: address, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) : UserProfile {
        UserProfile{
            id                  : 0x2::object::new(arg4),
            address             : arg0,
            name                : arg1,
            bio                 : arg2,
            twitter_handle      : arg3,
            total_received      : 0,
            total_sent          : 0,
            tips_received_count : 0,
            tips_sent_count     : 0,
        }
    }

    public fun create_system(arg0: &mut 0x2::tx_context::TxContext) : TippingSystem {
        TippingSystem{
            id               : 0x2::object::new(arg0),
            total_tips       : 0,
            total_volume     : 0,
            history          : 0x1::vector::empty<Tip>(),
            twitter_registry : 0x2::table::new<vector<u8>, address>(arg0),
            address_registry : 0x2::table::new<address, vector<u8>>(arg0),
        }
    }

    public fun create_tip(arg0: address, arg1: address, arg2: u64, arg3: 0x1::string::String, arg4: u64) : Tip {
        Tip{
            from      : arg0,
            to        : arg1,
            amount    : arg2,
            message   : arg3,
            timestamp : arg4,
        }
    }

    public fun find_profile_address(arg0: &TippingSystem, arg1: vector<u8>) : (bool, address) {
        if (!0x2::table::contains<vector<u8>, address>(&arg0.twitter_registry, clone_bytes(&arg1))) {
            (false, @0x0)
        } else {
            (true, *0x2::table::borrow<vector<u8>, address>(&arg0.twitter_registry, arg1))
        }
    }

    public fun get_tip(arg0: &TippingSystem, arg1: u64) : (bool, Tip) {
        if (arg1 >= 0x1::vector::length<Tip>(&arg0.history)) {
            return (false, create_tip(@0x0, @0x0, 0, 0x1::string::utf8(b""), 0))
        };
        (true, *0x1::vector::borrow<Tip>(&arg0.history, arg1))
    }

    public fun handle_exists(arg0: &TippingSystem, arg1: &vector<u8>) : bool {
        0x2::table::contains<vector<u8>, address>(&arg0.twitter_registry, clone_bytes(arg1))
    }

    public fun history_size(arg0: &TippingSystem) : u64 {
        0x1::vector::length<Tip>(&arg0.history)
    }

    public fun increment_tips_received(arg0: &mut UserProfile) {
        arg0.tips_received_count = arg0.tips_received_count + 1;
    }

    public fun increment_tips_sent(arg0: &mut UserProfile) {
        arg0.tips_sent_count = arg0.tips_sent_count + 1;
    }

    public fun increment_total_received(arg0: &mut UserProfile, arg1: u64) {
        arg0.total_received = arg0.total_received + arg1;
    }

    public fun increment_total_sent(arg0: &mut UserProfile, arg1: u64) {
        arg0.total_sent = arg0.total_sent + arg1;
    }

    public fun increment_total_tips(arg0: &mut TippingSystem) {
        arg0.total_tips = arg0.total_tips + 1;
    }

    public fun increment_total_volume(arg0: &mut TippingSystem, arg1: u64) {
        arg0.total_volume = arg0.total_volume + arg1;
    }

    public fun owner_handle(arg0: &TippingSystem, arg1: address) : vector<u8> {
        clone_bytes(0x2::table::borrow<address, vector<u8>>(&arg0.address_registry, arg1))
    }

    public fun owner_has_profile(arg0: &TippingSystem, arg1: address) : bool {
        0x2::table::contains<address, vector<u8>>(&arg0.address_registry, arg1)
    }

    public fun profile_address(arg0: &UserProfile) : address {
        arg0.address
    }

    public fun profile_bio(arg0: &UserProfile) : 0x1::string::String {
        arg0.bio
    }

    public fun profile_name(arg0: &UserProfile) : 0x1::string::String {
        arg0.name
    }

    public fun profile_twitter_handle(arg0: &UserProfile) : 0x1::string::String {
        arg0.twitter_handle
    }

    public fun profiles_count(arg0: &TippingSystem) : u64 {
        0x2::table::length<vector<u8>, address>(&arg0.twitter_registry)
    }

    public fun register_owner(arg0: &mut TippingSystem, arg1: address, arg2: vector<u8>) {
        assert!(!0x2::table::contains<address, vector<u8>>(&arg0.address_registry, arg1), 0x8cfc70c099cd1b4ee44aaa45c48acf80c217064f767f30bb97bc8cd5ddc87e48::errors::profile_already_exists());
        0x2::table::add<address, vector<u8>>(&mut arg0.address_registry, arg1, arg2);
    }

    public fun register_profile(arg0: &mut TippingSystem, arg1: vector<u8>, arg2: address) {
        assert!(0x1::vector::length<u8>(&arg1) > 0, 0x8cfc70c099cd1b4ee44aaa45c48acf80c217064f767f30bb97bc8cd5ddc87e48::errors::invalid_handle());
        assert!(!0x2::table::contains<vector<u8>, address>(&arg0.twitter_registry, clone_bytes(&arg1)), 0x8cfc70c099cd1b4ee44aaa45c48acf80c217064f767f30bb97bc8cd5ddc87e48::errors::handle_taken());
        0x2::table::add<vector<u8>, address>(&mut arg0.twitter_registry, arg1, arg2);
    }

    public fun remove_handle_entry(arg0: &mut TippingSystem, arg1: vector<u8>) {
        0x2::table::remove<vector<u8>, address>(&mut arg0.twitter_registry, arg1);
    }

    public fun remove_owner(arg0: &mut TippingSystem, arg1: address) {
        0x2::table::remove<address, vector<u8>>(&mut arg0.address_registry, arg1);
    }

    public fun set_profile_bio(arg0: &mut UserProfile, arg1: 0x1::string::String) {
        arg0.bio = arg1;
    }

    public fun set_profile_name(arg0: &mut UserProfile, arg1: 0x1::string::String) {
        arg0.name = arg1;
    }

    public fun set_profile_twitter(arg0: &mut UserProfile, arg1: 0x1::string::String) {
        arg0.twitter_handle = arg1;
    }

    public fun share_system(arg0: TippingSystem) {
        0x2::transfer::share_object<TippingSystem>(arg0);
    }

    public fun tips_received_count(arg0: &UserProfile) : u64 {
        arg0.tips_received_count
    }

    public fun tips_sent_count(arg0: &UserProfile) : u64 {
        arg0.tips_sent_count
    }

    public fun total_received(arg0: &UserProfile) : u64 {
        arg0.total_received
    }

    public fun total_sent(arg0: &UserProfile) : u64 {
        arg0.total_sent
    }

    public fun total_tips(arg0: &TippingSystem) : u64 {
        arg0.total_tips
    }

    public fun total_volume(arg0: &TippingSystem) : u64 {
        arg0.total_volume
    }

    public fun transfer_profile(arg0: UserProfile, arg1: address) {
        0x2::transfer::public_transfer<UserProfile>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

