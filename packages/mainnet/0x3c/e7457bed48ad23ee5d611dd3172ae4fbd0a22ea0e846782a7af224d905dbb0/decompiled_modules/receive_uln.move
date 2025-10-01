module 0x3ce7457bed48ad23ee5d611dd3172ae4fbd0a22ea0e846782a7af224d905dbb0::receive_uln {
    struct ReceiveUln has store {
        default_uln_configs: 0x2::table::Table<u32, 0x3ce7457bed48ad23ee5d611dd3172ae4fbd0a22ea0e846782a7af224d905dbb0::uln_config::UlnConfig>,
        oapp_uln_configs: 0x2::table::Table<OAppConfigKey, 0x3ce7457bed48ad23ee5d611dd3172ae4fbd0a22ea0e846782a7af224d905dbb0::oapp_uln_config::OAppUlnConfig>,
        verification: address,
    }

    struct OAppConfigKey has copy, drop, store {
        receiver: address,
        src_eid: u32,
    }

    struct Verification has key {
        id: 0x2::object::UID,
        confirmations: 0x2::table::Table<ConfirmationKey, u64>,
    }

    struct ConfirmationKey has copy, drop, store {
        header_hash: 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32,
        payload_hash: 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32,
        dvn: address,
    }

    struct PayloadVerifiedEvent has copy, drop {
        dvn: address,
        header: vector<u8>,
        confirmations: u64,
        proof_hash: 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32,
    }

    struct DefaultUlnConfigSetEvent has copy, drop {
        src_eid: u32,
        config: 0x3ce7457bed48ad23ee5d611dd3172ae4fbd0a22ea0e846782a7af224d905dbb0::uln_config::UlnConfig,
    }

    struct UlnConfigSetEvent has copy, drop {
        receiver: address,
        src_eid: u32,
        config: 0x3ce7457bed48ad23ee5d611dd3172ae4fbd0a22ea0e846782a7af224d905dbb0::oapp_uln_config::OAppUlnConfig,
    }

    public(friend) fun get_confirmations(arg0: &Verification, arg1: address, arg2: 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32, arg3: 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32) : u64 {
        let v0 = ConfirmationKey{
            header_hash  : arg2,
            payload_hash : arg3,
            dvn          : arg1,
        };
        let v1 = &arg0.confirmations;
        assert!(0x2::table::contains<ConfirmationKey, u64>(v1, v0), 1);
        *0x2::table::borrow<ConfirmationKey, u64>(v1, v0)
    }

    public(friend) fun get_default_uln_config(arg0: &ReceiveUln, arg1: u32) : &0x3ce7457bed48ad23ee5d611dd3172ae4fbd0a22ea0e846782a7af224d905dbb0::uln_config::UlnConfig {
        let v0 = &arg0.default_uln_configs;
        assert!(0x2::table::contains<u32, 0x3ce7457bed48ad23ee5d611dd3172ae4fbd0a22ea0e846782a7af224d905dbb0::uln_config::UlnConfig>(v0, arg1), 2);
        0x2::table::borrow<u32, 0x3ce7457bed48ad23ee5d611dd3172ae4fbd0a22ea0e846782a7af224d905dbb0::uln_config::UlnConfig>(v0, arg1)
    }

    public(friend) fun get_effective_uln_config(arg0: &ReceiveUln, arg1: address, arg2: u32) : 0x3ce7457bed48ad23ee5d611dd3172ae4fbd0a22ea0e846782a7af224d905dbb0::uln_config::UlnConfig {
        let v0 = &arg0.oapp_uln_configs;
        let v1 = OAppConfigKey{
            receiver : arg1,
            src_eid  : arg2,
        };
        let v2 = if (0x2::table::contains<OAppConfigKey, 0x3ce7457bed48ad23ee5d611dd3172ae4fbd0a22ea0e846782a7af224d905dbb0::oapp_uln_config::OAppUlnConfig>(v0, v1)) {
            let v3 = OAppConfigKey{
                receiver : arg1,
                src_eid  : arg2,
            };
            0x2::table::borrow<OAppConfigKey, 0x3ce7457bed48ad23ee5d611dd3172ae4fbd0a22ea0e846782a7af224d905dbb0::oapp_uln_config::OAppUlnConfig>(v0, v3)
        } else {
            let v4 = 0x3ce7457bed48ad23ee5d611dd3172ae4fbd0a22ea0e846782a7af224d905dbb0::oapp_uln_config::new();
            &v4
        };
        0x3ce7457bed48ad23ee5d611dd3172ae4fbd0a22ea0e846782a7af224d905dbb0::oapp_uln_config::get_effective_config(v2, get_default_uln_config(arg0, arg2))
    }

    public(friend) fun get_oapp_uln_config(arg0: &ReceiveUln, arg1: address, arg2: u32) : &0x3ce7457bed48ad23ee5d611dd3172ae4fbd0a22ea0e846782a7af224d905dbb0::oapp_uln_config::OAppUlnConfig {
        let v0 = &arg0.oapp_uln_configs;
        let v1 = OAppConfigKey{
            receiver : arg1,
            src_eid  : arg2,
        };
        assert!(0x2::table::contains<OAppConfigKey, 0x3ce7457bed48ad23ee5d611dd3172ae4fbd0a22ea0e846782a7af224d905dbb0::oapp_uln_config::OAppUlnConfig>(v0, v1), 4);
        let v2 = OAppConfigKey{
            receiver : arg1,
            src_eid  : arg2,
        };
        0x2::table::borrow<OAppConfigKey, 0x3ce7457bed48ad23ee5d611dd3172ae4fbd0a22ea0e846782a7af224d905dbb0::oapp_uln_config::OAppUlnConfig>(v0, v2)
    }

    public(friend) fun get_verification(arg0: &ReceiveUln) : address {
        arg0.verification
    }

    public(friend) fun is_supported_eid(arg0: &ReceiveUln, arg1: u32) : bool {
        0x2::table::contains<u32, 0x3ce7457bed48ad23ee5d611dd3172ae4fbd0a22ea0e846782a7af224d905dbb0::uln_config::UlnConfig>(&arg0.default_uln_configs, arg1)
    }

    public(friend) fun new_receive_uln(arg0: &mut 0x2::tx_context::TxContext) : ReceiveUln {
        let v0 = Verification{
            id            : 0x2::object::new(arg0),
            confirmations : 0x2::table::new<ConfirmationKey, u64>(arg0),
        };
        0x2::transfer::share_object<Verification>(v0);
        ReceiveUln{
            default_uln_configs : 0x2::table::new<u32, 0x3ce7457bed48ad23ee5d611dd3172ae4fbd0a22ea0e846782a7af224d905dbb0::uln_config::UlnConfig>(arg0),
            oapp_uln_configs    : 0x2::table::new<OAppConfigKey, 0x3ce7457bed48ad23ee5d611dd3172ae4fbd0a22ea0e846782a7af224d905dbb0::oapp_uln_config::OAppUlnConfig>(arg0),
            verification        : 0x2::object::id_address<Verification>(&v0),
        }
    }

    public(friend) fun set_default_uln_config(arg0: &mut ReceiveUln, arg1: u32, arg2: 0x3ce7457bed48ad23ee5d611dd3172ae4fbd0a22ea0e846782a7af224d905dbb0::uln_config::UlnConfig) {
        0x3ce7457bed48ad23ee5d611dd3172ae4fbd0a22ea0e846782a7af224d905dbb0::uln_config::assert_default_config(&arg2);
        let v0 = &mut arg0.default_uln_configs;
        if (0x2::table::contains<u32, 0x3ce7457bed48ad23ee5d611dd3172ae4fbd0a22ea0e846782a7af224d905dbb0::uln_config::UlnConfig>(v0, arg1)) {
            *0x2::table::borrow_mut<u32, 0x3ce7457bed48ad23ee5d611dd3172ae4fbd0a22ea0e846782a7af224d905dbb0::uln_config::UlnConfig>(v0, arg1) = arg2;
        } else {
            0x2::table::add<u32, 0x3ce7457bed48ad23ee5d611dd3172ae4fbd0a22ea0e846782a7af224d905dbb0::uln_config::UlnConfig>(v0, arg1, arg2);
        };
        let v1 = DefaultUlnConfigSetEvent{
            src_eid : arg1,
            config  : arg2,
        };
        0x2::event::emit<DefaultUlnConfigSetEvent>(v1);
    }

    public(friend) fun set_uln_config(arg0: &mut ReceiveUln, arg1: address, arg2: u32, arg3: 0x3ce7457bed48ad23ee5d611dd3172ae4fbd0a22ea0e846782a7af224d905dbb0::oapp_uln_config::OAppUlnConfig) {
        0x3ce7457bed48ad23ee5d611dd3172ae4fbd0a22ea0e846782a7af224d905dbb0::oapp_uln_config::assert_oapp_config(&arg3);
        0x3ce7457bed48ad23ee5d611dd3172ae4fbd0a22ea0e846782a7af224d905dbb0::oapp_uln_config::get_effective_config(&arg3, get_default_uln_config(arg0, arg2));
        let v0 = &mut arg0.oapp_uln_configs;
        let v1 = OAppConfigKey{
            receiver : arg1,
            src_eid  : arg2,
        };
        if (0x2::table::contains<OAppConfigKey, 0x3ce7457bed48ad23ee5d611dd3172ae4fbd0a22ea0e846782a7af224d905dbb0::oapp_uln_config::OAppUlnConfig>(v0, v1)) {
            let v2 = OAppConfigKey{
                receiver : arg1,
                src_eid  : arg2,
            };
            *0x2::table::borrow_mut<OAppConfigKey, 0x3ce7457bed48ad23ee5d611dd3172ae4fbd0a22ea0e846782a7af224d905dbb0::oapp_uln_config::OAppUlnConfig>(v0, v2) = arg3;
        } else {
            let v3 = OAppConfigKey{
                receiver : arg1,
                src_eid  : arg2,
            };
            0x2::table::add<OAppConfigKey, 0x3ce7457bed48ad23ee5d611dd3172ae4fbd0a22ea0e846782a7af224d905dbb0::oapp_uln_config::OAppUlnConfig>(v0, v3, arg3);
        };
        let v4 = UlnConfigSetEvent{
            receiver : arg1,
            src_eid  : arg2,
            config   : arg3,
        };
        0x2::event::emit<UlnConfigSetEvent>(v4);
    }

    public(friend) fun verifiable(arg0: &ReceiveUln, arg1: &Verification, arg2: u32, arg3: vector<u8>, arg4: 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32) : bool {
        let v0 = 0x9de6d60206bfbc7b6f4c898b7d7c12dc749973098a9c346bca9d0cfa365be0d3::packet_v1_codec::decode_header(arg3);
        assert!(0x9de6d60206bfbc7b6f4c898b7d7c12dc749973098a9c346bca9d0cfa365be0d3::packet_v1_codec::dst_eid(&v0) == arg2, 3);
        let v1 = 0x9de6d60206bfbc7b6f4c898b7d7c12dc749973098a9c346bca9d0cfa365be0d3::packet_v1_codec::receiver(&v0);
        let v2 = get_effective_uln_config(arg0, 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::to_address(&v1), 0x9de6d60206bfbc7b6f4c898b7d7c12dc749973098a9c346bca9d0cfa365be0d3::packet_v1_codec::src_eid(&v0));
        verifiable_internal(arg1, &v2, 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::from_bytes(0x2::hash::keccak256(&arg3)), arg4)
    }

    fun verifiable_internal(arg0: &Verification, arg1: &0x3ce7457bed48ad23ee5d611dd3172ae4fbd0a22ea0e846782a7af224d905dbb0::uln_config::UlnConfig, arg2: 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32, arg3: 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32) : bool {
        let v0 = 0x3ce7457bed48ad23ee5d611dd3172ae4fbd0a22ea0e846782a7af224d905dbb0::uln_config::required_dvns(arg1);
        let v1 = 0x3ce7457bed48ad23ee5d611dd3172ae4fbd0a22ea0e846782a7af224d905dbb0::uln_config::optional_dvns(arg1);
        let v2 = (0x3ce7457bed48ad23ee5d611dd3172ae4fbd0a22ea0e846782a7af224d905dbb0::uln_config::optional_dvn_threshold(arg1) as u64);
        let v3 = 0x3ce7457bed48ad23ee5d611dd3172ae4fbd0a22ea0e846782a7af224d905dbb0::uln_config::confirmations(arg1);
        if (0x1::vector::length<address>(v0) > 0) {
            let v4 = 0;
            while (v4 < 0x1::vector::length<address>(v0)) {
                if (!verified(arg0, *0x1::vector::borrow<address>(v0, v4), arg2, arg3, v3)) {
                    if (!false) {
                        return false
                    };
                    if (v2 == 0) {
                        return true
                    };
                    /* goto 14 */
                } else {
                    /* goto 23 */
                };
            };
        };
        /* label 14 */
        let v5 = 0;
        let v6 = 0;
        while (v5 < 0x1::vector::length<address>(v1)) {
            if (verified(arg0, *0x1::vector::borrow<address>(v1, v5), arg2, arg3, v3)) {
                let v7 = v6 + 1;
                v6 = v7;
                if (v7 >= v2) {
                    return true
                };
            };
            v5 = v5 + 1;
        };
        false
    }

    fun verified(arg0: &Verification, arg1: address, arg2: 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32, arg3: 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32, arg4: u64) : bool {
        let v0 = ConfirmationKey{
            header_hash  : arg2,
            payload_hash : arg3,
            dvn          : arg1,
        };
        0x2::table::contains<ConfirmationKey, u64>(&arg0.confirmations, v0) && *0x2::table::borrow<ConfirmationKey, u64>(&arg0.confirmations, v0) >= arg4
    }

    public(friend) fun verify(arg0: &mut Verification, arg1: address, arg2: vector<u8>, arg3: 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32, arg4: u64) {
        let v0 = &mut arg0.confirmations;
        let v1 = ConfirmationKey{
            header_hash  : 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::from_bytes(0x2::hash::keccak256(&arg2)),
            payload_hash : arg3,
            dvn          : arg1,
        };
        if (0x2::table::contains<ConfirmationKey, u64>(v0, v1)) {
            let v2 = ConfirmationKey{
                header_hash  : 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::from_bytes(0x2::hash::keccak256(&arg2)),
                payload_hash : arg3,
                dvn          : arg1,
            };
            *0x2::table::borrow_mut<ConfirmationKey, u64>(v0, v2) = arg4;
        } else {
            let v3 = ConfirmationKey{
                header_hash  : 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::from_bytes(0x2::hash::keccak256(&arg2)),
                payload_hash : arg3,
                dvn          : arg1,
            };
            0x2::table::add<ConfirmationKey, u64>(v0, v3, arg4);
        };
        let v4 = PayloadVerifiedEvent{
            dvn           : arg1,
            header        : arg2,
            confirmations : arg4,
            proof_hash    : arg3,
        };
        0x2::event::emit<PayloadVerifiedEvent>(v4);
    }

    public(friend) fun verify_and_reclaim_storage(arg0: &ReceiveUln, arg1: &mut Verification, arg2: u32, arg3: vector<u8>, arg4: 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32) : 0x9de6d60206bfbc7b6f4c898b7d7c12dc749973098a9c346bca9d0cfa365be0d3::packet_v1_codec::PacketHeader {
        let v0 = 0x9de6d60206bfbc7b6f4c898b7d7c12dc749973098a9c346bca9d0cfa365be0d3::packet_v1_codec::decode_header(arg3);
        assert!(0x9de6d60206bfbc7b6f4c898b7d7c12dc749973098a9c346bca9d0cfa365be0d3::packet_v1_codec::dst_eid(&v0) == arg2, 3);
        let v1 = 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::from_bytes(0x2::hash::keccak256(&arg3));
        let v2 = 0x9de6d60206bfbc7b6f4c898b7d7c12dc749973098a9c346bca9d0cfa365be0d3::packet_v1_codec::receiver(&v0);
        let v3 = get_effective_uln_config(arg0, 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::to_address(&v2), 0x9de6d60206bfbc7b6f4c898b7d7c12dc749973098a9c346bca9d0cfa365be0d3::packet_v1_codec::src_eid(&v0));
        assert!(verifiable_internal(arg1, &v3, v1, arg4), 5);
        let v4 = 0x3ce7457bed48ad23ee5d611dd3172ae4fbd0a22ea0e846782a7af224d905dbb0::uln_config::required_dvns(&v3);
        let v5 = 0;
        while (v5 < 0x1::vector::length<address>(v4)) {
            let v6 = ConfirmationKey{
                header_hash  : v1,
                payload_hash : arg4,
                dvn          : *0x1::vector::borrow<address>(v4, v5),
            };
            0x2::table::remove<ConfirmationKey, u64>(&mut arg1.confirmations, v6);
            v5 = v5 + 1;
        };
        let v7 = 0x3ce7457bed48ad23ee5d611dd3172ae4fbd0a22ea0e846782a7af224d905dbb0::uln_config::optional_dvns(&v3);
        let v8 = 0;
        while (v8 < 0x1::vector::length<address>(v7)) {
            let v9 = 0x1::vector::borrow<address>(v7, v8);
            let v10 = &mut arg1.confirmations;
            let v11 = ConfirmationKey{
                header_hash  : v1,
                payload_hash : arg4,
                dvn          : *v9,
            };
            if (0x2::table::contains<ConfirmationKey, u64>(v10, v11)) {
                let _ = ConfirmationKey{
                    header_hash  : v1,
                    payload_hash : arg4,
                    dvn          : *v9,
                };
            };
            v8 = v8 + 1;
        };
        v0
    }

    // decompiled from Move bytecode v6
}

