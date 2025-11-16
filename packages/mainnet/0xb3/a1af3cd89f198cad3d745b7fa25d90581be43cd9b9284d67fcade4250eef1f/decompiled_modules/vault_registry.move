module 0xb3a1af3cd89f198cad3d745b7fa25d90581be43cd9b9284d67fcade4250eef1f::vault_registry {
    struct VaultInfo has copy, drop, store {
        vault_id: address,
        reward_manager_id: address,
        coin_type: vector<u8>,
        created_at_ms: u64,
        creator: address,
    }

    struct VaultRegistry has key {
        id: 0x2::object::UID,
        vaults: 0x2::vec_map::VecMap<address, VaultInfo>,
        admin: address,
    }

    struct VaultRegisteredEvent has copy, drop {
        vault_id: address,
        reward_manager_id: address,
        coin_type: vector<u8>,
        creator: address,
        timestamp_ms: u64,
    }

    public fun coin_type(arg0: &VaultInfo) : vector<u8> {
        arg0.coin_type
    }

    public fun create_registry(arg0: address, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = VaultRegistry{
            id     : 0x2::object::new(arg1),
            vaults : 0x2::vec_map::empty<address, VaultInfo>(),
            admin  : arg0,
        };
        0x2::transfer::share_object<VaultRegistry>(v0);
    }

    public fun created_at_ms(arg0: &VaultInfo) : u64 {
        arg0.created_at_ms
    }

    public fun creator(arg0: &VaultInfo) : address {
        arg0.creator
    }

    public fun get_admin(arg0: &VaultRegistry) : address {
        arg0.admin
    }

    public fun get_all_vaults(arg0: &VaultRegistry) : vector<VaultInfo> {
        let v0 = 0x1::vector::empty<VaultInfo>();
        let v1 = 0x2::vec_map::keys<address, VaultInfo>(&arg0.vaults);
        let v2 = 0;
        while (v2 < 0x1::vector::length<address>(&v1)) {
            let v3 = *0x1::vector::borrow<address>(&v1, v2);
            0x1::vector::push_back<VaultInfo>(&mut v0, *0x2::vec_map::get<address, VaultInfo>(&arg0.vaults, &v3));
            v2 = v2 + 1;
        };
        v0
    }

    public fun get_vault_info(arg0: &VaultRegistry, arg1: address) : 0x1::option::Option<VaultInfo> {
        if (0x2::vec_map::contains<address, VaultInfo>(&arg0.vaults, &arg1)) {
            0x1::option::some<VaultInfo>(*0x2::vec_map::get<address, VaultInfo>(&arg0.vaults, &arg1))
        } else {
            0x1::option::none<VaultInfo>()
        }
    }

    public entry fun register_vault_by_id<T0>(arg0: &mut VaultRegistry, arg1: &0xcd86f77503a755c48fe6c87e1b8e9a137ec0c1bf37aac8878b6083262b27fefa::vault::Vault<T0>, arg2: &0xcd86f77503a755c48fe6c87e1b8e9a137ec0c1bf37aac8878b6083262b27fefa::reward_manager::RewardManager<T0>, arg3: vector<u8>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(v0 == arg0.admin, 1);
        let v1 = 0xcd86f77503a755c48fe6c87e1b8e9a137ec0c1bf37aac8878b6083262b27fefa::vault::vault_id<T0>(arg1);
        let v2 = 0x2::object::id<0xcd86f77503a755c48fe6c87e1b8e9a137ec0c1bf37aac8878b6083262b27fefa::reward_manager::RewardManager<T0>>(arg2);
        let v3 = 0x2::object::id_to_address(&v2);
        assert!(!0x2::vec_map::contains<address, VaultInfo>(&arg0.vaults, &v1), 2);
        let v4 = 0x2::clock::timestamp_ms(arg4);
        let v5 = VaultInfo{
            vault_id          : v1,
            reward_manager_id : v3,
            coin_type         : arg3,
            created_at_ms     : v4,
            creator           : v0,
        };
        0x2::vec_map::insert<address, VaultInfo>(&mut arg0.vaults, v1, v5);
        let v6 = VaultRegisteredEvent{
            vault_id          : v1,
            reward_manager_id : v3,
            coin_type         : arg3,
            creator           : v0,
            timestamp_ms      : v4,
        };
        0x2::event::emit<VaultRegisteredEvent>(v6);
    }

    public fun reward_manager_id(arg0: &VaultInfo) : address {
        arg0.reward_manager_id
    }

    public fun vault_count(arg0: &VaultRegistry) : u64 {
        0x2::vec_map::length<address, VaultInfo>(&arg0.vaults)
    }

    public fun vault_id(arg0: &VaultInfo) : address {
        arg0.vault_id
    }

    // decompiled from Move bytecode v6
}

