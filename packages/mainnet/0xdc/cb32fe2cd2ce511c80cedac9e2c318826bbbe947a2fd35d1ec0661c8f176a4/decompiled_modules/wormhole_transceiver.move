module 0xdccb32fe2cd2ce511c80cedac9e2c318826bbbe947a2fd35d1ec0661c8f176a4::wormhole_transceiver {
    struct TransceiverAuth has drop {
        dummy_field: bool,
    }

    struct State<phantom T0> has store, key {
        id: 0x2::object::UID,
        peers: 0x2::table::Table<u16, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::ExternalAddress>,
        emitter_cap: 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::emitter::EmitterCap,
        admin_cap_id: 0x2::object::ID,
    }

    struct DeployerCap has store, key {
        id: 0x2::object::UID,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    public(friend) fun new<T0>(arg0: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg1: &mut 0x2::tx_context::TxContext) : (State<T0>, AdminCap) {
        assert!(0xdde97224defcb042ed4396ed5a93027c479e9008f80284ec81d8b4cff2e9d805::contract_auth::is_auth_type<T0>(b"ManagerAuth"), 13906834311782334463);
        let v0 = AdminCap{id: 0x2::object::new(arg1)};
        let v1 = State<T0>{
            id           : 0x2::object::new(arg1),
            peers        : 0x2::table::new<u16, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::ExternalAddress>(arg1),
            emitter_cap  : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::emitter::new(arg0, arg1),
            admin_cap_id : 0x2::object::uid_to_inner(&v0.id),
        };
        (v1, v0)
    }

    public fun broadcast_id<T0, T1>(arg0: &AdminCap, arg1: &0x2::coin::CoinMetadata<T0>, arg2: &mut State<T1>, arg3: &0xd38e527d4026206f92479bd647aa5af990325fbc179e06180dea960e343d0df1::state::State<T0>) : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::publish_message::MessageTicket {
        let v0 = 0xdde97224defcb042ed4396ed5a93027c479e9008f80284ec81d8b4cff2e9d805::contract_auth::get_auth_address<T1>(b"ManagerAuth");
        let v1 = 0xdccb32fe2cd2ce511c80cedac9e2c318826bbbe947a2fd35d1ec0661c8f176a4::wormhole_transceiver_info::new(0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::from_address(0x1::option::extract<address>(&mut v0)), *0xd38e527d4026206f92479bd647aa5af990325fbc179e06180dea960e343d0df1::state::borrow_mode<T0>(arg3), 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::from_id(0x2::object::id<0x2::coin::CoinMetadata<T0>>(arg1)), 0x2::coin::get_decimals<T0>(arg1));
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::publish_message::prepare_message(&mut arg2.emitter_cap, 0, 0xdccb32fe2cd2ce511c80cedac9e2c318826bbbe947a2fd35d1ec0661c8f176a4::wormhole_transceiver_info::to_bytes(&v1))
    }

    fun broadcast_peer<T0>(arg0: u16, arg1: 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::ExternalAddress, arg2: &mut State<T0>) : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::publish_message::MessageTicket {
        let v0 = 0xdccb32fe2cd2ce511c80cedac9e2c318826bbbe947a2fd35d1ec0661c8f176a4::wormhole_transceiver_registration::new(arg0, arg1);
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::publish_message::prepare_message(&mut arg2.emitter_cap, 0, 0xdccb32fe2cd2ce511c80cedac9e2c318826bbbe947a2fd35d1ec0661c8f176a4::wormhole_transceiver_registration::to_bytes(&v0))
    }

    public fun complete<T0>(arg0: DeployerCap, arg1: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg2: &mut 0x2::tx_context::TxContext) : AdminCap {
        let DeployerCap { id: v0 } = arg0;
        0x2::object::delete(v0);
        let (v1, v2) = new<T0>(arg1, arg2);
        0x2::transfer::public_share_object<State<T0>>(v1);
        v2
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = DeployerCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<DeployerCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun prefix() : 0xdde97224defcb042ed4396ed5a93027c479e9008f80284ec81d8b4cff2e9d805::transceiver_message::PrefixOf<TransceiverAuth> {
        let v0 = TransceiverAuth{dummy_field: false};
        0xdde97224defcb042ed4396ed5a93027c479e9008f80284ec81d8b4cff2e9d805::transceiver_message::prefix<TransceiverAuth>(&v0, 0xdde97224defcb042ed4396ed5a93027c479e9008f80284ec81d8b4cff2e9d805::bytes4::new(x"9945ff10"))
    }

    public fun release_outbound<T0>(arg0: &mut State<T0>, arg1: 0xdde97224defcb042ed4396ed5a93027c479e9008f80284ec81d8b4cff2e9d805::outbound_message::OutboundMessage<T0, TransceiverAuth>) : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::publish_message::MessageTicket {
        let v0 = TransceiverAuth{dummy_field: false};
        let (v1, v2, v3) = 0xdde97224defcb042ed4396ed5a93027c479e9008f80284ec81d8b4cff2e9d805::outbound_message::unwrap_outbound_message<T0, TransceiverAuth>(arg1, &v0);
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::publish_message::prepare_message(&mut arg0.emitter_cap, 0, 0xdde97224defcb042ed4396ed5a93027c479e9008f80284ec81d8b4cff2e9d805::transceiver_message::to_bytes<TransceiverAuth>(0xdde97224defcb042ed4396ed5a93027c479e9008f80284ec81d8b4cff2e9d805::transceiver_message::new<TransceiverAuth, vector<u8>>(0xdde97224defcb042ed4396ed5a93027c479e9008f80284ec81d8b4cff2e9d805::transceiver_message_data::new<vector<u8>>(v2, v3, v1), b""), prefix()))
    }

    public fun set_peer<T0>(arg0: &AdminCap, arg1: &mut State<T0>, arg2: u16, arg3: 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::ExternalAddress) : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::publish_message::MessageTicket {
        assert!(!0x2::table::contains<u16, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::ExternalAddress>(&arg1.peers, arg2), 13906834694034423807);
        0x2::table::add<u16, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::ExternalAddress>(&mut arg1.peers, arg2, arg3);
        broadcast_peer<T0>(arg2, arg3, arg1)
    }

    public fun validate_message<T0>(arg0: &State<T0>, arg1: 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::VAA) : 0xdde97224defcb042ed4396ed5a93027c479e9008f80284ec81d8b4cff2e9d805::validated_transceiver_message::ValidatedTransceiverMessage<TransceiverAuth, vector<u8>> {
        let (v0, v1, v2) = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::take_emitter_info_and_payload(arg1);
        let v3 = v1;
        assert!(0x2::table::borrow<u16, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::ExternalAddress>(&arg0.peers, v0) == &v3, 13906834599545143295);
        let (v4, _) = 0xdde97224defcb042ed4396ed5a93027c479e9008f80284ec81d8b4cff2e9d805::transceiver_message::destruct<TransceiverAuth, vector<u8>>(0xdde97224defcb042ed4396ed5a93027c479e9008f80284ec81d8b4cff2e9d805::transceiver_message::parse<TransceiverAuth>(prefix(), v2));
        let v6 = TransceiverAuth{dummy_field: false};
        0xdde97224defcb042ed4396ed5a93027c479e9008f80284ec81d8b4cff2e9d805::validated_transceiver_message::new<TransceiverAuth, vector<u8>>(&v6, v0, v4)
    }

    // decompiled from Move bytecode v6
}

