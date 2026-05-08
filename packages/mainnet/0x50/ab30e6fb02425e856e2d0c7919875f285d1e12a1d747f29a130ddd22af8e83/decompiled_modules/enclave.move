module 0x50ab30e6fb02425e856e2d0c7919875f285d1e12a1d747f29a130ddd22af8e83::enclave {
    struct Pcrs has copy, drop, store {
        pos0: vector<u8>,
        pos1: vector<u8>,
        pos2: vector<u8>,
        pos3: vector<u8>,
    }

    struct EnclaveConfig<phantom T0> has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        pcrs: vector<Pcrs>,
        capability_id: 0x2::object::ID,
        version: u64,
        master_seed_blob: 0x1::option::Option<vector<u8>>,
        enclave_pk: 0x1::option::Option<vector<u8>>,
        bootstrap_pk: 0x1::option::Option<vector<u8>>,
        environment: vector<u8>,
        debug_allowed: bool,
    }

    struct Enclave<phantom T0> has key {
        id: 0x2::object::UID,
        pk: vector<u8>,
        config_version: u64,
        owner: address,
    }

    struct Cap<phantom T0> has store, key {
        id: 0x2::object::UID,
    }

    struct IntentMessage<T0: drop> has copy, drop {
        intent: u8,
        timestamp_ms: u64,
        payload: T0,
    }

    public fun pcrs<T0>(arg0: &EnclaveConfig<T0>) : &vector<Pcrs> {
        &arg0.pcrs
    }

    public fun admit_pcrs<T0: drop>(arg0: &mut EnclaveConfig<T0>, arg1: &Cap<T0>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>) {
        assert_is_valid_for_config<T0>(arg1, arg0);
        let v0 = Pcrs{
            pos0 : arg2,
            pos1 : arg3,
            pos2 : arg4,
            pos3 : arg5,
        };
        admit_pcrs_internal<T0>(arg0, v0);
    }

    public fun admit_pcrs_admin<T0: drop>(arg0: &mut EnclaveConfig<T0>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>) {
        let v0 = Pcrs{
            pos0 : arg1,
            pos1 : arg2,
            pos2 : arg3,
            pos3 : arg4,
        };
        admit_pcrs_internal<T0>(arg0, v0);
    }

    fun admit_pcrs_internal<T0>(arg0: &mut EnclaveConfig<T0>, arg1: Pcrs) {
        if (!contains_pcrs<T0>(arg0, &arg1)) {
            assert!(0x1::vector::length<Pcrs>(&arg0.pcrs) < 4, 100);
            0x1::vector::push_back<Pcrs>(&mut arg0.pcrs, arg1);
            arg0.version = arg0.version + 1;
        };
    }

    public fun admit_pcrs_with_pcu<T0: drop>(arg0: &mut EnclaveConfig<T0>, arg1: &0x50ab30e6fb02425e856e2d0c7919875f285d1e12a1d747f29a130ddd22af8e83::caps::PcrUpdateCap<T0>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>) {
        0x50ab30e6fb02425e856e2d0c7919875f285d1e12a1d747f29a130ddd22af8e83::caps::assert_controls<T0>(arg1, 0x2::object::uid_to_inner(&arg0.id));
        let v0 = Pcrs{
            pos0 : arg2,
            pos1 : arg3,
            pos2 : arg4,
            pos3 : arg5,
        };
        admit_pcrs_internal<T0>(arg0, v0);
    }

    public fun assert_attestation_matches_config<T0>(arg0: &EnclaveConfig<T0>, arg1: &0x2::nitro_attestation::NitroAttestationDocument) {
        assert!(check_pcr_match<T0>(arg0, arg1), 5);
    }

    fun assert_is_valid_for_config<T0>(arg0: &Cap<T0>, arg1: &EnclaveConfig<T0>) {
        assert!(0x2::object::uid_to_inner(&arg0.id) == arg1.capability_id, 2);
    }

    public fun bootstrap_pk<T0>(arg0: &EnclaveConfig<T0>) : &0x1::option::Option<vector<u8>> {
        &arg0.bootstrap_pk
    }

    public fun burn_cap<T0>(arg0: Cap<T0>) {
        let Cap { id: v0 } = arg0;
        0x2::object::delete(v0);
    }

    public fun check_pcr_match<T0>(arg0: &EnclaveConfig<T0>, arg1: &0x2::nitro_attestation::NitroAttestationDocument) : bool {
        let v0 = to_pcrs(arg1);
        pcrs_match_config<T0>(arg0, &v0)
    }

    public fun contains_pcrs<T0>(arg0: &EnclaveConfig<T0>, arg1: &Pcrs) : bool {
        find_pcrs_index<T0>(arg0, arg1) < 0x1::vector::length<Pcrs>(&arg0.pcrs)
    }

    public fun create_enclave_config<T0: drop>(arg0: &Cap<T0>, arg1: 0x1::string::String, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: bool, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = Pcrs{
            pos0 : arg2,
            pos1 : arg3,
            pos2 : arg4,
            pos3 : arg5,
        };
        let v1 = 0x1::vector::empty<Pcrs>();
        0x1::vector::push_back<Pcrs>(&mut v1, v0);
        let v2 = EnclaveConfig<T0>{
            id               : 0x2::object::new(arg8),
            name             : arg1,
            pcrs             : v1,
            capability_id    : 0x2::object::uid_to_inner(&arg0.id),
            version          : 0,
            master_seed_blob : 0x1::option::none<vector<u8>>(),
            enclave_pk       : 0x1::option::none<vector<u8>>(),
            bootstrap_pk     : 0x1::option::none<vector<u8>>(),
            environment      : arg6,
            debug_allowed    : arg7,
        };
        0x2::transfer::share_object<EnclaveConfig<T0>>(v2);
    }

    public(friend) fun create_intent_message<T0: drop>(arg0: u8, arg1: u64, arg2: T0) : IntentMessage<T0> {
        IntentMessage<T0>{
            intent       : arg0,
            timestamp_ms : arg1,
            payload      : arg2,
        }
    }

    public fun debug_allowed<T0>(arg0: &EnclaveConfig<T0>) : bool {
        arg0.debug_allowed
    }

    public fun deploy_old_enclave_by_owner<T0>(arg0: Enclave<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        destroy_old_enclave_by_owner<T0>(arg0, arg1);
    }

    public fun destroy_old_enclave<T0>(arg0: Enclave<T0>, arg1: &EnclaveConfig<T0>) {
        assert!(arg0.config_version < arg1.version, 1);
        let Enclave {
            id             : v0,
            pk             : _,
            config_version : _,
            owner          : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun destroy_old_enclave_by_owner<T0>(arg0: Enclave<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg1), 3);
        let Enclave {
            id             : v0,
            pk             : _,
            config_version : _,
            owner          : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun dev_register_enclave<T0>(arg0: &Cap<T0>, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u8>(&arg1) == 32, 4);
        let v0 = Enclave<T0>{
            id             : 0x2::object::new(arg2),
            pk             : arg1,
            config_version : 0,
            owner          : 0x2::tx_context::sender(arg2),
        };
        0x2::transfer::share_object<Enclave<T0>>(v0);
    }

    public fun enclave_pk<T0>(arg0: &EnclaveConfig<T0>) : &0x1::option::Option<vector<u8>> {
        &arg0.enclave_pk
    }

    public fun environment<T0>(arg0: &EnclaveConfig<T0>) : &vector<u8> {
        &arg0.environment
    }

    public fun find_pcrs_index<T0>(arg0: &EnclaveConfig<T0>, arg1: &Pcrs) : u64 {
        let v0 = 0;
        let v1 = 0x1::vector::length<Pcrs>(&arg0.pcrs);
        while (v0 < v1) {
            if (0x1::vector::borrow<Pcrs>(&arg0.pcrs, v0) == arg1) {
                return v0
            };
            v0 = v0 + 1;
        };
        v1
    }

    public fun is_zero_pcrs(arg0: &Pcrs) : bool {
        if (is_zero_vec(&arg0.pos0)) {
            if (is_zero_vec(&arg0.pos1)) {
                is_zero_vec(&arg0.pos2)
            } else {
                false
            }
        } else {
            false
        }
    }

    fun is_zero_vec(arg0: &vector<u8>) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<u8>(arg0)) {
            if (*0x1::vector::borrow<u8>(arg0, v0) != 0) {
                return false
            };
            v0 = v0 + 1;
        };
        true
    }

    public fun master_seed_blob<T0>(arg0: &EnclaveConfig<T0>) : &0x1::option::Option<vector<u8>> {
        &arg0.master_seed_blob
    }

    public fun new_cap<T0: drop>(arg0: T0, arg1: &mut 0x2::tx_context::TxContext) : Cap<T0> {
        Cap<T0>{id: 0x2::object::new(arg1)}
    }

    public fun new_pcrs(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>) : Pcrs {
        Pcrs{
            pos0 : arg0,
            pos1 : arg1,
            pos2 : arg2,
            pos3 : arg3,
        }
    }

    public fun pcr0<T0>(arg0: &EnclaveConfig<T0>) : &vector<u8> {
        &0x1::vector::borrow<Pcrs>(&arg0.pcrs, 0).pos0
    }

    public fun pcr1<T0>(arg0: &EnclaveConfig<T0>) : &vector<u8> {
        &0x1::vector::borrow<Pcrs>(&arg0.pcrs, 0).pos1
    }

    public fun pcr16<T0>(arg0: &EnclaveConfig<T0>) : &vector<u8> {
        &0x1::vector::borrow<Pcrs>(&arg0.pcrs, 0).pos3
    }

    public fun pcr2<T0>(arg0: &EnclaveConfig<T0>) : &vector<u8> {
        &0x1::vector::borrow<Pcrs>(&arg0.pcrs, 0).pos2
    }

    public fun pcrs_match_config<T0>(arg0: &EnclaveConfig<T0>, arg1: &Pcrs) : bool {
        if (arg0.debug_allowed && is_zero_pcrs(arg1)) {
            return true
        };
        contains_pcrs<T0>(arg0, arg1)
    }

    public fun pk<T0>(arg0: &Enclave<T0>) : &vector<u8> {
        &arg0.pk
    }

    public entry fun publish_master_seed<T0>(arg0: &mut EnclaveConfig<T0>, arg1: vector<u8>, arg2: vector<u8>, arg3: 0x2::nitro_attestation::NitroAttestationDocument) {
        assert_attestation_matches_config<T0>(arg0, &arg3);
        assert!(0x1::option::is_none<vector<u8>>(&arg0.master_seed_blob), 6);
        assert!(arg2 == 0x1::option::destroy_some<vector<u8>>(*0x2::nitro_attestation::public_key(&arg3)), 7);
        assert!(0x1::vector::length<u8>(&arg2) == 32, 4);
        0x1::option::fill<vector<u8>>(&mut arg0.master_seed_blob, arg1);
        0x1::option::fill<vector<u8>>(&mut arg0.enclave_pk, arg2);
    }

    public fun register_enclave<T0>(arg0: &EnclaveConfig<T0>, arg1: 0x2::nitro_attestation::NitroAttestationDocument, arg2: &mut 0x2::tx_context::TxContext) {
        assert_attestation_matches_config<T0>(arg0, &arg1);
        let v0 = Enclave<T0>{
            id             : 0x2::object::new(arg2),
            pk             : 0x1::vector::empty<u8>(),
            config_version : arg0.version,
            owner          : 0x2::tx_context::sender(arg2),
        };
        let v1 = &mut v0;
        set_pk_from_attestation<T0>(v1, &arg1, arg0.version);
        0x2::transfer::share_object<Enclave<T0>>(v0);
    }

    public fun retire_pcrs<T0: drop>(arg0: &mut EnclaveConfig<T0>, arg1: &Cap<T0>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>) {
        assert_is_valid_for_config<T0>(arg1, arg0);
        let v0 = Pcrs{
            pos0 : arg2,
            pos1 : arg3,
            pos2 : arg4,
            pos3 : arg5,
        };
        retire_pcrs_internal<T0>(arg0, v0);
    }

    public fun retire_pcrs_admin<T0: drop>(arg0: &mut EnclaveConfig<T0>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>) {
        let v0 = Pcrs{
            pos0 : arg1,
            pos1 : arg2,
            pos2 : arg3,
            pos3 : arg4,
        };
        retire_pcrs_internal<T0>(arg0, v0);
    }

    fun retire_pcrs_internal<T0>(arg0: &mut EnclaveConfig<T0>, arg1: Pcrs) {
        let v0 = find_pcrs_index<T0>(arg0, &arg1);
        assert!(v0 < 0x1::vector::length<Pcrs>(&arg0.pcrs), 101);
        0x1::vector::remove<Pcrs>(&mut arg0.pcrs, v0);
        arg0.version = arg0.version + 1;
    }

    public fun retire_pcrs_with_pcu<T0: drop>(arg0: &mut EnclaveConfig<T0>, arg1: &0x50ab30e6fb02425e856e2d0c7919875f285d1e12a1d747f29a130ddd22af8e83::caps::PcrUpdateCap<T0>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>) {
        0x50ab30e6fb02425e856e2d0c7919875f285d1e12a1d747f29a130ddd22af8e83::caps::assert_controls<T0>(arg1, 0x2::object::uid_to_inner(&arg0.id));
        let v0 = Pcrs{
            pos0 : arg2,
            pos1 : arg3,
            pos2 : arg4,
            pos3 : arg5,
        };
        retire_pcrs_internal<T0>(arg0, v0);
    }

    public fun set_bootstrap_pk<T0>(arg0: &mut EnclaveConfig<T0>, arg1: vector<u8>) {
        arg0.bootstrap_pk = 0x1::option::some<vector<u8>>(arg1);
    }

    fun set_pk_from_attestation<T0>(arg0: &mut Enclave<T0>, arg1: &0x2::nitro_attestation::NitroAttestationDocument, arg2: u64) {
        let v0 = 0x1::option::destroy_some<vector<u8>>(*0x2::nitro_attestation::public_key(arg1));
        assert!(0x1::vector::length<u8>(&v0) == 32, 4);
        arg0.pk = v0;
        arg0.config_version = arg2;
    }

    fun to_pcrs(arg0: &0x2::nitro_attestation::NitroAttestationDocument) : Pcrs {
        let v0 = 0x2::nitro_attestation::pcrs(arg0);
        let v1 = 0x1::vector::empty<u8>();
        let v2 = 0x1::vector::empty<u8>();
        let v3 = 0x1::vector::empty<u8>();
        let v4 = 0x1::vector::empty<u8>();
        let v5 = 0;
        while (v5 < 0x1::vector::length<0x2::nitro_attestation::PCREntry>(v0)) {
            let v6 = 0x1::vector::borrow<0x2::nitro_attestation::PCREntry>(v0, v5);
            let v7 = 0x2::nitro_attestation::index(v6);
            if (v7 == 0) {
                v1 = *0x2::nitro_attestation::value(v6);
            } else if (v7 == 1) {
                v2 = *0x2::nitro_attestation::value(v6);
            } else if (v7 == 2) {
                v3 = *0x2::nitro_attestation::value(v6);
            } else if (v7 == 16) {
                v4 = *0x2::nitro_attestation::value(v6);
            };
            v5 = v5 + 1;
        };
        Pcrs{
            pos0 : v1,
            pos1 : v2,
            pos2 : v3,
            pos3 : v4,
        }
    }

    public fun update_from_attestation<T0>(arg0: &mut EnclaveConfig<T0>, arg1: &Cap<T0>, arg2: &mut Enclave<T0>, arg3: 0x2::nitro_attestation::NitroAttestationDocument) {
        assert_is_valid_for_config<T0>(arg1, arg0);
        update_from_attestation_internal<T0>(arg0, arg2, arg3);
    }

    public fun update_from_attestation_admin<T0>(arg0: &mut EnclaveConfig<T0>, arg1: &0x50ab30e6fb02425e856e2d0c7919875f285d1e12a1d747f29a130ddd22af8e83::caps::AdminCap<T0>, arg2: &mut Enclave<T0>, arg3: 0x2::nitro_attestation::NitroAttestationDocument) {
        update_from_attestation_internal<T0>(arg0, arg2, arg3);
    }

    fun update_from_attestation_internal<T0>(arg0: &mut EnclaveConfig<T0>, arg1: &mut Enclave<T0>, arg2: 0x2::nitro_attestation::NitroAttestationDocument) {
        let v0 = to_pcrs(&arg2);
        if (!contains_pcrs<T0>(arg0, &v0)) {
            assert!(0x1::vector::length<Pcrs>(&arg0.pcrs) < 4, 100);
            0x1::vector::push_back<Pcrs>(&mut arg0.pcrs, v0);
            arg0.version = arg0.version + 1;
        };
        set_pk_from_attestation<T0>(arg1, &arg2, arg0.version);
    }

    public fun update_name<T0: drop>(arg0: &mut EnclaveConfig<T0>, arg1: &Cap<T0>, arg2: 0x1::string::String) {
        assert_is_valid_for_config<T0>(arg1, arg0);
        arg0.name = arg2;
    }

    public fun update_pcrs<T0: drop>(arg0: &mut EnclaveConfig<T0>, arg1: &Cap<T0>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>) {
        abort 0
    }

    public fun verify_signature<T0, T1: drop>(arg0: &Enclave<T0>, arg1: u8, arg2: u64, arg3: T1, arg4: &vector<u8>) : bool {
        let v0 = create_intent_message<T1>(arg1, arg2, arg3);
        let v1 = 0x1::bcs::to_bytes<IntentMessage<T1>>(&v0);
        0x2::ed25519::ed25519_verify(arg4, &arg0.pk, &v1)
    }

    // decompiled from Move bytecode v7
}

