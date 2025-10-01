module 0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::staking_contract {
    struct StakingContract has key {
        id: 0x2::object::UID,
        version: u64,
        admin: 0x2::object::ID,
        contract_kiosk: 0x2::kiosk::Kiosk,
        kiosk_cap: 0x2::kiosk::KioskOwnerCap,
        classes: 0x2::table::Table<0x2::object::ID, Class>,
        staked_nfts_ids: 0x2::table::Table<0x2::object::ID, bool>,
        staking_datas: 0x2::table::Table<address, 0x2::object::ID>,
    }

    struct Class has store {
        multiplier: u64,
        lock_time: u64,
    }

    public(friend) fun add_staking_data(arg0: &mut StakingContract, arg1: address, arg2: 0x2::object::ID) {
        0x2::table::add<address, 0x2::object::ID>(&mut arg0.staking_datas, arg1, arg2);
    }

    public(friend) fun can_create_staking_data(arg0: &StakingContract, arg1: address) : bool {
        !0x2::table::contains<address, 0x2::object::ID>(&arg0.staking_datas, arg1)
    }

    public(friend) fun class_exists(arg0: &StakingContract, arg1: 0x2::object::ID) : bool {
        0x2::table::contains<0x2::object::ID, Class>(&arg0.classes, arg1)
    }

    public(friend) fun create_and_share_staking_contract(arg0: 0x2::object::ID, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<StakingContract>(new_staking_contract(arg0, arg1));
    }

    fun get_class(arg0: &StakingContract, arg1: 0x2::object::ID) : &Class {
        0x2::table::borrow<0x2::object::ID, Class>(&arg0.classes, arg1)
    }

    public(friend) fun get_class_lock_time(arg0: &StakingContract, arg1: 0x2::object::ID) : u64 {
        get_class(arg0, arg1).lock_time
    }

    public(friend) fun get_class_multiplier(arg0: &StakingContract, arg1: 0x2::object::ID) : u64 {
        get_class(arg0, arg1).multiplier
    }

    fun get_class_mut(arg0: &mut StakingContract, arg1: 0x2::object::ID) : &mut Class {
        0x2::table::borrow_mut<0x2::object::ID, Class>(&mut arg0.classes, arg1)
    }

    public(friend) fun get_contract_kiosk_refs(arg0: &mut StakingContract) : (&mut 0x2::kiosk::Kiosk, &0x2::kiosk::KioskOwnerCap) {
        (&mut arg0.contract_kiosk, &arg0.kiosk_cap)
    }

    public(friend) fun get_staking_contract_admin(arg0: &StakingContract) : 0x2::object::ID {
        arg0.admin
    }

    public(friend) fun get_staking_contract_staked_nfts_ids_mut(arg0: &mut StakingContract) : &mut 0x2::table::Table<0x2::object::ID, bool> {
        &mut arg0.staked_nfts_ids
    }

    public(friend) fun get_staking_contract_version_mut(arg0: &mut StakingContract) : &mut u64 {
        &mut arg0.version
    }

    public(friend) fun insert_class(arg0: &mut StakingContract, arg1: 0x2::object::ID, arg2: u64, arg3: u64) {
        0x2::table::add<0x2::object::ID, Class>(&mut arg0.classes, arg1, new_class(arg2, arg3));
    }

    public(friend) fun is_correct_version(arg0: &StakingContract) {
        assert!(arg0.version == 0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::constant::get_VERSION(), 0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::constant::get_EIncorrectVersion());
    }

    public(friend) fun is_in_staking_contract(arg0: &StakingContract, arg1: 0x2::object::ID) : bool {
        0x2::table::contains<0x2::object::ID, bool>(&arg0.staked_nfts_ids, arg1)
    }

    fun new_class(arg0: u64, arg1: u64) : Class {
        Class{
            multiplier : arg0,
            lock_time  : arg1,
        }
    }

    fun new_staking_contract(arg0: 0x2::object::ID, arg1: &mut 0x2::tx_context::TxContext) : StakingContract {
        let (v0, v1) = 0x2::kiosk::new(arg1);
        StakingContract{
            id              : 0x2::object::new(arg1),
            version         : 0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::constant::get_VERSION(),
            admin           : arg0,
            contract_kiosk  : v0,
            kiosk_cap       : v1,
            classes         : 0x2::table::new<0x2::object::ID, Class>(arg1),
            staked_nfts_ids : 0x2::table::new<0x2::object::ID, bool>(arg1),
            staking_datas   : 0x2::table::new<address, 0x2::object::ID>(arg1),
        }
    }

    public(friend) fun set_class_lock_time(arg0: &mut StakingContract, arg1: 0x2::object::ID, arg2: u64) {
        get_class_mut(arg0, arg1).lock_time = arg2;
    }

    public(friend) fun set_class_multiplier(arg0: &mut StakingContract, arg1: 0x2::object::ID, arg2: u64) {
        get_class_mut(arg0, arg1).multiplier = arg2;
    }

    // decompiled from Move bytecode v6
}

