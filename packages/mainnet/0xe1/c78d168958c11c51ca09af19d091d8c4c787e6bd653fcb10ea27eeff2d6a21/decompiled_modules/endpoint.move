module 0xe1c78d168958c11c51ca09af19d091d8c4c787e6bd653fcb10ea27eeff2d6a21::endpoint {
    struct InitEvent has copy, drop {
        sender: address,
        admin_cap_id: 0x2::object::ID,
        supply_bag_id: 0x2::object::ID,
        mint_proof_id: 0x2::object::ID,
        global_paulse_status_id: 0x2::object::ID,
    }

    struct RegisterCoinEvent has copy, drop {
        sender: address,
        coin_type: 0x1::type_name::TypeName,
    }

    struct MintEvent has copy, drop {
        sender: address,
        coin_type: 0x1::string::String,
        to: address,
        amount: u64,
        nonce: u64,
    }

    struct BurnEvent has copy, drop {
        sender: address,
        coin_type: 0x1::type_name::TypeName,
        target_chain_id: 0x1::string::String,
        recipient: vector<u8>,
        amount: u64,
    }

    public entry fun burn<T0>(arg0: &mut 0xe1c78d168958c11c51ca09af19d091d8c4c787e6bd653fcb10ea27eeff2d6a21::supply_bag::SupplyBag, arg1: 0x2::coin::Coin<T0>, arg2: 0x1::string::String, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::into_balance<T0>(arg1);
        0xe1c78d168958c11c51ca09af19d091d8c4c787e6bd653fcb10ea27eeff2d6a21::supply_bag::decrease_supply<T0>(arg0, v0);
        let v1 = BurnEvent{
            sender          : 0x2::tx_context::sender(arg4),
            coin_type       : 0x1::type_name::get<T0>(),
            target_chain_id : arg2,
            recipient       : arg3,
            amount          : 0x2::balance::value<T0>(&v0),
        };
        0x2::event::emit<BurnEvent>(v1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xe1c78d168958c11c51ca09af19d091d8c4c787e6bd653fcb10ea27eeff2d6a21::admin::new(arg0);
        0x2::transfer::public_transfer<0xe1c78d168958c11c51ca09af19d091d8c4c787e6bd653fcb10ea27eeff2d6a21::admin::AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = 0xe1c78d168958c11c51ca09af19d091d8c4c787e6bd653fcb10ea27eeff2d6a21::supply_bag::new(arg0);
        0x2::transfer::public_share_object<0xe1c78d168958c11c51ca09af19d091d8c4c787e6bd653fcb10ea27eeff2d6a21::supply_bag::SupplyBag>(v1);
        let v2 = 0xe1c78d168958c11c51ca09af19d091d8c4c787e6bd653fcb10ea27eeff2d6a21::mint_proof::new(0x1::vector::empty<u8>(), arg0);
        0x2::transfer::public_share_object<0xe1c78d168958c11c51ca09af19d091d8c4c787e6bd653fcb10ea27eeff2d6a21::mint_proof::MintProof>(v2);
        let v3 = InitEvent{
            sender                  : 0x2::tx_context::sender(arg0),
            admin_cap_id            : 0x2::object::id<0xe1c78d168958c11c51ca09af19d091d8c4c787e6bd653fcb10ea27eeff2d6a21::admin::AdminCap>(&v0),
            supply_bag_id           : 0x2::object::id<0xe1c78d168958c11c51ca09af19d091d8c4c787e6bd653fcb10ea27eeff2d6a21::supply_bag::SupplyBag>(&v1),
            mint_proof_id           : 0x2::object::id<0xe1c78d168958c11c51ca09af19d091d8c4c787e6bd653fcb10ea27eeff2d6a21::mint_proof::MintProof>(&v2),
            global_paulse_status_id : 0xe1c78d168958c11c51ca09af19d091d8c4c787e6bd653fcb10ea27eeff2d6a21::status::new_global_pause_status_and_shared(arg0),
        };
        0x2::event::emit<InitEvent>(v3);
    }

    public entry fun mint<T0>(arg0: &mut 0xe1c78d168958c11c51ca09af19d091d8c4c787e6bd653fcb10ea27eeff2d6a21::supply_bag::SupplyBag, arg1: &mut 0xe1c78d168958c11c51ca09af19d091d8c4c787e6bd653fcb10ea27eeff2d6a21::mint_proof::MintProof, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xe1c78d168958c11c51ca09af19d091d8c4c787e6bd653fcb10ea27eeff2d6a21::mint_proof::verify_msg(arg1, &arg2);
        let v2 = v1;
        assert!(v0, 1);
        let v3 = 0xe1c78d168958c11c51ca09af19d091d8c4c787e6bd653fcb10ea27eeff2d6a21::mint_proof::decode_msg(&v2);
        assert!(0x1::option::is_some<0xe1c78d168958c11c51ca09af19d091d8c4c787e6bd653fcb10ea27eeff2d6a21::mint_proof::MintArg>(&v3), 2);
        let v4 = 0x1::option::borrow<0xe1c78d168958c11c51ca09af19d091d8c4c787e6bd653fcb10ea27eeff2d6a21::mint_proof::MintArg>(&v3);
        let v5 = 0xe1c78d168958c11c51ca09af19d091d8c4c787e6bd653fcb10ea27eeff2d6a21::mint_proof::get_mint_arg_coin_type(v4);
        assert!(0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>())) == 0x1::string::substring(&v5, 2, 0x1::string::length(&v5)), 3);
        assert!(!0xe1c78d168958c11c51ca09af19d091d8c4c787e6bd653fcb10ea27eeff2d6a21::mint_proof::is_nonce_used(arg1, 0xe1c78d168958c11c51ca09af19d091d8c4c787e6bd653fcb10ea27eeff2d6a21::mint_proof::get_mint_arg_nonce(v4)), 4);
        0xe1c78d168958c11c51ca09af19d091d8c4c787e6bd653fcb10ea27eeff2d6a21::mint_proof::set_nonce_used(arg1, 0xe1c78d168958c11c51ca09af19d091d8c4c787e6bd653fcb10ea27eeff2d6a21::mint_proof::get_mint_arg_nonce(v4));
        let v6 = 0x1::u256::try_as_u64(0xe1c78d168958c11c51ca09af19d091d8c4c787e6bd653fcb10ea27eeff2d6a21::mint_proof::get_mint_arg_amount(v4));
        let v7 = 0x1::option::borrow<u64>(&v6);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0xe1c78d168958c11c51ca09af19d091d8c4c787e6bd653fcb10ea27eeff2d6a21::supply_bag::increase_supply<T0>(arg0, *v7), arg3), 0xe1c78d168958c11c51ca09af19d091d8c4c787e6bd653fcb10ea27eeff2d6a21::mint_proof::get_mint_arg_to(v4));
        let v8 = MintEvent{
            sender    : 0x2::tx_context::sender(arg3),
            coin_type : 0xe1c78d168958c11c51ca09af19d091d8c4c787e6bd653fcb10ea27eeff2d6a21::mint_proof::get_mint_arg_coin_type(v4),
            to        : 0xe1c78d168958c11c51ca09af19d091d8c4c787e6bd653fcb10ea27eeff2d6a21::mint_proof::get_mint_arg_to(v4),
            amount    : *v7,
            nonce     : 0xe1c78d168958c11c51ca09af19d091d8c4c787e6bd653fcb10ea27eeff2d6a21::mint_proof::get_mint_arg_nonce(v4),
        };
        0x2::event::emit<MintEvent>(v8);
    }

    public entry fun register_coin<T0>(arg0: &0xe1c78d168958c11c51ca09af19d091d8c4c787e6bd653fcb10ea27eeff2d6a21::admin::AdminCap, arg1: &mut 0xe1c78d168958c11c51ca09af19d091d8c4c787e6bd653fcb10ea27eeff2d6a21::supply_bag::SupplyBag, arg2: 0x2::coin::TreasuryCap<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        0xe1c78d168958c11c51ca09af19d091d8c4c787e6bd653fcb10ea27eeff2d6a21::supply_bag::add_supply<T0>(0x2::coin::treasury_into_supply<T0>(arg2), arg1);
        let v0 = RegisterCoinEvent{
            sender    : 0x2::tx_context::sender(arg3),
            coin_type : 0x1::type_name::get<T0>(),
        };
        0x2::event::emit<RegisterCoinEvent>(v0);
    }

    public entry fun set_minter_public_key(arg0: &0xe1c78d168958c11c51ca09af19d091d8c4c787e6bd653fcb10ea27eeff2d6a21::admin::AdminCap, arg1: &mut 0xe1c78d168958c11c51ca09af19d091d8c4c787e6bd653fcb10ea27eeff2d6a21::mint_proof::MintProof, arg2: vector<u8>) {
        0xe1c78d168958c11c51ca09af19d091d8c4c787e6bd653fcb10ea27eeff2d6a21::mint_proof::set_public_key(arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

