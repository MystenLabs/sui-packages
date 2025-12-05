module 0x515a552652d3d7cb4e219772ba78e17997bf7e2ffd9502a0275750574bfacdc8::staking_lock_rule {
    struct Rule has drop {
        dummy_field: bool,
    }

    struct Config has drop, store {
        registry_id: 0x2::object::ID,
    }

    struct StakingRegistry has key {
        id: 0x2::object::UID,
        staked_ducks: 0x2::table::Table<0x2::object::ID, address>,
    }

    struct RegistryAdminCap has store, key {
        id: 0x2::object::UID,
    }

    public fun add(arg0: &mut 0x2::transfer_policy::TransferPolicy<0x515a552652d3d7cb4e219772ba78e17997bf7e2ffd9502a0275750574bfacdc8::duck_nft::DuckNFT>, arg1: &0x2::transfer_policy::TransferPolicyCap<0x515a552652d3d7cb4e219772ba78e17997bf7e2ffd9502a0275750574bfacdc8::duck_nft::DuckNFT>, arg2: &StakingRegistry) {
        let v0 = Rule{dummy_field: false};
        let v1 = Config{registry_id: 0x2::object::id<StakingRegistry>(arg2)};
        0x2::transfer_policy::add_rule<0x515a552652d3d7cb4e219772ba78e17997bf7e2ffd9502a0275750574bfacdc8::duck_nft::DuckNFT, Rule, Config>(v0, arg0, arg1, v1);
    }

    public(friend) fun add_staked_duck(arg0: &mut StakingRegistry, arg1: 0x2::object::ID, arg2: address) {
        if (!0x2::table::contains<0x2::object::ID, address>(&arg0.staked_ducks, arg1)) {
            0x2::table::add<0x2::object::ID, address>(&mut arg0.staked_ducks, arg1, arg2);
        };
    }

    public fun create_registry(arg0: &mut 0x2::tx_context::TxContext) : RegistryAdminCap {
        let v0 = StakingRegistry{
            id           : 0x2::object::new(arg0),
            staked_ducks : 0x2::table::new<0x2::object::ID, address>(arg0),
        };
        0x2::transfer::share_object<StakingRegistry>(v0);
        RegistryAdminCap{id: 0x2::object::new(arg0)}
    }

    public fun get_staked_duck_owner(arg0: &StakingRegistry, arg1: 0x2::object::ID) : address {
        assert!(0x2::table::contains<0x2::object::ID, address>(&arg0.staked_ducks, arg1), 2);
        *0x2::table::borrow<0x2::object::ID, address>(&arg0.staked_ducks, arg1)
    }

    public entry fun init_registry(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = create_registry(arg0);
        0x2::transfer::transfer<RegistryAdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun is_duck_staked(arg0: &StakingRegistry, arg1: 0x2::object::ID) : bool {
        0x2::table::contains<0x2::object::ID, address>(&arg0.staked_ducks, arg1)
    }

    public fun prove(arg0: &0x2::transfer_policy::TransferPolicy<0x515a552652d3d7cb4e219772ba78e17997bf7e2ffd9502a0275750574bfacdc8::duck_nft::DuckNFT>, arg1: &mut 0x2::transfer_policy::TransferRequest<0x515a552652d3d7cb4e219772ba78e17997bf7e2ffd9502a0275750574bfacdc8::duck_nft::DuckNFT>, arg2: &StakingRegistry) {
        assert!(!0x2::table::contains<0x2::object::ID, address>(&arg2.staked_ducks, 0x2::transfer_policy::item<0x515a552652d3d7cb4e219772ba78e17997bf7e2ffd9502a0275750574bfacdc8::duck_nft::DuckNFT>(arg1)), 0);
        let v0 = Rule{dummy_field: false};
        0x2::transfer_policy::add_receipt<0x515a552652d3d7cb4e219772ba78e17997bf7e2ffd9502a0275750574bfacdc8::duck_nft::DuckNFT, Rule>(v0, arg1);
    }

    public fun registry_id(arg0: &StakingRegistry) : 0x2::object::ID {
        0x2::object::id<StakingRegistry>(arg0)
    }

    public(friend) fun remove_staked_duck(arg0: &mut StakingRegistry, arg1: 0x2::object::ID) {
        if (0x2::table::contains<0x2::object::ID, address>(&arg0.staked_ducks, arg1)) {
            0x2::table::remove<0x2::object::ID, address>(&mut arg0.staked_ducks, arg1);
        };
    }

    public fun total_staked(arg0: &StakingRegistry) : u64 {
        0x2::table::length<0x2::object::ID, address>(&arg0.staked_ducks)
    }

    // decompiled from Move bytecode v6
}

