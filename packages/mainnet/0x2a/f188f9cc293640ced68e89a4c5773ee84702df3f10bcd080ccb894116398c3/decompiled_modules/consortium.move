module 0x2af188f9cc293640ced68e89a4c5773ee84702df3f10bcd080ccb894116398c3::consortium {
    struct Consortium has key {
        id: 0x2::object::UID,
        epoch: u256,
        validator_set: 0x2::table::Table<u256, ValidatorSet>,
        valset_action: u32,
        admins: vector<address>,
    }

    struct ValidatorSet has store {
        pub_keys: vector<vector<u8>>,
        weights: vector<u256>,
        weight_threshold: u256,
    }

    public fun add_admin(arg0: &mut Consortium, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x1::vector::contains<address>(&arg0.admins, &v0), 0);
        assert!(!0x1::vector::contains<address>(&arg0.admins, &arg1), 1);
        0x1::vector::push_back<address>(&mut arg0.admins, arg1);
    }

    fun assert_and_configure_validator_set(arg0: &mut Consortium, arg1: u32, arg2: vector<vector<u8>>, arg3: vector<u256>, arg4: u256, arg5: u256) {
        assert!(arg1 == arg0.valset_action, 7);
        assert!(0x1::vector::length<vector<u8>>(&arg2) >= 1, 8);
        assert!(0x1::vector::length<vector<u8>>(&arg2) <= 102, 8);
        assert!(arg4 > 0, 9);
        assert!(0x1::vector::length<vector<u8>>(&arg2) == 0x1::vector::length<u256>(&arg3), 10);
        let v0 = 0;
        let v1 = 0;
        while (v0 < 0x1::vector::length<u256>(&arg3)) {
            assert!(*0x1::vector::borrow<u256>(&arg3, v0) > 0, 11);
            assert!(0x1::vector::length<u8>(0x1::vector::borrow<vector<u8>>(&arg2, v0)) == 65, 16);
            v1 = v1 + *0x1::vector::borrow<u256>(&arg3, v0);
            v0 = v0 + 1;
        };
        assert!(v1 >= arg4, 12);
        arg0.epoch = arg5;
        let v2 = ValidatorSet{
            pub_keys         : arg2,
            weights          : arg3,
            weight_threshold : arg4,
        };
        0x2::table::add<u256, ValidatorSet>(&mut arg0.validator_set, arg5, v2);
    }

    public fun get_epoch(arg0: &Consortium) : u256 {
        arg0.epoch
    }

    public fun get_validator_set(arg0: &Consortium, arg1: u256) : &ValidatorSet {
        assert!(0x2::table::contains<u256, ValidatorSet>(&arg0.validator_set, arg1), 5);
        0x2::table::borrow<u256, ValidatorSet>(&arg0.validator_set, arg1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Consortium{
            id            : 0x2::object::new(arg0),
            epoch         : 0,
            validator_set : 0x2::table::new<u256, ValidatorSet>(arg0),
            valset_action : 1252728175,
            admins        : 0x1::vector::singleton<address>(0x2::tx_context::sender(arg0)),
        };
        0x2::transfer::share_object<Consortium>(v0);
    }

    public fun remove_admin(arg0: &mut Consortium, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x1::vector::contains<address>(&arg0.admins, &v0), 0);
        assert!(0x1::vector::length<address>(&arg0.admins) > 1, 4);
        let (v1, v2) = 0x1::vector::index_of<address>(&arg0.admins, &arg1);
        assert!(v1, 2);
        0x1::vector::remove<address>(&mut arg0.admins, v2);
    }

    public fun set_initial_validator_set(arg0: &mut Consortium, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x1::vector::contains<address>(&arg0.admins, &v0), 0);
        assert!(arg0.epoch == 0, 6);
        let (v1, v2, v3, v4, v5) = 0x2af188f9cc293640ced68e89a4c5773ee84702df3f10bcd080ccb894116398c3::payload_decoder::decode_valset(arg1);
        assert!(v2 > 0, 13);
        assert!(!0x2::table::contains<u256, ValidatorSet>(&arg0.validator_set, v2), 13);
        assert_and_configure_validator_set(arg0, v1, v3, v4, v5, v2);
    }

    public fun set_next_validator_set(arg0: &mut Consortium, arg1: vector<u8>, arg2: vector<u8>) {
        let v0 = get_validator_set(arg0, arg0.epoch);
        assert!(validate_signatures(v0.pub_keys, 0x2af188f9cc293640ced68e89a4c5773ee84702df3f10bcd080ccb894116398c3::payload_decoder::decode_signatures(arg2), v0.weights, v0.weight_threshold, arg1, 0x1::hash::sha2_256(arg1)), 3);
        let (v1, v2, v3, v4, v5) = 0x2af188f9cc293640ced68e89a4c5773ee84702df3f10bcd080ccb894116398c3::payload_decoder::decode_valset(arg1);
        assert!(v2 == arg0.epoch + 1, 13);
        assert_and_configure_validator_set(arg0, v1, v3, v4, v5, v2);
    }

    public fun set_valset_action(arg0: &mut Consortium, arg1: u32, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x1::vector::contains<address>(&arg0.admins, &v0), 0);
        arg0.valset_action = arg1;
    }

    public fun validate_payload(arg0: &mut Consortium, arg1: vector<u8>, arg2: vector<u8>) {
        let v0 = get_validator_set(arg0, arg0.epoch);
        assert!(validate_signatures(v0.pub_keys, 0x2af188f9cc293640ced68e89a4c5773ee84702df3f10bcd080ccb894116398c3::payload_decoder::decode_signatures(arg2), v0.weights, v0.weight_threshold, arg1, 0x1::hash::sha2_256(arg1)), 3);
    }

    public fun validate_signatures(arg0: vector<vector<u8>>, arg1: vector<vector<u8>>, arg2: vector<u256>, arg3: u256, arg4: vector<u8>, arg5: vector<u8>) : bool {
        assert!(0x1::hash::sha2_256(arg4) == arg5, 14);
        assert!(0x1::vector::length<vector<u8>>(&arg0) == 0x1::vector::length<vector<u8>>(&arg1), 15);
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<vector<u8>>(&arg1)) {
            let v2 = *0x1::vector::borrow<vector<u8>>(&arg1, v1);
            if (v2 != x"0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000") {
                if (0x2::ecdsa_k1::secp256k1_verify(&v2, 0x1::vector::borrow<vector<u8>>(&arg0, v1), &arg4, 1) == false) {
                    v1 = v1 + 1;
                    continue
                };
                v0 = v0 + *0x1::vector::borrow<u256>(&arg2, v1);
                if (v0 >= arg3) {
                    return true
                };
            };
            v1 = v1 + 1;
        };
        false
    }

    // decompiled from Move bytecode v6
}

