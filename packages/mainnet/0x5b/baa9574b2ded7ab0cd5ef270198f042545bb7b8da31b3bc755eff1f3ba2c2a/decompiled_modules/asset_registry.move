module 0x5bbaa9574b2ded7ab0cd5ef270198f042545bb7b8da31b3bc755eff1f3ba2c2a::asset_registry {
    struct AssetRegistryRecord has copy, drop, store {
        t: 0x1::ascii::String,
        d: u8,
        k: u8,
    }

    struct AssetRegistry has store, key {
        id: 0x2::object::UID,
        assets: vector<AssetRegistryRecord>,
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AssetRegistry{
            id     : 0x2::object::new(arg0),
            assets : 0x1::vector::empty<AssetRegistryRecord>(),
        };
        0x2::transfer::public_share_object<AssetRegistry>(v0);
    }

    public fun add_asset<T0>(arg0: &mut AssetRegistry, arg1: &0x2::coin::CoinMetadata<T0>, arg2: u8, arg3: &0x5bbaa9574b2ded7ab0cd5ef270198f042545bb7b8da31b3bc755eff1f3ba2c2a::admin::AdminCap) {
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0x1::type_name::borrow_string(&v0);
        let v2 = &arg0.assets;
        let v3 = 0;
        let v4;
        while (v3 < 0x1::vector::length<AssetRegistryRecord>(v2)) {
            let v5 = 0x1::vector::borrow<AssetRegistryRecord>(v2, v3).t;
            if (&v5 == v1) {
                v4 = 0x1::option::some<u64>(v3);
                /* label 6 */
                assert!(0x1::option::is_none<u64>(&v4), 301);
                let v6 = AssetRegistryRecord{
                    t : *v1,
                    d : 0x2::coin::get_decimals<T0>(arg1),
                    k : arg2,
                };
                0x1::vector::push_back<AssetRegistryRecord>(&mut arg0.assets, v6);
                return
            };
            v3 = v3 + 1;
        };
        v4 = 0x1::option::none<u64>();
        /* goto 6 */
    }

    public fun decimals(arg0: &AssetRegistryRecord) : u8 {
        arg0.d
    }

    public fun get_asset<T0>(arg0: &AssetRegistry) : &AssetRegistryRecord {
        0x1::vector::borrow<AssetRegistryRecord>(&arg0.assets, get_asset_id<T0>(arg0))
    }

    public fun get_asset_id<T0>(arg0: &AssetRegistry) : u64 {
        let v0 = 0x1::type_name::get<T0>();
        get_asset_id_unsafe(arg0, 0x1::type_name::borrow_string(&v0))
    }

    public(friend) fun get_asset_id_unsafe(arg0: &AssetRegistry, arg1: &0x1::ascii::String) : u64 {
        let v0 = &arg0.assets;
        let v1 = 0;
        let v2;
        while (v1 < 0x1::vector::length<AssetRegistryRecord>(v0)) {
            let v3 = 0x1::vector::borrow<AssetRegistryRecord>(v0, v1).t;
            if (&v3 == arg1) {
                v2 = 0x1::option::some<u64>(v1);
                /* label 6 */
                assert!(0x1::option::is_some<u64>(&v2), 300);
                return *0x1::option::borrow<u64>(&v2)
            };
            v1 = v1 + 1;
        };
        v2 = 0x1::option::none<u64>();
        /* goto 6 */
    }

    public(friend) fun get_asset_unsafe(arg0: &AssetRegistry, arg1: u64) : &AssetRegistryRecord {
        0x1::vector::borrow<AssetRegistryRecord>(&arg0.assets, arg1)
    }

    public fun kind(arg0: &AssetRegistryRecord) : u8 {
        arg0.k
    }

    // decompiled from Move bytecode v6
}

