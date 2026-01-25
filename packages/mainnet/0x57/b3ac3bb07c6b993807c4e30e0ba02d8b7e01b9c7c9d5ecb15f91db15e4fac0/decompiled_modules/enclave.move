module 0x57b3ac3bb07c6b993807c4e30e0ba02d8b7e01b9c7c9d5ecb15f91db15e4fac0::enclave {
    struct Pcrs has copy, drop, store {
        pos0: vector<u8>,
        pos1: vector<u8>,
        pos2: vector<u8>,
        pos3: vector<u8>,
    }

    struct EnclaveConfig<phantom T0> has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        pcrs: Pcrs,
        capability_id: 0x2::object::ID,
        version: u64,
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

    fun assert_is_valid_for_config<T0>(arg0: &Cap<T0>, arg1: &EnclaveConfig<T0>) {
        assert!(0x2::object::uid_to_inner(&arg0.id) == arg1.capability_id, 2);
    }

    fun compress_secp256k1_pubkey(arg0: &vector<u8>) : vector<u8> {
        assert!(0x1::vector::length<u8>(arg0) == 64, 5);
        let v0 = 0x1::vector::empty<u8>();
        let v1 = if (*0x1::vector::borrow<u8>(arg0, 63) % 2 == 0) {
            2
        } else {
            3
        };
        0x1::vector::push_back<u8>(&mut v0, v1);
        let v2 = 0;
        while (v2 < 32) {
            0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(arg0, v2));
            v2 = v2 + 1;
        };
        v0
    }

    public fun create_enclave_config<T0: drop>(arg0: &Cap<T0>, arg1: 0x1::string::String, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = Pcrs{
            pos0 : arg2,
            pos1 : arg3,
            pos2 : arg4,
            pos3 : arg5,
        };
        let v1 = EnclaveConfig<T0>{
            id            : 0x2::object::new(arg6),
            name          : arg1,
            pcrs          : v0,
            capability_id : 0x2::object::uid_to_inner(&arg0.id),
            version       : 0,
        };
        0x2::transfer::share_object<EnclaveConfig<T0>>(v1);
    }

    fun create_intent_message<T0: drop>(arg0: u8, arg1: u64, arg2: T0) : IntentMessage<T0> {
        IntentMessage<T0>{
            intent       : arg0,
            timestamp_ms : arg1,
            payload      : arg2,
        }
    }

    public fun deploy_old_enclave_by_owner<T0>(arg0: Enclave<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg1), 3);
        let Enclave {
            id             : v0,
            pk             : _,
            config_version : _,
            owner          : _,
        } = arg0;
        0x2::object::delete(v0);
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

    fun load_pk<T0>(arg0: &EnclaveConfig<T0>, arg1: &0x2::nitro_attestation::NitroAttestationDocument) : vector<u8> {
        assert!(to_pcrs(arg1) == arg0.pcrs, 0);
        let v0 = 0x1::option::destroy_some<vector<u8>>(*0x2::nitro_attestation::public_key(arg1));
        if (0x1::vector::length<u8>(&v0) == 64) {
            let v1 = &v0;
            v0 = compress_secp256k1_pubkey(v1);
        };
        assert!(0x1::vector::length<u8>(&v0) == 33, 4);
        v0
    }

    public fun new_cap<T0: drop>(arg0: T0, arg1: &mut 0x2::tx_context::TxContext) : Cap<T0> {
        Cap<T0>{id: 0x2::object::new(arg1)}
    }

    public fun pcr0<T0>(arg0: &EnclaveConfig<T0>) : &vector<u8> {
        &arg0.pcrs.pos0
    }

    public fun pcr1<T0>(arg0: &EnclaveConfig<T0>) : &vector<u8> {
        &arg0.pcrs.pos1
    }

    public fun pcr16<T0>(arg0: &EnclaveConfig<T0>) : &vector<u8> {
        &arg0.pcrs.pos3
    }

    public fun pcr2<T0>(arg0: &EnclaveConfig<T0>) : &vector<u8> {
        &arg0.pcrs.pos2
    }

    public fun pk<T0>(arg0: &Enclave<T0>) : &vector<u8> {
        &arg0.pk
    }

    public fun register_enclave<T0>(arg0: &EnclaveConfig<T0>, arg1: 0x2::nitro_attestation::NitroAttestationDocument, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Enclave<T0>{
            id             : 0x2::object::new(arg2),
            pk             : load_pk<T0>(arg0, &arg1),
            config_version : arg0.version,
            owner          : 0x2::tx_context::sender(arg2),
        };
        0x2::transfer::share_object<Enclave<T0>>(v0);
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

    public fun update_name<T0: drop>(arg0: &mut EnclaveConfig<T0>, arg1: &Cap<T0>, arg2: 0x1::string::String) {
        assert_is_valid_for_config<T0>(arg1, arg0);
        arg0.name = arg2;
    }

    public fun update_pcrs<T0: drop>(arg0: &mut EnclaveConfig<T0>, arg1: &Cap<T0>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>) {
        assert_is_valid_for_config<T0>(arg1, arg0);
        let v0 = Pcrs{
            pos0 : arg2,
            pos1 : arg3,
            pos2 : arg4,
            pos3 : arg5,
        };
        arg0.pcrs = v0;
        arg0.version = arg0.version + 1;
    }

    public fun verify_signature<T0, T1: drop>(arg0: &Enclave<T0>, arg1: u8, arg2: u64, arg3: T1, arg4: &vector<u8>) : bool {
        let v0 = create_intent_message<T1>(arg1, arg2, arg3);
        let v1 = 0x1::bcs::to_bytes<IntentMessage<T1>>(&v0);
        0x2::ecdsa_k1::secp256k1_verify(arg4, &arg0.pk, &v1, 1)
    }

    // decompiled from Move bytecode v6
}

