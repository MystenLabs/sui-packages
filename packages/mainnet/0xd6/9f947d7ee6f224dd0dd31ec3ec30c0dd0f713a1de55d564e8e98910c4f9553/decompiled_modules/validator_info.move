module 0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::validator_info {
    struct ValidatorInfo has store {
        name: 0x1::string::String,
        validator_id: 0x2::object::ID,
        network_address: 0x1::string::String,
        p2p_address: 0x1::string::String,
        consensus_address: 0x1::string::String,
        protocol_pubkey_bytes: vector<u8>,
        protocol_pubkey: 0x2::group_ops::Element<0x2::bls12381::UncompressedG1>,
        network_pubkey_bytes: vector<u8>,
        consensus_pubkey_bytes: vector<u8>,
        mpc_data_bytes: 0x1::option::Option<0x2::table_vec::TableVec<vector<u8>>>,
        next_epoch_protocol_pubkey_bytes: 0x1::option::Option<vector<u8>>,
        next_epoch_network_pubkey_bytes: 0x1::option::Option<vector<u8>>,
        next_epoch_consensus_pubkey_bytes: 0x1::option::Option<vector<u8>>,
        next_epoch_mpc_data_bytes: 0x1::option::Option<0x2::table_vec::TableVec<vector<u8>>>,
        next_epoch_network_address: 0x1::option::Option<0x1::string::String>,
        next_epoch_p2p_address: 0x1::option::Option<0x1::string::String>,
        next_epoch_consensus_address: 0x1::option::Option<0x1::string::String>,
        previous_mpc_data_bytes: 0x1::option::Option<0x2::table_vec::TableVec<vector<u8>>>,
        metadata: 0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::extended_field::ExtendedField<0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::validator_metadata::ValidatorMetadata>,
    }

    public(friend) fun destroy(arg0: ValidatorInfo) {
        let ValidatorInfo {
            name                              : _,
            validator_id                      : _,
            network_address                   : _,
            p2p_address                       : _,
            consensus_address                 : _,
            protocol_pubkey_bytes             : _,
            protocol_pubkey                   : _,
            network_pubkey_bytes              : _,
            consensus_pubkey_bytes            : _,
            mpc_data_bytes                    : v9,
            next_epoch_protocol_pubkey_bytes  : _,
            next_epoch_network_pubkey_bytes   : _,
            next_epoch_consensus_pubkey_bytes : _,
            next_epoch_mpc_data_bytes         : v13,
            next_epoch_network_address        : _,
            next_epoch_p2p_address            : _,
            next_epoch_consensus_address      : _,
            previous_mpc_data_bytes           : v17,
            metadata                          : v18,
        } = arg0;
        0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::extended_field::destroy<0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::validator_metadata::ValidatorMetadata>(v18);
        let v19 = v9;
        if (0x1::option::is_some<0x2::table_vec::TableVec<vector<u8>>>(&v19)) {
            let v20 = 0x1::option::destroy_some<0x2::table_vec::TableVec<vector<u8>>>(v19);
            while (0x2::table_vec::length<vector<u8>>(&v20) != 0) {
                0x2::table_vec::pop_back<vector<u8>>(&mut v20);
            };
            0x2::table_vec::destroy_empty<vector<u8>>(v20);
        } else {
            0x1::option::destroy_none<0x2::table_vec::TableVec<vector<u8>>>(v19);
        };
        let v21 = v13;
        if (0x1::option::is_some<0x2::table_vec::TableVec<vector<u8>>>(&v21)) {
            let v22 = 0x1::option::destroy_some<0x2::table_vec::TableVec<vector<u8>>>(v21);
            while (0x2::table_vec::length<vector<u8>>(&v22) != 0) {
                0x2::table_vec::pop_back<vector<u8>>(&mut v22);
            };
            0x2::table_vec::destroy_empty<vector<u8>>(v22);
        } else {
            0x1::option::destroy_none<0x2::table_vec::TableVec<vector<u8>>>(v21);
        };
        let v23 = v17;
        if (0x1::option::is_some<0x2::table_vec::TableVec<vector<u8>>>(&v23)) {
            let v24 = 0x1::option::destroy_some<0x2::table_vec::TableVec<vector<u8>>>(v23);
            while (0x2::table_vec::length<vector<u8>>(&v24) != 0) {
                0x2::table_vec::pop_back<vector<u8>>(&mut v24);
            };
            0x2::table_vec::destroy_empty<vector<u8>>(v24);
        } else {
            0x1::option::destroy_none<0x2::table_vec::TableVec<vector<u8>>>(v23);
        };
    }

    public(friend) fun new(arg0: 0x1::string::String, arg1: 0x2::object::ID, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: 0x2::table_vec::TableVec<vector<u8>>, arg6: vector<u8>, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: 0x1::string::String, arg10: 0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::validator_metadata::ValidatorMetadata, arg11: &mut 0x2::tx_context::TxContext) : ValidatorInfo {
        let v0 = 0x2::bls12381::g1_from_bytes(&arg2);
        assert!(verify_proof_of_possession(0, 0x2::tx_context::sender(arg11), arg2, arg6), 0);
        let v1 = ValidatorInfo{
            name                              : arg0,
            validator_id                      : arg1,
            network_address                   : arg7,
            p2p_address                       : arg8,
            consensus_address                 : arg9,
            protocol_pubkey_bytes             : arg2,
            protocol_pubkey                   : 0x2::bls12381::g1_to_uncompressed_g1(&v0),
            network_pubkey_bytes              : arg3,
            consensus_pubkey_bytes            : arg4,
            mpc_data_bytes                    : 0x1::option::some<0x2::table_vec::TableVec<vector<u8>>>(arg5),
            next_epoch_protocol_pubkey_bytes  : 0x1::option::none<vector<u8>>(),
            next_epoch_network_pubkey_bytes   : 0x1::option::none<vector<u8>>(),
            next_epoch_consensus_pubkey_bytes : 0x1::option::none<vector<u8>>(),
            next_epoch_mpc_data_bytes         : 0x1::option::none<0x2::table_vec::TableVec<vector<u8>>>(),
            next_epoch_network_address        : 0x1::option::none<0x1::string::String>(),
            next_epoch_p2p_address            : 0x1::option::none<0x1::string::String>(),
            next_epoch_consensus_address      : 0x1::option::none<0x1::string::String>(),
            previous_mpc_data_bytes           : 0x1::option::none<0x2::table_vec::TableVec<vector<u8>>>(),
            metadata                          : 0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::extended_field::new<0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::validator_metadata::ValidatorMetadata>(arg10, arg11),
        };
        validate(&v1);
        v1
    }

    public fun consensus_address(arg0: &ValidatorInfo) : &0x1::string::String {
        &arg0.consensus_address
    }

    public fun consensus_pubkey_bytes(arg0: &ValidatorInfo) : &vector<u8> {
        &arg0.consensus_pubkey_bytes
    }

    public(friend) fun is_duplicate(arg0: &ValidatorInfo, arg1: &ValidatorInfo) : bool {
        if (arg0.name == arg1.name) {
            true
        } else if (arg0.network_address == arg1.network_address) {
            true
        } else if (arg0.p2p_address == arg1.p2p_address) {
            true
        } else if (arg0.protocol_pubkey_bytes == arg1.protocol_pubkey_bytes) {
            true
        } else if (arg0.network_pubkey_bytes == arg1.network_pubkey_bytes) {
            true
        } else if (arg0.network_pubkey_bytes == arg1.consensus_pubkey_bytes) {
            true
        } else if (arg0.consensus_pubkey_bytes == arg1.consensus_pubkey_bytes) {
            true
        } else if (arg0.consensus_pubkey_bytes == arg1.network_pubkey_bytes) {
            true
        } else if (is_equal_some<0x1::string::String>(&arg0.next_epoch_network_address, &arg1.next_epoch_network_address)) {
            true
        } else if (is_equal_some<0x1::string::String>(&arg0.next_epoch_p2p_address, &arg1.next_epoch_p2p_address)) {
            true
        } else if (is_equal_some<vector<u8>>(&arg0.next_epoch_protocol_pubkey_bytes, &arg1.next_epoch_protocol_pubkey_bytes)) {
            true
        } else if (is_equal_some<vector<u8>>(&arg0.next_epoch_network_pubkey_bytes, &arg1.next_epoch_network_pubkey_bytes)) {
            true
        } else if (is_equal_some<vector<u8>>(&arg0.next_epoch_network_pubkey_bytes, &arg1.next_epoch_consensus_pubkey_bytes)) {
            true
        } else if (is_equal_some<vector<u8>>(&arg0.next_epoch_consensus_pubkey_bytes, &arg1.next_epoch_consensus_pubkey_bytes)) {
            true
        } else if (is_equal_some<vector<u8>>(&arg0.next_epoch_consensus_pubkey_bytes, &arg1.next_epoch_network_pubkey_bytes)) {
            true
        } else if (is_equal_some_and_value<0x1::string::String>(&arg0.next_epoch_network_address, &arg1.network_address)) {
            true
        } else if (is_equal_some_and_value<0x1::string::String>(&arg0.next_epoch_p2p_address, &arg1.p2p_address)) {
            true
        } else if (is_equal_some_and_value<vector<u8>>(&arg0.next_epoch_protocol_pubkey_bytes, &arg1.protocol_pubkey_bytes)) {
            true
        } else if (is_equal_some_and_value<vector<u8>>(&arg0.next_epoch_network_pubkey_bytes, &arg1.network_pubkey_bytes)) {
            true
        } else if (is_equal_some_and_value<vector<u8>>(&arg0.next_epoch_network_pubkey_bytes, &arg1.consensus_pubkey_bytes)) {
            true
        } else if (is_equal_some_and_value<vector<u8>>(&arg0.next_epoch_consensus_pubkey_bytes, &arg1.consensus_pubkey_bytes)) {
            true
        } else if (is_equal_some_and_value<vector<u8>>(&arg0.next_epoch_consensus_pubkey_bytes, &arg1.network_pubkey_bytes)) {
            true
        } else if (is_equal_some_and_value<0x1::string::String>(&arg1.next_epoch_network_address, &arg0.network_address)) {
            true
        } else if (is_equal_some_and_value<0x1::string::String>(&arg1.next_epoch_p2p_address, &arg0.p2p_address)) {
            true
        } else if (is_equal_some_and_value<vector<u8>>(&arg1.next_epoch_protocol_pubkey_bytes, &arg0.protocol_pubkey_bytes)) {
            true
        } else if (is_equal_some_and_value<vector<u8>>(&arg1.next_epoch_network_pubkey_bytes, &arg0.network_pubkey_bytes)) {
            true
        } else if (is_equal_some_and_value<vector<u8>>(&arg1.next_epoch_network_pubkey_bytes, &arg0.consensus_pubkey_bytes)) {
            true
        } else if (is_equal_some_and_value<vector<u8>>(&arg1.next_epoch_consensus_pubkey_bytes, &arg0.consensus_pubkey_bytes)) {
            true
        } else {
            is_equal_some_and_value<vector<u8>>(&arg1.next_epoch_consensus_pubkey_bytes, &arg0.network_pubkey_bytes)
        }
    }

    fun is_equal_some<T0>(arg0: &0x1::option::Option<T0>, arg1: &0x1::option::Option<T0>) : bool {
        (0x1::option::is_none<T0>(arg0) || 0x1::option::is_none<T0>(arg1)) && false || 0x1::option::borrow<T0>(arg0) == 0x1::option::borrow<T0>(arg1)
    }

    fun is_equal_some_and_value<T0>(arg0: &0x1::option::Option<T0>, arg1: &T0) : bool {
        0x1::option::is_none<T0>(arg0) && false || 0x1::option::borrow<T0>(arg0) == arg1
    }

    public(friend) fun metadata(arg0: &ValidatorInfo) : 0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::validator_metadata::ValidatorMetadata {
        *0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::extended_field::borrow<0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::validator_metadata::ValidatorMetadata>(&arg0.metadata)
    }

    public fun mpc_data_bytes(arg0: &ValidatorInfo) : &0x1::option::Option<0x2::table_vec::TableVec<vector<u8>>> {
        &arg0.mpc_data_bytes
    }

    public fun network_address(arg0: &ValidatorInfo) : &0x1::string::String {
        &arg0.network_address
    }

    public fun network_pubkey_bytes(arg0: &ValidatorInfo) : &vector<u8> {
        &arg0.network_pubkey_bytes
    }

    public fun next_epoch_consensus_address(arg0: &ValidatorInfo) : &0x1::option::Option<0x1::string::String> {
        &arg0.next_epoch_consensus_address
    }

    public fun next_epoch_consensus_pubkey_bytes(arg0: &ValidatorInfo) : &0x1::option::Option<vector<u8>> {
        &arg0.next_epoch_consensus_pubkey_bytes
    }

    public fun next_epoch_mpc_data_bytes(arg0: &ValidatorInfo) : &0x1::option::Option<0x2::table_vec::TableVec<vector<u8>>> {
        &arg0.next_epoch_mpc_data_bytes
    }

    public fun next_epoch_network_address(arg0: &ValidatorInfo) : &0x1::option::Option<0x1::string::String> {
        &arg0.next_epoch_network_address
    }

    public fun next_epoch_network_pubkey_bytes(arg0: &ValidatorInfo) : &0x1::option::Option<vector<u8>> {
        &arg0.next_epoch_network_pubkey_bytes
    }

    public fun next_epoch_p2p_address(arg0: &ValidatorInfo) : &0x1::option::Option<0x1::string::String> {
        &arg0.next_epoch_p2p_address
    }

    public fun next_epoch_protocol_pubkey_bytes(arg0: &ValidatorInfo) : &0x1::option::Option<vector<u8>> {
        &arg0.next_epoch_protocol_pubkey_bytes
    }

    public fun p2p_address(arg0: &ValidatorInfo) : &0x1::string::String {
        &arg0.p2p_address
    }

    public fun previous_mpc_data_bytes(arg0: &ValidatorInfo) : &0x1::option::Option<0x2::table_vec::TableVec<vector<u8>>> {
        &arg0.previous_mpc_data_bytes
    }

    public(friend) fun proof_of_possession_intent_bytes(arg0: u64, arg1: address, arg2: vector<u8>) : vector<u8> {
        let v0 = x"000000";
        let v1 = b"";
        0x1::vector::append<u8>(&mut v1, arg2);
        0x1::vector::append<u8>(&mut v1, 0x2::address::to_bytes(arg1));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<vector<u8>>(&v1));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg0));
        v0
    }

    public fun protocol_pubkey(arg0: &ValidatorInfo) : &0x2::group_ops::Element<0x2::bls12381::UncompressedG1> {
        &arg0.protocol_pubkey
    }

    public fun protocol_pubkey_bytes(arg0: &ValidatorInfo) : &vector<u8> {
        &arg0.protocol_pubkey_bytes
    }

    public(friend) fun rotate_next_epoch_info(arg0: &mut ValidatorInfo) {
        if (0x1::option::is_some<0x1::string::String>(&arg0.next_epoch_network_address)) {
            arg0.network_address = 0x1::option::extract<0x1::string::String>(&mut arg0.next_epoch_network_address);
            arg0.next_epoch_network_address = 0x1::option::none<0x1::string::String>();
        };
        if (0x1::option::is_some<0x1::string::String>(&arg0.next_epoch_p2p_address)) {
            arg0.p2p_address = 0x1::option::extract<0x1::string::String>(&mut arg0.next_epoch_p2p_address);
            arg0.next_epoch_p2p_address = 0x1::option::none<0x1::string::String>();
        };
        if (0x1::option::is_some<0x1::string::String>(&arg0.next_epoch_consensus_address)) {
            arg0.consensus_address = 0x1::option::extract<0x1::string::String>(&mut arg0.next_epoch_consensus_address);
            arg0.next_epoch_consensus_address = 0x1::option::none<0x1::string::String>();
        };
        if (0x1::option::is_some<vector<u8>>(&arg0.next_epoch_protocol_pubkey_bytes)) {
            arg0.protocol_pubkey_bytes = 0x1::option::extract<vector<u8>>(&mut arg0.next_epoch_protocol_pubkey_bytes);
            arg0.next_epoch_protocol_pubkey_bytes = 0x1::option::none<vector<u8>>();
            let v0 = 0x2::bls12381::g1_from_bytes(&arg0.protocol_pubkey_bytes);
            arg0.protocol_pubkey = 0x2::bls12381::g1_to_uncompressed_g1(&v0);
        };
        if (0x1::option::is_some<vector<u8>>(&arg0.next_epoch_network_pubkey_bytes)) {
            arg0.network_pubkey_bytes = 0x1::option::extract<vector<u8>>(&mut arg0.next_epoch_network_pubkey_bytes);
            arg0.next_epoch_network_pubkey_bytes = 0x1::option::none<vector<u8>>();
        };
        if (0x1::option::is_some<vector<u8>>(&arg0.next_epoch_consensus_pubkey_bytes)) {
            arg0.consensus_pubkey_bytes = 0x1::option::extract<vector<u8>>(&mut arg0.next_epoch_consensus_pubkey_bytes);
            arg0.next_epoch_consensus_pubkey_bytes = 0x1::option::none<vector<u8>>();
        };
        if (0x1::option::is_some<0x2::table_vec::TableVec<vector<u8>>>(&arg0.next_epoch_mpc_data_bytes) && 0x1::option::is_none<0x2::table_vec::TableVec<vector<u8>>>(&arg0.previous_mpc_data_bytes)) {
            0x1::option::fill<0x2::table_vec::TableVec<vector<u8>>>(&mut arg0.previous_mpc_data_bytes, 0x1::option::swap<0x2::table_vec::TableVec<vector<u8>>>(&mut arg0.mpc_data_bytes, 0x1::option::extract<0x2::table_vec::TableVec<vector<u8>>>(&mut arg0.next_epoch_mpc_data_bytes)));
        };
    }

    public(friend) fun set_name(arg0: &mut ValidatorInfo, arg1: 0x1::string::String) {
        arg0.name = arg1;
        validate(arg0);
    }

    public(friend) fun set_network_address(arg0: &mut ValidatorInfo, arg1: 0x1::string::String) {
        arg0.network_address = arg1;
        validate(arg0);
    }

    public(friend) fun set_next_epoch_consensus_address(arg0: &mut ValidatorInfo, arg1: 0x1::string::String) {
        arg0.next_epoch_consensus_address = 0x1::option::some<0x1::string::String>(arg1);
        validate(arg0);
    }

    public(friend) fun set_next_epoch_consensus_pubkey_bytes(arg0: &mut ValidatorInfo, arg1: vector<u8>) {
        arg0.next_epoch_consensus_pubkey_bytes = 0x1::option::some<vector<u8>>(arg1);
        validate(arg0);
    }

    public(friend) fun set_next_epoch_mpc_data_bytes(arg0: &mut ValidatorInfo, arg1: 0x2::table_vec::TableVec<vector<u8>>) : 0x1::option::Option<0x2::table_vec::TableVec<vector<u8>>> {
        if (0x1::option::is_some<0x2::table_vec::TableVec<vector<u8>>>(&arg0.next_epoch_mpc_data_bytes)) {
            0x1::option::fill<0x2::table_vec::TableVec<vector<u8>>>(&mut arg0.next_epoch_mpc_data_bytes, arg1);
            validate(arg0);
            0x1::option::some<0x2::table_vec::TableVec<vector<u8>>>(0x1::option::extract<0x2::table_vec::TableVec<vector<u8>>>(&mut arg0.next_epoch_mpc_data_bytes))
        } else if (0x1::option::is_some<0x2::table_vec::TableVec<vector<u8>>>(&arg0.previous_mpc_data_bytes)) {
            0x1::option::fill<0x2::table_vec::TableVec<vector<u8>>>(&mut arg0.next_epoch_mpc_data_bytes, arg1);
            validate(arg0);
            0x1::option::some<0x2::table_vec::TableVec<vector<u8>>>(0x1::option::extract<0x2::table_vec::TableVec<vector<u8>>>(&mut arg0.previous_mpc_data_bytes))
        } else {
            0x1::option::fill<0x2::table_vec::TableVec<vector<u8>>>(&mut arg0.next_epoch_mpc_data_bytes, arg1);
            validate(arg0);
            0x1::option::none<0x2::table_vec::TableVec<vector<u8>>>()
        }
    }

    public(friend) fun set_next_epoch_network_address(arg0: &mut ValidatorInfo, arg1: 0x1::string::String) {
        arg0.next_epoch_network_address = 0x1::option::some<0x1::string::String>(arg1);
        validate(arg0);
    }

    public(friend) fun set_next_epoch_network_pubkey_bytes(arg0: &mut ValidatorInfo, arg1: vector<u8>) {
        arg0.next_epoch_network_pubkey_bytes = 0x1::option::some<vector<u8>>(arg1);
        validate(arg0);
    }

    public(friend) fun set_next_epoch_p2p_address(arg0: &mut ValidatorInfo, arg1: 0x1::string::String) {
        arg0.next_epoch_p2p_address = 0x1::option::some<0x1::string::String>(arg1);
        validate(arg0);
    }

    public(friend) fun set_next_epoch_protocol_pubkey_bytes(arg0: &mut ValidatorInfo, arg1: vector<u8>, arg2: vector<u8>, arg3: &0x2::tx_context::TxContext) {
        assert!(verify_proof_of_possession(0, 0x2::tx_context::sender(arg3), arg1, arg2), 0);
        arg0.next_epoch_protocol_pubkey_bytes = 0x1::option::some<vector<u8>>(arg1);
        validate(arg0);
    }

    public(friend) fun set_validator_metadata(arg0: &mut ValidatorInfo, arg1: 0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::validator_metadata::ValidatorMetadata) {
        0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::extended_field::swap<0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::validator_metadata::ValidatorMetadata>(&mut arg0.metadata, arg1);
    }

    public(friend) fun validate(arg0: &ValidatorInfo) {
        assert!(0x1::string::length(&arg0.name) <= 100, 1);
        let v0 = if (0x1::string::length(&arg0.network_address) <= 259) {
            if (0x1::string::length(&arg0.p2p_address) <= 259) {
                if (0x1::string::length(&arg0.consensus_address) <= 259) {
                    0x1::string::length(&arg0.name) <= 259
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 8);
        assert!(0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::multiaddr::validate_tcp(&arg0.network_address), 5);
        if (0x1::option::is_some<0x1::string::String>(&arg0.next_epoch_network_address)) {
            assert!(0x1::string::length(0x1::option::borrow<0x1::string::String>(&arg0.next_epoch_network_address)) <= 259, 8);
            assert!(0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::multiaddr::validate_tcp(0x1::option::borrow<0x1::string::String>(&arg0.next_epoch_network_address)), 5);
        };
        assert!(0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::multiaddr::validate_udp(&arg0.p2p_address), 6);
        if (0x1::option::is_some<0x1::string::String>(&arg0.next_epoch_p2p_address)) {
            assert!(0x1::string::length(0x1::option::borrow<0x1::string::String>(&arg0.next_epoch_p2p_address)) <= 259, 8);
            assert!(0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::multiaddr::validate_udp(0x1::option::borrow<0x1::string::String>(&arg0.next_epoch_p2p_address)), 6);
        };
        assert!(0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::multiaddr::validate_udp(&arg0.consensus_address), 7);
        if (0x1::option::is_some<0x1::string::String>(&arg0.next_epoch_consensus_address)) {
            assert!(0x1::string::length(0x1::option::borrow<0x1::string::String>(&arg0.next_epoch_consensus_address)) <= 259, 8);
            assert!(0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::multiaddr::validate_udp(0x1::option::borrow<0x1::string::String>(&arg0.next_epoch_consensus_address)), 7);
        };
        assert!(0x1::vector::length<u8>(&arg0.network_pubkey_bytes) == 32, 3);
        if (0x1::option::is_some<vector<u8>>(&arg0.next_epoch_network_pubkey_bytes)) {
            assert!(0x1::vector::length<u8>(0x1::option::borrow<vector<u8>>(&arg0.next_epoch_network_pubkey_bytes)) == 32, 3);
        };
        assert!(0x1::vector::length<u8>(&arg0.consensus_pubkey_bytes) == 32, 4);
        if (0x1::option::is_some<vector<u8>>(&arg0.next_epoch_consensus_pubkey_bytes)) {
            assert!(0x1::vector::length<u8>(0x1::option::borrow<vector<u8>>(&arg0.next_epoch_consensus_pubkey_bytes)) == 32, 4);
        };
        assert!(0x1::vector::length<u8>(&arg0.protocol_pubkey_bytes) == 48, 2);
        if (0x1::option::is_some<vector<u8>>(&arg0.next_epoch_protocol_pubkey_bytes)) {
            assert!(0x1::vector::length<u8>(0x1::option::borrow<vector<u8>>(&arg0.next_epoch_protocol_pubkey_bytes)) == 48, 2);
        };
    }

    public fun validator_id(arg0: &ValidatorInfo) : 0x2::object::ID {
        arg0.validator_id
    }

    public(friend) fun verify_proof_of_possession(arg0: u64, arg1: address, arg2: vector<u8>, arg3: vector<u8>) : bool {
        let v0 = proof_of_possession_intent_bytes(arg0, arg1, arg2);
        0x2::bls12381::bls12381_min_pk_verify(&arg3, &arg2, &v0)
    }

    // decompiled from Move bytecode v6
}

