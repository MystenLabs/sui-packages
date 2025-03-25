module 0x588593045c2fec97272560b315fc12defb5ffc28c70a22f062de96cf900cb72c::wormhole_adapter {
    struct ForeignContracts has key {
        id: 0x2::object::UID,
        emitter_cap: 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::emitter::EmitterCap,
        foreign_contracts: 0x2::table::Table<u16, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::ExternalAddress>,
        admin: address,
    }

    struct LogBridgeTo has copy, drop {
        _adaptorId: u8,
        _from: address,
        _to: 0x1::string::String,
        _token: 0x1::string::String,
        _amount: u64,
        _orderId: 0x1::string::String,
        _toChainId: u32,
    }

    struct HelloTokenMessage has drop {
        recipient: 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::ExternalAddress,
    }

    public fun new(arg0: 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::ExternalAddress) : HelloTokenMessage {
        HelloTokenMessage{recipient: arg0}
    }

    public entry fun change_admin(arg0: &mut ForeignContracts, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 2);
        arg0.admin = arg1;
    }

    public fun deserialize(arg0: vector<u8>) : HelloTokenMessage {
        let v0 = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::new<u8>(arg0);
        assert!(0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::take_u8(&mut v0) == 1, 6);
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::destroy_empty<u8>(v0);
        HelloTokenMessage{recipient: 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::take_bytes(&mut v0)}
    }

    public fun get_contract_address(arg0: &ForeignContracts, arg1: u16) : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::ExternalAddress {
        assert!(0x2::table::contains<u16, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::ExternalAddress>(&arg0.foreign_contracts, arg1), 7);
        *0x2::table::borrow<u16, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::ExternalAddress>(&arg0.foreign_contracts, arg1)
    }

    public entry fun init_foreign_contracts(arg0: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = ForeignContracts{
            id                : 0x2::object::new(arg1),
            emitter_cap       : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::emitter::new(arg0, arg1),
            foreign_contracts : 0x2::table::new<u16, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::ExternalAddress>(arg1),
            admin             : 0x2::tx_context::sender(arg1),
        };
        0x2::transfer::share_object<ForeignContracts>(v0);
    }

    public fun redeem_transfer<T0>(arg0: &0x588593045c2fec97272560b315fc12defb5ffc28c70a22f062de96cf900cb72c::init::Version, arg1: 0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::complete_transfer::RelayerReceipt<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0x588593045c2fec97272560b315fc12defb5ffc28c70a22f062de96cf900cb72c::init::check_dexrouter_version(arg0);
        0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::coin_utils::return_nonzero<T0>(0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::complete_transfer::redeem_relayer_payout<T0>(arg1), arg2);
    }

    public entry fun register_or_update(arg0: &0x588593045c2fec97272560b315fc12defb5ffc28c70a22f062de96cf900cb72c::init::Version, arg1: &mut ForeignContracts, arg2: u16, arg3: address, arg4: &0x2::tx_context::TxContext) {
        0x588593045c2fec97272560b315fc12defb5ffc28c70a22f062de96cf900cb72c::init::check_dexrouter_version(arg0);
        assert!(0x2::tx_context::sender(arg4) == arg1.admin, 2);
        let v0 = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::from_address(arg3);
        assert!(arg2 != 0 && arg2 != 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::chain_id(), 0);
        assert!(0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::is_nonzero(&v0), 1);
        if (0x2::table::contains<u16, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::ExternalAddress>(&arg1.foreign_contracts, arg2)) {
            *0x2::table::borrow_mut<u16, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::ExternalAddress>(&mut arg1.foreign_contracts, arg2) = v0;
        } else {
            0x2::table::add<u16, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::ExternalAddress>(&mut arg1.foreign_contracts, arg2, v0);
        };
    }

    public fun send_tokens_with_payload<T0>(arg0: &0x588593045c2fec97272560b315fc12defb5ffc28c70a22f062de96cf900cb72c::init::Version, arg1: u8, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u32, arg5: &ForeignContracts, arg6: 0x2::coin::Coin<T0>, arg7: 0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::token_registry::VerifiedAsset<T0>, arg8: u16, arg9: address, arg10: u32, arg11: &0x2::tx_context::TxContext) : 0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::transfer_tokens_with_payload::TransferTicket<T0> {
        0x588593045c2fec97272560b315fc12defb5ffc28c70a22f062de96cf900cb72c::init::check_dexrouter_version(arg0);
        let v0 = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::from_address(arg9);
        assert!(0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::is_nonzero(&v0), 3);
        assert!(0x2::table::contains<u16, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::ExternalAddress>(&arg5.foreign_contracts, arg8), 4);
        let v1 = LogBridgeTo{
            _adaptorId : arg1,
            _from      : 0x2::tx_context::sender(arg11),
            _to        : 0x1::string::utf8(0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::to_bytes(v0)),
            _token     : arg2,
            _amount    : 0x2::coin::value<T0>(&arg6),
            _orderId   : arg3,
            _toChainId : arg4,
        };
        0x2::event::emit<LogBridgeTo>(v1);
        let v2 = 0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::token_registry::coin_decimals<T0>(&arg7);
        assert!(0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::normalized_amount::to_raw(0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::normalized_amount::from_raw(0x2::coin::value<T0>(&arg6), v2), v2) > 0, 5);
        let (v3, v4) = 0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::transfer_tokens_with_payload::prepare_transfer<T0>(&arg5.emitter_cap, arg7, arg6, arg8, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::to_bytes(get_contract_address(arg5, arg8)), serialize(new(v0)), arg10);
        0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::coin_utils::return_nonzero<T0>(v4, arg11);
        v3
    }

    public fun serialize(arg0: HelloTokenMessage) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::push_u8(&mut v0, 1);
        0x1::vector::append<u8>(&mut v0, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::to_bytes(arg0.recipient));
        v0
    }

    // decompiled from Move bytecode v6
}

