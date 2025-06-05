module 0xe49f6a7ca254bb33dc325849a4481494c4963fd982e473a1afb14994040a5bc::typus_hedge {
    struct TYPUS_HEDGE has drop {
        dummy_field: bool,
    }

    struct VERSION has drop {
        dummy_field: bool,
    }

    struct Registry has key {
        id: 0x2::object::UID,
        num_of_vault: u64,
        transaction_suspended: bool,
    }

    struct Vault has store, key {
        id: 0x2::object::UID,
        main_token: 0x1::type_name::TypeName,
        hedge_token: 0x1::type_name::TypeName,
        reward_tokens: vector<0x1::type_name::TypeName>,
        info: 0x2::vec_map::VecMap<0x1::ascii::String, u64>,
        config: 0x2::vec_map::VecMap<0x1::ascii::String, u64>,
        share: 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::keyed_big_vector::KeyedBigVector,
        share_supply: vector<u64>,
        u64_padding: vector<u64>,
        bcs_padding: vector<vector<u8>>,
    }

    struct Account has store, key {
        id: 0x2::object::UID,
    }

    struct ManagerEvent has copy, drop {
        action: 0x1::ascii::String,
        log: vector<u64>,
        bcs_padding: vector<vector<u8>>,
    }

    struct UserEvent has copy, drop {
        action: 0x1::ascii::String,
        log: vector<u64>,
        bcs_padding: vector<vector<u8>>,
    }

    fun init(arg0: TYPUS_HEDGE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = VERSION{dummy_field: false};
        0xb44f547f5f9e35513a35139a8f2381923ea3f861e6d8debcd5aaf077f2d3a39d::version::issue_version<TYPUS_HEDGE, VERSION>(&arg0, v0, arg1);
        let v1 = 0x2::object::new(arg1);
        let v2 = Vault{
            id            : 0x2::object::new(arg1),
            main_token    : 0x1::type_name::get<u64>(),
            hedge_token   : 0x1::type_name::get<u64>(),
            reward_tokens : 0x1::vector::empty<0x1::type_name::TypeName>(),
            info          : 0x2::vec_map::empty<0x1::ascii::String, u64>(),
            config        : 0x2::vec_map::empty<0x1::ascii::String, u64>(),
            share         : 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::keyed_big_vector::new<u64, u64>(1000, arg1),
            share_supply  : vector[],
            u64_padding   : vector[],
            bcs_padding   : vector[],
        };
        0x2::dynamic_field::add<u64, Vault>(&mut v1, 0, v2);
        let v3 = Registry{
            id                    : v1,
            num_of_vault          : 0,
            transaction_suspended : false,
        };
        0x2::transfer::share_object<Registry>(v3);
    }

    entry fun resume_transaction(arg0: &0xb44f547f5f9e35513a35139a8f2381923ea3f861e6d8debcd5aaf077f2d3a39d::version::Version, arg1: &mut Registry, arg2: &0x2::tx_context::TxContext) {
        0xb44f547f5f9e35513a35139a8f2381923ea3f861e6d8debcd5aaf077f2d3a39d::version::verify_authority(arg0, arg2);
        let v0 = VERSION{dummy_field: false};
        0xb44f547f5f9e35513a35139a8f2381923ea3f861e6d8debcd5aaf077f2d3a39d::version::verify_witness<VERSION>(arg0, v0);
        0xb44f547f5f9e35513a35139a8f2381923ea3f861e6d8debcd5aaf077f2d3a39d::version::verify_version(arg0, 1);
        arg1.transaction_suspended = false;
        let v1 = ManagerEvent{
            action      : 0x1::ascii::string(b"resume_transaction"),
            log         : vector[],
            bcs_padding : vector[],
        };
        0x2::event::emit<ManagerEvent>(v1);
    }

    entry fun suspend_transaction(arg0: &0xb44f547f5f9e35513a35139a8f2381923ea3f861e6d8debcd5aaf077f2d3a39d::version::Version, arg1: &mut Registry, arg2: &0x2::tx_context::TxContext) {
        0xb44f547f5f9e35513a35139a8f2381923ea3f861e6d8debcd5aaf077f2d3a39d::version::verify_authority(arg0, arg2);
        let v0 = VERSION{dummy_field: false};
        0xb44f547f5f9e35513a35139a8f2381923ea3f861e6d8debcd5aaf077f2d3a39d::version::verify_witness<VERSION>(arg0, v0);
        0xb44f547f5f9e35513a35139a8f2381923ea3f861e6d8debcd5aaf077f2d3a39d::version::verify_version(arg0, 1);
        arg1.transaction_suspended = true;
        let v1 = ManagerEvent{
            action      : 0x1::ascii::string(b"suspend_transaction"),
            log         : vector[],
            bcs_padding : vector[],
        };
        0x2::event::emit<ManagerEvent>(v1);
    }

    // decompiled from Move bytecode v6
}

