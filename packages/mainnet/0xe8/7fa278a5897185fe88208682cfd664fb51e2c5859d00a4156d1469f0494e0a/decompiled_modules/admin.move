module 0xe87fa278a5897185fe88208682cfd664fb51e2c5859d00a4156d1469f0494e0a::admin {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct VolumeCap has store, key {
        id: 0x2::object::UID,
        whitelisted_addresses: vector<address>,
    }

    struct BoosterPoolCap has store, key {
        id: 0x2::object::UID,
        whitelisted_addresses: vector<address>,
    }

    struct VolumeUserWhitelistedEvent has copy, drop {
        sender: address,
        whitelisted_address: address,
    }

    struct BoosterUserWhitelistedEvent has copy, drop {
        sender: address,
        whitelisted_address: address,
    }

    struct VolumeUserBlacklistedEvent has copy, drop {
        sender: address,
        blacklisted_address: address,
    }

    struct BoosterUserBlacklistedEvent has copy, drop {
        sender: address,
        blacklisted_address: address,
    }

    public fun blacklist_boosterpool_address(arg0: &AdminCap, arg1: &mut BoosterPoolCap, arg2: address, arg3: &0x2::tx_context::TxContext) {
        let (v0, v1) = find(&arg1.whitelisted_addresses, &arg2);
        assert!(v0, 3);
        let v2 = BoosterUserBlacklistedEvent{
            sender              : 0x2::tx_context::sender(arg3),
            blacklisted_address : arg2,
        };
        0x2::event::emit<BoosterUserBlacklistedEvent>(v2);
        0x1::vector::remove<address>(&mut arg1.whitelisted_addresses, v1);
    }

    public fun blacklist_volume_address(arg0: &AdminCap, arg1: &mut VolumeCap, arg2: address, arg3: &0x2::tx_context::TxContext) {
        let (v0, v1) = find(&arg1.whitelisted_addresses, &arg2);
        assert!(v0, 2);
        let v2 = VolumeUserBlacklistedEvent{
            sender              : 0x2::tx_context::sender(arg3),
            blacklisted_address : arg2,
        };
        0x2::event::emit<VolumeUserBlacklistedEvent>(v2);
        0x1::vector::remove<address>(&mut arg1.whitelisted_addresses, v1);
    }

    public fun find(arg0: &vector<address>, arg1: &address) : (bool, u64) {
        0x1::vector::index_of<address>(arg0, arg1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = 0x1::vector::empty<address>();
        0x1::vector::push_back<address>(&mut v1, 0x2::tx_context::sender(arg0));
        let v2 = VolumeCap{
            id                    : 0x2::object::new(arg0),
            whitelisted_addresses : v1,
        };
        0x2::transfer::share_object<VolumeCap>(v2);
        let v3 = 0x1::vector::empty<address>();
        0x1::vector::push_back<address>(&mut v3, 0x2::tx_context::sender(arg0));
        let v4 = BoosterPoolCap{
            id                    : 0x2::object::new(arg0),
            whitelisted_addresses : v3,
        };
        0x2::transfer::share_object<BoosterPoolCap>(v4);
    }

    public fun is_booster_whitelisted(arg0: &BoosterPoolCap, arg1: &address) : bool {
        0x1::vector::contains<address>(&arg0.whitelisted_addresses, arg1)
    }

    public fun is_volume_whitelisted(arg0: &VolumeCap, arg1: &address) : bool {
        0x1::vector::contains<address>(&arg0.whitelisted_addresses, arg1)
    }

    public fun whitelist_boosterpool_address(arg0: &AdminCap, arg1: &mut BoosterPoolCap, arg2: address, arg3: &0x2::tx_context::TxContext) {
        let (v0, _) = find(&arg1.whitelisted_addresses, &arg2);
        assert!(!v0, 1);
        let v2 = BoosterUserWhitelistedEvent{
            sender              : 0x2::tx_context::sender(arg3),
            whitelisted_address : arg2,
        };
        0x2::event::emit<BoosterUserWhitelistedEvent>(v2);
        0x1::vector::push_back<address>(&mut arg1.whitelisted_addresses, arg2);
    }

    public fun whitelist_volume_address(arg0: &AdminCap, arg1: &mut VolumeCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let (v0, _) = find(&arg1.whitelisted_addresses, &arg2);
        assert!(!v0, 0);
        let v2 = VolumeUserWhitelistedEvent{
            sender              : 0x2::tx_context::sender(arg3),
            whitelisted_address : arg2,
        };
        0x2::event::emit<VolumeUserWhitelistedEvent>(v2);
        0x1::vector::push_back<address>(&mut arg1.whitelisted_addresses, arg2);
    }

    // decompiled from Move bytecode v6
}

