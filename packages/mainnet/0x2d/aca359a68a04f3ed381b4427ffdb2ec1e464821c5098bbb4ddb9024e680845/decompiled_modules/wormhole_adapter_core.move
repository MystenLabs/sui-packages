module 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::wormhole_adapter_core {
    struct CoreState has store, key {
        id: 0x2::object::UID,
        wormhole_emitter: 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::emitter::EmitterCap,
        consumed_vaas: 0x2::object_table::ObjectTable<0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes32::Bytes32, 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::wormhole_adapter_verify::Unit>,
        registered_emitters: 0x2::vec_map::VecMap<u16, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::ExternalAddress>,
    }

    struct RegisterBridge has copy, drop {
        wormhole_emitter_chain: u16,
        wormhole_emitter_address: vector<u8>,
    }

    struct DeleteBridge has copy, drop {
        wormhole_emitter_chain: u16,
        wormhole_emitter_address: vector<u8>,
    }

    struct RegisterOwner has copy, drop {
        dola_chain_id: u16,
        dola_contract: u256,
    }

    struct DeleteOwner has copy, drop {
        dola_chain_id: u16,
        dola_contract: u256,
    }

    struct RegisterSpender has copy, drop {
        dola_chain_id: u16,
        dola_contract: u256,
    }

    struct DeleteSpender has copy, drop {
        dola_chain_id: u16,
        dola_contract: u256,
    }

    public fun delete_remote_bridge(arg0: &0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::genesis::GovernanceCap, arg1: &mut CoreState, arg2: u16) {
        assert!(0x2::vec_map::contains<u16, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::ExternalAddress>(&arg1.registered_emitters, &arg2), 0);
        let (_, v1) = 0x2::vec_map::remove<u16, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::ExternalAddress>(&mut arg1.registered_emitters, &arg2);
        let v2 = RegisterBridge{
            wormhole_emitter_chain   : arg2,
            wormhole_emitter_address : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::to_bytes(v1),
        };
        0x2::event::emit<RegisterBridge>(v2);
    }

    public fun initialize_cap_with_governance(arg0: &0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::genesis::GovernanceCap, arg1: &mut 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = CoreState{
            id                  : 0x2::object::new(arg2),
            wormhole_emitter    : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::emitter::new(arg1, arg2),
            consumed_vaas       : 0x2::object_table::new<0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes32::Bytes32, 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::wormhole_adapter_verify::Unit>(arg2),
            registered_emitters : 0x2::vec_map::empty<u16, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::ExternalAddress>(),
        };
        0x2::transfer::public_share_object<CoreState>(v0);
    }

    public(friend) fun receive_deposit(arg0: &mut 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg1: &mut CoreState, arg2: &0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::app_manager::AppCap, arg3: vector<u8>, arg4: &mut 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::pool_manager::PoolManagerInfo, arg5: &mut 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::user_manager::UserManagerInfo, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::dola_address::DolaAddress, 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::dola_address::DolaAddress, u256, vector<u8>) {
        let (v0, v1, v2, v3, _, v5) = 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::pool_codec::decode_deposit_payload(0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::take_payload(0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::wormhole_adapter_verify::parse_verify_and_replay_protect(arg0, &arg1.registered_emitters, &mut arg1.consumed_vaas, arg3, arg6, arg7)));
        assert!(0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::app_manager::get_app_id(arg2) == v3, 2);
        let (v6, _) = 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::pool_manager::add_liquidity(arg4, v0, 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::app_manager::get_app_id(arg2), (v2 as u256));
        if (!0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::user_manager::is_dola_user(arg5, v1)) {
            0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::user_manager::register_dola_user_id(arg5, v1);
        };
        (v0, v1, v6, v5)
    }

    public(friend) fun receive_message(arg0: &mut 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg1: &mut CoreState, arg2: &0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::app_manager::AppCap, arg3: vector<u8>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::dola_address::DolaAddress, vector<u8>) {
        let (v0, v1, _, v3) = 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::pool_codec::decode_send_message_payload(0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::take_payload(0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::wormhole_adapter_verify::parse_verify_and_replay_protect(arg0, &arg1.registered_emitters, &mut arg1.consumed_vaas, arg3, arg4, arg5)));
        assert!(0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::app_manager::get_app_id(arg2) == v1, 2);
        (v0, v3)
    }

    public(friend) fun receive_withdraw(arg0: &mut 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg1: &mut CoreState, arg2: &0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::app_manager::AppCap, arg3: vector<u8>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::dola_address::DolaAddress, vector<u8>) {
        let (v0, v1, _, v3) = 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::pool_codec::decode_send_message_payload(0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::take_payload(0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::wormhole_adapter_verify::parse_verify_and_replay_protect(arg0, &arg1.registered_emitters, &mut arg1.consumed_vaas, arg3, arg4, arg5)));
        assert!(0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::app_manager::get_app_id(arg2) == v1, 2);
        (v0, v3)
    }

    public fun register_remote_bridge(arg0: &0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::genesis::GovernanceCap, arg1: &mut CoreState, arg2: u16, arg3: vector<u8>) {
        assert!(!0x2::vec_map::contains<u16, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::ExternalAddress>(&arg1.registered_emitters, &arg2), 1);
        0x2::vec_map::insert<u16, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::ExternalAddress>(&mut arg1.registered_emitters, arg2, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::new(0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes32::new(arg3)));
        let v0 = RegisterBridge{
            wormhole_emitter_chain   : arg2,
            wormhole_emitter_address : arg3,
        };
        0x2::event::emit<RegisterBridge>(v0);
    }

    public fun remote_delete_owner(arg0: &0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::genesis::GovernanceCap, arg1: &mut 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg2: &mut CoreState, arg3: u16, arg4: u256, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: &0x2::clock::Clock) {
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::publish_message::publish_message(arg1, arg5, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::publish_message::prepare_message(&mut arg2.wormhole_emitter, 0, 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::pool_codec::encode_manage_pool_payload(arg3, arg4, 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::pool_codec::get_delete_owner_type())), arg6);
        let v0 = DeleteOwner{
            dola_chain_id : arg3,
            dola_contract : arg4,
        };
        0x2::event::emit<DeleteOwner>(v0);
    }

    public fun remote_delete_spender(arg0: &0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::genesis::GovernanceCap, arg1: &mut 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg2: &mut CoreState, arg3: u16, arg4: u256, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: &0x2::clock::Clock) {
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::publish_message::publish_message(arg1, arg5, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::publish_message::prepare_message(&mut arg2.wormhole_emitter, 0, 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::pool_codec::encode_manage_pool_payload(arg3, arg4, 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::pool_codec::get_delete_spender_type())), arg6);
        let v0 = DeleteSpender{
            dola_chain_id : arg3,
            dola_contract : arg4,
        };
        0x2::event::emit<DeleteSpender>(v0);
    }

    public fun remote_register_owner(arg0: &0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::genesis::GovernanceCap, arg1: &mut 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg2: &mut CoreState, arg3: u16, arg4: u256, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: &0x2::clock::Clock) {
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::publish_message::publish_message(arg1, arg5, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::publish_message::prepare_message(&mut arg2.wormhole_emitter, 0, 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::pool_codec::encode_manage_pool_payload(arg3, arg4, 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::pool_codec::get_register_owner_type())), arg6);
        let v0 = RegisterOwner{
            dola_chain_id : arg3,
            dola_contract : arg4,
        };
        0x2::event::emit<RegisterOwner>(v0);
    }

    public fun remote_register_spender(arg0: &0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::genesis::GovernanceCap, arg1: &mut 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg2: &mut CoreState, arg3: u16, arg4: u256, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: &0x2::clock::Clock) {
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::publish_message::publish_message(arg1, arg5, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::publish_message::prepare_message(&mut arg2.wormhole_emitter, 0, 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::pool_codec::encode_manage_pool_payload(arg3, arg4, 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::pool_codec::get_register_spender_type())), arg6);
        let v0 = RegisterSpender{
            dola_chain_id : arg3,
            dola_contract : arg4,
        };
        0x2::event::emit<RegisterSpender>(v0);
    }

    public(friend) fun send_withdraw(arg0: &mut 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg1: &mut CoreState, arg2: &0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::app_manager::AppCap, arg3: &mut 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::pool_manager::PoolManagerInfo, arg4: 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::dola_address::DolaAddress, arg5: 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::dola_address::DolaAddress, arg6: u16, arg7: u64, arg8: u256, arg9: 0x2::coin::Coin<0x2::sui::SUI>, arg10: &0x2::clock::Clock) : u64 {
        let (v0, _) = 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::pool_manager::remove_liquidity(arg3, arg4, 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::app_manager::get_app_id(arg2), arg8);
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::publish_message::publish_message(arg0, arg9, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::publish_message::prepare_message(&mut arg1.wormhole_emitter, 0, 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::pool_codec::encode_withdraw_payload(arg6, arg7, arg4, arg5, (v0 as u64))), arg10)
    }

    // decompiled from Move bytecode v6
}

