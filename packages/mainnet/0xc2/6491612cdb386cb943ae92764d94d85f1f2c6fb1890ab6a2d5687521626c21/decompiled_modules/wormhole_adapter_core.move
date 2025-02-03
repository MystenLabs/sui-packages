module 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::wormhole_adapter_core {
    struct CoreState has store, key {
        id: 0x2::object::UID,
        wormhole_emitter: 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::emitter::EmitterCap,
        consumed_vaas: 0x2::object_table::ObjectTable<0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes32::Bytes32, 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::wormhole_adapter_verify::Unit>,
        registered_emitters: 0x2::vec_map::VecMap<u16, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::ExternalAddress>,
    }

    struct Relayer has copy, drop, store {
        dummy_field: bool,
    }

    struct VaaExpiredTime has copy, drop, store {
        dummy_field: bool,
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

    struct AddRelayer has copy, drop {
        new_relayer: address,
    }

    struct RemoveRelayer has copy, drop {
        removed_relayer: address,
    }

    public fun add_relayer(arg0: &0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::genesis::GovernanceCap, arg1: &mut CoreState, arg2: address) {
        let v0 = Relayer{dummy_field: false};
        if (0x2::dynamic_field::exists_with_type<Relayer, vector<address>>(&mut arg1.id, v0)) {
            let v1 = Relayer{dummy_field: false};
            let v2 = 0x2::dynamic_field::borrow_mut<Relayer, vector<address>>(&mut arg1.id, v1);
            assert!(!0x1::vector::contains<address>(v2, &arg2), 3);
            0x1::vector::push_back<address>(v2, arg2);
        } else {
            let v3 = Relayer{dummy_field: false};
            let v4 = 0x1::vector::empty<address>();
            0x1::vector::push_back<address>(&mut v4, arg2);
            0x2::dynamic_field::add<Relayer, vector<address>>(&mut arg1.id, v3, v4);
        };
        let v5 = AddRelayer{new_relayer: arg2};
        0x2::event::emit<AddRelayer>(v5);
    }

    fun check_relayer(arg0: &mut CoreState, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Relayer{dummy_field: false};
        assert!(0x2::dynamic_field::exists_with_type<Relayer, vector<address>>(&mut arg0.id, v0), 5);
        let v1 = Relayer{dummy_field: false};
        let v2 = 0x2::tx_context::sender(arg1);
        assert!(0x1::vector::contains<address>(0x2::dynamic_field::borrow<Relayer, vector<address>>(&mut arg0.id, v1), &v2), 4);
    }

    fun check_vaa_expired_time(arg0: &mut CoreState, arg1: u64, arg2: &0x2::clock::Clock) {
        let v0 = 3600;
        let v1 = VaaExpiredTime{dummy_field: false};
        if (0x2::dynamic_field::exists_with_type<VaaExpiredTime, u64>(&mut arg0.id, v1)) {
            let v2 = VaaExpiredTime{dummy_field: false};
            v0 = *0x2::dynamic_field::borrow<VaaExpiredTime, u64>(&mut arg0.id, v2);
        };
        assert!(arg1 + v0 < 0x2::clock::timestamp_ms(arg2) / 1000, 7);
    }

    public fun delete_remote_bridge(arg0: &0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::genesis::GovernanceCap, arg1: &mut CoreState, arg2: u16) {
        assert!(0x2::vec_map::contains<u16, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::ExternalAddress>(&arg1.registered_emitters, &arg2), 0);
        let (_, v1) = 0x2::vec_map::remove<u16, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::ExternalAddress>(&mut arg1.registered_emitters, &arg2);
        let v2 = RegisterBridge{
            wormhole_emitter_chain   : arg2,
            wormhole_emitter_address : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::to_bytes(v1),
        };
        0x2::event::emit<RegisterBridge>(v2);
    }

    public fun initialize_cap_with_governance(arg0: &0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::genesis::GovernanceCap, arg1: &mut 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = CoreState{
            id                  : 0x2::object::new(arg2),
            wormhole_emitter    : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::emitter::new(arg1, arg2),
            consumed_vaas       : 0x2::object_table::new<0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes32::Bytes32, 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::wormhole_adapter_verify::Unit>(arg2),
            registered_emitters : 0x2::vec_map::empty<u16, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::ExternalAddress>(),
        };
        0x2::transfer::public_share_object<CoreState>(v0);
    }

    public(friend) fun receive_deposit(arg0: &mut 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg1: &mut CoreState, arg2: &0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::app_manager::AppCap, arg3: vector<u8>, arg4: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::pool_manager::PoolManagerInfo, arg5: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::user_manager::UserManagerInfo, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::dola_address::DolaAddress, 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::dola_address::DolaAddress, u256, vector<u8>) {
        check_relayer(arg1, arg7);
        let (v0, v1, v2, v3, _, v5) = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::pool_codec::decode_deposit_payload(0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::take_payload(0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::wormhole_adapter_verify::parse_verify_and_replay_protect(arg0, &arg1.registered_emitters, &mut arg1.consumed_vaas, arg3, arg6, arg7)));
        assert!(0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::app_manager::get_app_id(arg2) == v3, 2);
        let (v6, _) = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::pool_manager::add_liquidity(arg4, v0, 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::app_manager::get_app_id(arg2), (v2 as u256));
        if (!0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::user_manager::is_dola_user(arg5, v1)) {
            0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::user_manager::register_dola_user_id(arg5, v1);
        };
        (v0, v1, v6, v5)
    }

    public(friend) fun receive_message(arg0: &mut 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg1: &mut CoreState, arg2: &0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::app_manager::AppCap, arg3: vector<u8>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::dola_address::DolaAddress, vector<u8>) {
        check_relayer(arg1, arg5);
        let (v0, v1, _, v3) = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::pool_codec::decode_send_message_payload(0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::take_payload(0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::wormhole_adapter_verify::parse_verify_and_replay_protect(arg0, &arg1.registered_emitters, &mut arg1.consumed_vaas, arg3, arg4, arg5)));
        assert!(0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::app_manager::get_app_id(arg2) == v1, 2);
        (v0, v3)
    }

    public(friend) fun receive_withdraw(arg0: &mut 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg1: &mut CoreState, arg2: &0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::app_manager::AppCap, arg3: vector<u8>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::dola_address::DolaAddress, vector<u8>) {
        check_relayer(arg1, arg5);
        let v0 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::wormhole_adapter_verify::parse_verify_and_replay_protect(arg0, &arg1.registered_emitters, &mut arg1.consumed_vaas, arg3, arg4, arg5);
        check_vaa_expired_time(arg1, (0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::timestamp(&v0) as u64), arg4);
        let (v1, v2, _, v4) = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::pool_codec::decode_send_message_payload(0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::take_payload(v0));
        assert!(0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::app_manager::get_app_id(arg2) == v2, 2);
        (v1, v4)
    }

    public fun register_remote_bridge(arg0: &0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::genesis::GovernanceCap, arg1: &mut CoreState, arg2: u16, arg3: vector<u8>) {
        assert!(!0x2::vec_map::contains<u16, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::ExternalAddress>(&arg1.registered_emitters, &arg2), 1);
        0x2::vec_map::insert<u16, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::ExternalAddress>(&mut arg1.registered_emitters, arg2, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::new(0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes32::new(arg3)));
        let v0 = RegisterBridge{
            wormhole_emitter_chain   : arg2,
            wormhole_emitter_address : arg3,
        };
        0x2::event::emit<RegisterBridge>(v0);
    }

    public fun remote_add_relayer(arg0: &0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::genesis::GovernanceCap, arg1: &mut 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg2: &mut CoreState, arg3: u16, arg4: vector<u8>, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: &0x2::clock::Clock) {
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::publish_message::publish_message(arg1, arg5, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::publish_message::prepare_message(&mut arg2.wormhole_emitter, 0, 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::remote_gov_codec::encode_relayer_payload(0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::dola_address::create_dola_address(arg3, arg4), 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::remote_gov_codec::get_add_relayer_opcode())), arg6);
    }

    public fun remote_delete_owner(arg0: &0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::genesis::GovernanceCap, arg1: &mut 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg2: &mut CoreState, arg3: u16, arg4: u256, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: &0x2::clock::Clock) {
        abort 0
    }

    public fun remote_delete_spender(arg0: &0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::genesis::GovernanceCap, arg1: &mut 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg2: &mut CoreState, arg3: u16, arg4: u256, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: &0x2::clock::Clock) {
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::publish_message::publish_message(arg1, arg5, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::publish_message::prepare_message(&mut arg2.wormhole_emitter, 0, 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::pool_codec::encode_manage_pool_payload(arg3, arg4, 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::pool_codec::get_delete_spender_type())), arg6);
        let v0 = DeleteSpender{
            dola_chain_id : arg3,
            dola_contract : arg4,
        };
        0x2::event::emit<DeleteSpender>(v0);
    }

    public fun remote_register_owner(arg0: &0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::genesis::GovernanceCap, arg1: &mut 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg2: &mut CoreState, arg3: u16, arg4: u256, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: &0x2::clock::Clock) {
        abort 0
    }

    public fun remote_register_spender(arg0: &0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::genesis::GovernanceCap, arg1: &mut 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg2: &mut CoreState, arg3: u16, arg4: u256, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: &0x2::clock::Clock) {
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::publish_message::publish_message(arg1, arg5, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::publish_message::prepare_message(&mut arg2.wormhole_emitter, 0, 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::pool_codec::encode_manage_pool_payload(arg3, arg4, 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::pool_codec::get_register_spender_type())), arg6);
        let v0 = RegisterSpender{
            dola_chain_id : arg3,
            dola_contract : arg4,
        };
        0x2::event::emit<RegisterSpender>(v0);
    }

    public fun remote_remove_relayer(arg0: &0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::genesis::GovernanceCap, arg1: &mut 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg2: &mut CoreState, arg3: u16, arg4: vector<u8>, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: &0x2::clock::Clock) {
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::publish_message::publish_message(arg1, arg5, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::publish_message::prepare_message(&mut arg2.wormhole_emitter, 0, 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::remote_gov_codec::encode_relayer_payload(0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::dola_address::create_dola_address(arg3, arg4), 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::remote_gov_codec::get_remove_relayer_opcode())), arg6);
    }

    public fun remove_relayer(arg0: &0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::genesis::GovernanceCap, arg1: &mut CoreState, arg2: address) {
        let v0 = Relayer{dummy_field: false};
        assert!(0x2::dynamic_field::exists_with_type<Relayer, vector<address>>(&mut arg1.id, v0), 5);
        let v1 = Relayer{dummy_field: false};
        let v2 = 0x2::dynamic_field::borrow_mut<Relayer, vector<address>>(&mut arg1.id, v1);
        assert!(0x1::vector::contains<address>(v2, &arg2), 6);
        let (_, v4) = 0x1::vector::index_of<address>(v2, &arg2);
        0x1::vector::remove<address>(v2, v4);
        let v5 = RemoveRelayer{removed_relayer: arg2};
        0x2::event::emit<RemoveRelayer>(v5);
    }

    public(friend) fun send_withdraw(arg0: &mut 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg1: &mut CoreState, arg2: &0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::app_manager::AppCap, arg3: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::pool_manager::PoolManagerInfo, arg4: 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::dola_address::DolaAddress, arg5: 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::dola_address::DolaAddress, arg6: u16, arg7: u64, arg8: u256, arg9: 0x2::coin::Coin<0x2::sui::SUI>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : u64 {
        check_relayer(arg1, arg11);
        let (v0, _) = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::pool_manager::remove_liquidity(arg3, arg4, 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::app_manager::get_app_id(arg2), arg8);
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::publish_message::publish_message(arg0, arg9, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::publish_message::prepare_message(&mut arg1.wormhole_emitter, 0, 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::pool_codec::encode_withdraw_payload(arg6, arg7, arg4, arg5, (v0 as u64))), arg10)
    }

    public fun set_vaa_expired_time(arg0: &0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::genesis::GovernanceCap, arg1: &mut CoreState, arg2: u64) {
        let v0 = VaaExpiredTime{dummy_field: false};
        if (0x2::dynamic_field::exists_with_type<VaaExpiredTime, u64>(&mut arg1.id, v0)) {
            let v1 = VaaExpiredTime{dummy_field: false};
            0x2::dynamic_field::remove<VaaExpiredTime, u64>(&mut arg1.id, v1);
        };
        let v2 = VaaExpiredTime{dummy_field: false};
        0x2::dynamic_field::add<VaaExpiredTime, u64>(&mut arg1.id, v2, arg2);
    }

    // decompiled from Move bytecode v6
}

