module 0xd8210045df3ec6b95c2e814562d12403cd8e3204959b50f1e1dde34e9ec5724::enclave {
    struct EnclaveCap<phantom T0> has store, key {
        id: 0x2::object::UID,
    }

    struct Pcrs has copy, drop, store {
        pcr0: vector<u8>,
        pcr1: vector<u8>,
        pcr2: vector<u8>,
    }

    struct Enclave<phantom T0> has key {
        id: 0x2::object::UID,
        cap_id: 0x2::object::ID,
        pcrs: Pcrs,
        pk: vector<u8>,
    }

    struct IntentMessage<T0: drop> has copy, drop {
        intent: u8,
        timestamp_ms: u64,
        payload: T0,
    }

    public fun new_cap<T0: drop>(arg0: T0, arg1: &mut 0x2::tx_context::TxContext) : EnclaveCap<T0> {
        EnclaveCap<T0>{id: 0x2::object::new(arg1)}
    }

    public fun new_intent_message<T0: drop>(arg0: u8, arg1: u64, arg2: T0) : IntentMessage<T0> {
        IntentMessage<T0>{
            intent       : arg0,
            timestamp_ms : arg1,
            payload      : arg2,
        }
    }

    public fun pcr0<T0>(arg0: &Enclave<T0>) : &vector<u8> {
        &arg0.pcrs.pcr0
    }

    public fun pcr1<T0>(arg0: &Enclave<T0>) : &vector<u8> {
        &arg0.pcrs.pcr1
    }

    public fun pcr2<T0>(arg0: &Enclave<T0>) : &vector<u8> {
        &arg0.pcrs.pcr2
    }

    public fun pk<T0>(arg0: &Enclave<T0>) : &vector<u8> {
        &arg0.pk
    }

    public fun register<T0>(arg0: &EnclaveCap<T0>, arg1: 0x2::nitro_attestation::NitroAttestationDocument, arg2: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = Enclave<T0>{
            id     : 0x2::object::new(arg2),
            cap_id : 0x2::object::uid_to_inner(&arg0.id),
            pcrs   : to_pcrs(&arg1),
            pk     : 0x1::option::destroy_some<vector<u8>>(*0x2::nitro_attestation::public_key(&arg1)),
        };
        0x2::transfer::share_object<Enclave<T0>>(v0);
        0x2::object::uid_to_inner(&v0.id)
    }

    fun to_pcrs(arg0: &0x2::nitro_attestation::NitroAttestationDocument) : Pcrs {
        let v0 = 0x2::nitro_attestation::pcrs(arg0);
        Pcrs{
            pcr0 : *0x2::nitro_attestation::value(0x1::vector::borrow<0x2::nitro_attestation::PCREntry>(v0, 0)),
            pcr1 : *0x2::nitro_attestation::value(0x1::vector::borrow<0x2::nitro_attestation::PCREntry>(v0, 1)),
            pcr2 : *0x2::nitro_attestation::value(0x1::vector::borrow<0x2::nitro_attestation::PCREntry>(v0, 2)),
        }
    }

    public fun update<T0>(arg0: &mut Enclave<T0>, arg1: &EnclaveCap<T0>, arg2: 0x2::nitro_attestation::NitroAttestationDocument) {
        assert!(arg0.cap_id == 0x2::object::uid_to_inner(&arg1.id), 0);
        arg0.pcrs = to_pcrs(&arg2);
        arg0.pk = 0x1::option::destroy_some<vector<u8>>(*0x2::nitro_attestation::public_key(&arg2));
    }

    public fun verify_signature<T0, T1: drop>(arg0: &Enclave<T0>, arg1: u8, arg2: u64, arg3: T1, arg4: &vector<u8>) : bool {
        let v0 = new_intent_message<T1>(arg1, arg2, arg3);
        let v1 = 0x1::bcs::to_bytes<IntentMessage<T1>>(&v0);
        0x2::ed25519::ed25519_verify(arg4, &arg0.pk, &v1)
    }

    // decompiled from Move bytecode v6
}

