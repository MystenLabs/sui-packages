module 0xfa913a818445721fe43ab0b7e012b98281b28faec1e1cd9a3484ba7d251347f6::admin {
    struct AdminCap has key {
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

    public fun blacklist_boosterpool_address(arg0: &AdminCap, arg1: &mut BoosterPoolCap, arg2: address) {
        let (v0, v1) = find(&arg1.whitelisted_addresses, &arg2);
        assert!(v0, 3);
        0x1::vector::remove<address>(&mut arg1.whitelisted_addresses, v1);
    }

    public fun blacklist_volume_address(arg0: &AdminCap, arg1: &mut VolumeCap, arg2: address) {
        let (v0, v1) = find(&arg1.whitelisted_addresses, &arg2);
        assert!(v0, 2);
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

    public fun whitelist_boosterpool_address(arg0: &AdminCap, arg1: &mut BoosterPoolCap, arg2: address) {
        let (v0, _) = find(&arg1.whitelisted_addresses, &arg2);
        assert!(!v0, 1);
        0x1::vector::push_back<address>(&mut arg1.whitelisted_addresses, arg2);
    }

    public fun whitelist_volume_address(arg0: &AdminCap, arg1: &mut VolumeCap, arg2: address) {
        let (v0, _) = find(&arg1.whitelisted_addresses, &arg2);
        assert!(!v0, 0);
        0x1::vector::push_back<address>(&mut arg1.whitelisted_addresses, arg2);
    }

    // decompiled from Move bytecode v6
}

