module 0xc8906ad5bebb9c50e786a3246791cdd2e95c304596574a68647c2d48de69afe8::enclave {
    struct EnclavePolicy<phantom T0: drop> has key {
        id: 0x2::object::UID,
        pcrs: Pcrs,
        version: u64,
    }

    struct EnclavePolicyAdminCap<phantom T0: drop> has store, key {
        id: 0x2::object::UID,
    }

    struct Pcrs has copy, drop, store {
        pos0: vector<u8>,
        pos1: vector<u8>,
        pos2: vector<u8>,
    }

    struct IntentMessage<T0: drop> has copy, drop {
        intent: u8,
        timestamp_ms: u64,
        payload: T0,
    }

    struct EnclaveKey has copy, drop, store {
        pos0: vector<u8>,
    }

    struct EnclavePolicyAdminCapKey has copy, drop, store {
        dummy_field: bool,
    }

    struct EnclavePolicyCreatedEvent<phantom T0> has copy, drop {
        policy_id: 0x2::object::ID,
    }

    struct EnclavePolicyPcrsSetEvent<phantom T0> has copy, drop {
        policy_id: 0x2::object::ID,
        version: u64,
        pcr0: vector<u8>,
        pcr1: vector<u8>,
        pcr2: vector<u8>,
    }

    struct EnclaveRegisteredEvent<phantom T0> has copy, drop {
        policy_id: 0x2::object::ID,
        pk: vector<u8>,
        version: u64,
    }

    struct EnclaveStaleRemovedEvent<phantom T0> has copy, drop {
        policy_id: 0x2::object::ID,
        pk: vector<u8>,
        version: u64,
    }

    fun add<T0: drop>(arg0: &mut EnclavePolicy<T0>, arg1: vector<u8>, arg2: u64) {
        assert!(!is_registered<T0>(arg0, arg1), 9);
        let v0 = EnclaveKey{pos0: arg1};
        0x2::dynamic_field::add<EnclaveKey, u64>(&mut arg0.id, v0, arg2);
    }

    fun remove<T0: drop>(arg0: &mut EnclavePolicy<T0>, arg1: vector<u8>) : u64 {
        assert!(is_registered<T0>(arg0, arg1), 10);
        let v0 = EnclaveKey{pos0: arg1};
        0x2::dynamic_field::remove<EnclaveKey, u64>(&mut arg0.id, v0)
    }

    public fun new<T0: drop>(arg0: T0, arg1: &mut 0x2::tx_context::TxContext) : (EnclavePolicy<T0>, EnclavePolicyAdminCap<T0>) {
        assert!(0x2::types::is_one_time_witness<T0>(&arg0), 0);
        create<T0>(arg1)
    }

    fun assert_valid_pcr(arg0: &vector<u8>) {
        assert!(0x1::vector::length<u8>(arg0) == 48, 2);
        let v0 = 0;
        let v1;
        while (v0 < 0x1::vector::length<u8>(arg0)) {
            if (*0x1::vector::borrow<u8>(arg0, v0) != 0) {
                v1 = true;
                /* label 9 */
                assert!(v1, 3);
                return
            };
            v0 = v0 + 1;
        };
        v1 = false;
        /* goto 9 */
    }

    fun authorize<T0: drop>(arg0: &EnclavePolicy<T0>, arg1: &EnclavePolicyAdminCap<T0>) {
        let v0 = 0x2::object::id<EnclavePolicyAdminCap<T0>>(arg1);
        assert!(0x2::object::id_to_address(&v0) == derive_admin_cap_address<T0>(arg0), 1);
    }

    fun checked_public_key(arg0: 0x1::option::Option<vector<u8>>) : vector<u8> {
        if (0x1::option::is_some<vector<u8>>(&arg0)) {
            let v0 = 0x1::option::destroy_some<vector<u8>>(arg0);
            assert!(0x1::vector::length<u8>(&v0) == 32, 8);
            return v0
        } else {
            0x1::option::destroy_none<vector<u8>>(arg0);
            abort 7
        };
    }

    fun create<T0: drop>(arg0: &mut 0x2::tx_context::TxContext) : (EnclavePolicy<T0>, EnclavePolicyAdminCap<T0>) {
        let v0 = Pcrs{
            pos0 : b"",
            pos1 : b"",
            pos2 : b"",
        };
        let v1 = EnclavePolicy<T0>{
            id      : 0x2::object::new(arg0),
            pcrs    : v0,
            version : 0,
        };
        let v2 = EnclavePolicyAdminCapKey{dummy_field: false};
        let v3 = EnclavePolicyAdminCap<T0>{id: 0x2::derived_object::claim<EnclavePolicyAdminCapKey>(&mut v1.id, v2)};
        let v4 = EnclavePolicyCreatedEvent<T0>{policy_id: 0x2::object::id<EnclavePolicy<T0>>(&v1)};
        0x2::event::emit<EnclavePolicyCreatedEvent<T0>>(v4);
        (v1, v3)
    }

    public fun create_intent_message<T0: drop>(arg0: u8, arg1: u64, arg2: T0) : IntentMessage<T0> {
        IntentMessage<T0>{
            intent       : arg0,
            timestamp_ms : arg1,
            payload      : arg2,
        }
    }

    public fun derive_admin_cap_address<T0: drop>(arg0: &EnclavePolicy<T0>) : address {
        let v0 = EnclavePolicyAdminCapKey{dummy_field: false};
        0x2::derived_object::derive_address<EnclavePolicyAdminCapKey>(0x2::object::id<EnclavePolicy<T0>>(arg0), v0)
    }

    public fun is_registered<T0: drop>(arg0: &EnclavePolicy<T0>, arg1: vector<u8>) : bool {
        let v0 = EnclaveKey{pos0: arg1};
        0x2::dynamic_field::exists<EnclaveKey>(&arg0.id, v0)
    }

    fun load_pk<T0: drop>(arg0: &EnclavePolicy<T0>, arg1: &0x2::nitro_attestation::NitroAttestationDocument) : vector<u8> {
        let v0 = 0x2::nitro_attestation::pcrs(arg1);
        let v1 = Pcrs{
            pos0 : pcr_at(v0, 0),
            pos1 : pcr_at(v0, 1),
            pos2 : pcr_at(v0, 2),
        };
        assert!(v1 == arg0.pcrs, 5);
        checked_public_key(*0x2::nitro_attestation::public_key(arg1))
    }

    public fun pcr0<T0: drop>(arg0: &EnclavePolicy<T0>) : &vector<u8> {
        &arg0.pcrs.pos0
    }

    public fun pcr1<T0: drop>(arg0: &EnclavePolicy<T0>) : &vector<u8> {
        &arg0.pcrs.pos1
    }

    public fun pcr2<T0: drop>(arg0: &EnclavePolicy<T0>) : &vector<u8> {
        &arg0.pcrs.pos2
    }

    fun pcr_at(arg0: &vector<0x2::nitro_attestation::PCREntry>, arg1: u8) : vector<u8> {
        let v0 = 0;
        let v1;
        while (v0 < 0x1::vector::length<0x2::nitro_attestation::PCREntry>(arg0)) {
            if (0x2::nitro_attestation::index(0x1::vector::borrow<0x2::nitro_attestation::PCREntry>(arg0, v0)) == arg1) {
                v1 = 0x1::option::some<u64>(v0);
                /* label 4 */
                if (0x1::option::is_some<u64>(&v1)) {
                    return *0x2::nitro_attestation::value(0x1::vector::borrow<0x2::nitro_attestation::PCREntry>(arg0, 0x1::option::destroy_some<u64>(v1)))
                } else {
                    0x1::option::destroy_none<u64>(v1);
                    abort 6
                };
            };
            v0 = v0 + 1;
        };
        v1 = 0x1::option::none<u64>();
        /* goto 4 */
    }

    public fun register<T0: drop>(arg0: &mut EnclavePolicy<T0>, arg1: 0x2::nitro_attestation::NitroAttestationDocument) {
        let v0 = load_pk<T0>(arg0, &arg1);
        let v1 = arg0.version;
        add<T0>(arg0, v0, v1);
        let v2 = EnclaveRegisteredEvent<T0>{
            policy_id : 0x2::object::id<EnclavePolicy<T0>>(arg0),
            pk        : v0,
            version   : v1,
        };
        0x2::event::emit<EnclaveRegisteredEvent<T0>>(v2);
    }

    public fun registered_version<T0: drop>(arg0: &EnclavePolicy<T0>, arg1: vector<u8>) : u64 {
        assert!(is_registered<T0>(arg0, arg1), 10);
        let v0 = EnclaveKey{pos0: arg1};
        *0x2::dynamic_field::borrow<EnclaveKey, u64>(&arg0.id, v0)
    }

    public fun remove_stale<T0: drop>(arg0: &mut EnclavePolicy<T0>, arg1: vector<u8>) {
        let v0 = remove<T0>(arg0, arg1);
        assert!(v0 < arg0.version, 12);
        let v1 = EnclaveStaleRemovedEvent<T0>{
            policy_id : 0x2::object::id<EnclavePolicy<T0>>(arg0),
            pk        : arg1,
            version   : v0,
        };
        0x2::event::emit<EnclaveStaleRemovedEvent<T0>>(v1);
    }

    public fun set_pcrs<T0: drop>(arg0: &mut EnclavePolicy<T0>, arg1: &EnclavePolicyAdminCap<T0>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>) {
        authorize<T0>(arg0, arg1);
        assert_valid_pcr(&arg2);
        assert_valid_pcr(&arg3);
        assert_valid_pcr(&arg4);
        let v0 = Pcrs{
            pos0 : arg2,
            pos1 : arg3,
            pos2 : arg4,
        };
        assert!(v0 != arg0.pcrs, 4);
        arg0.version = arg0.version + 1;
        arg0.pcrs = v0;
        let v1 = EnclavePolicyPcrsSetEvent<T0>{
            policy_id : 0x2::object::id<EnclavePolicy<T0>>(arg0),
            version   : arg0.version,
            pcr0      : arg2,
            pcr1      : arg3,
            pcr2      : arg4,
        };
        0x2::event::emit<EnclavePolicyPcrsSetEvent<T0>>(v1);
    }

    public fun share<T0: drop>(arg0: EnclavePolicy<T0>) {
        0x2::transfer::share_object<EnclavePolicy<T0>>(arg0);
    }

    public fun verify_signature<T0: drop, T1: drop>(arg0: &EnclavePolicy<T0>, arg1: vector<u8>, arg2: u8, arg3: u64, arg4: T1, arg5: &vector<u8>) {
        assert!(registered_version<T0>(arg0, arg1) == arg0.version, 11);
        let v0 = create_intent_message<T1>(arg2, arg3, arg4);
        let v1 = 0x1::bcs::to_bytes<IntentMessage<T1>>(&v0);
        assert!(0x2::ed25519::ed25519_verify(arg5, &arg1, &v1), 13);
    }

    public fun version<T0: drop>(arg0: &EnclavePolicy<T0>) : u64 {
        arg0.version
    }

    // decompiled from Move bytecode v7
}

