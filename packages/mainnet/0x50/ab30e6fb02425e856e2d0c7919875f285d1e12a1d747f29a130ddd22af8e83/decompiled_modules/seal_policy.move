module 0x50ab30e6fb02425e856e2d0c7919875f285d1e12a1d747f29a130ddd22af8e83::seal_policy {
    struct MAILGATE has drop {
        dummy_field: bool,
    }

    struct WalletPK has drop {
        pk: vector<u8>,
    }

    entry fun create_enclave_config(arg0: &0x50ab30e6fb02425e856e2d0c7919875f285d1e12a1d747f29a130ddd22af8e83::caps::AdminCap<MAILGATE>, arg1: vector<u8>, arg2: bool, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = MAILGATE{dummy_field: false};
        let v1 = 0x50ab30e6fb02425e856e2d0c7919875f285d1e12a1d747f29a130ddd22af8e83::enclave::new_cap<MAILGATE>(v0, arg7);
        0x50ab30e6fb02425e856e2d0c7919875f285d1e12a1d747f29a130ddd22af8e83::enclave::create_enclave_config<MAILGATE>(&v1, 0x1::string::utf8(b"mailgate"), arg3, arg4, arg5, arg6, arg1, arg2, arg7);
        0x2::transfer::public_transfer<0x50ab30e6fb02425e856e2d0c7919875f285d1e12a1d747f29a130ddd22af8e83::enclave::Cap<MAILGATE>>(v1, 0x2::tx_context::sender(arg7));
    }

    entry fun register_enclave(arg0: &0x50ab30e6fb02425e856e2d0c7919875f285d1e12a1d747f29a130ddd22af8e83::enclave::EnclaveConfig<MAILGATE>, arg1: 0x2::nitro_attestation::NitroAttestationDocument, arg2: &mut 0x2::tx_context::TxContext) {
        0x50ab30e6fb02425e856e2d0c7919875f285d1e12a1d747f29a130ddd22af8e83::enclave::register_enclave<MAILGATE>(arg0, arg1, arg2);
    }

    entry fun admit_pcrs(arg0: &mut 0x50ab30e6fb02425e856e2d0c7919875f285d1e12a1d747f29a130ddd22af8e83::enclave::EnclaveConfig<MAILGATE>, arg1: &0x50ab30e6fb02425e856e2d0c7919875f285d1e12a1d747f29a130ddd22af8e83::caps::AdminCap<MAILGATE>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>) {
        0x50ab30e6fb02425e856e2d0c7919875f285d1e12a1d747f29a130ddd22af8e83::enclave::admit_pcrs_admin<MAILGATE>(arg0, arg2, arg3, arg4, arg5);
    }

    entry fun admit_pcrs_pcu(arg0: &mut 0x50ab30e6fb02425e856e2d0c7919875f285d1e12a1d747f29a130ddd22af8e83::enclave::EnclaveConfig<MAILGATE>, arg1: &0x50ab30e6fb02425e856e2d0c7919875f285d1e12a1d747f29a130ddd22af8e83::caps::PcrUpdateCap<MAILGATE>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>) {
        0x50ab30e6fb02425e856e2d0c7919875f285d1e12a1d747f29a130ddd22af8e83::enclave::admit_pcrs_with_pcu<MAILGATE>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = MAILGATE{dummy_field: false};
        let v1 = 0x50ab30e6fb02425e856e2d0c7919875f285d1e12a1d747f29a130ddd22af8e83::enclave::new_cap<MAILGATE>(v0, arg0);
        0x50ab30e6fb02425e856e2d0c7919875f285d1e12a1d747f29a130ddd22af8e83::enclave::create_enclave_config<MAILGATE>(&v1, 0x1::string::utf8(b"mailgate"), b"", b"", b"", b"", b"legacy", false, arg0);
        0x2::transfer::public_transfer<0x50ab30e6fb02425e856e2d0c7919875f285d1e12a1d747f29a130ddd22af8e83::enclave::Cap<MAILGATE>>(v1, 0x2::tx_context::sender(arg0));
    }

    fun is_timestamp_fresh(arg0: u64, arg1: u64) : bool {
        arg0 <= arg1 && arg1 - arg0 <= 300000
    }

    fun pk_to_address(arg0: &vector<u8>) : vector<u8> {
        let v0 = x"00";
        0x1::vector::append<u8>(&mut v0, *arg0);
        0x2::hash::blake2b256(&v0)
    }

    entry fun register_bootstrap_pk(arg0: &mut 0x50ab30e6fb02425e856e2d0c7919875f285d1e12a1d747f29a130ddd22af8e83::enclave::EnclaveConfig<MAILGATE>, arg1: 0x2::nitro_attestation::NitroAttestationDocument, arg2: vector<u8>) {
        let v0 = 0x2::nitro_attestation::public_key(&arg1);
        assert!(0x1::option::is_some<vector<u8>>(v0), 0);
        assert!(0x1::option::borrow<vector<u8>>(v0) == &arg2, 0);
        0x50ab30e6fb02425e856e2d0c7919875f285d1e12a1d747f29a130ddd22af8e83::enclave::assert_attestation_matches_config<MAILGATE>(arg0, &arg1);
        0x50ab30e6fb02425e856e2d0c7919875f285d1e12a1d747f29a130ddd22af8e83::enclave::set_bootstrap_pk<MAILGATE>(arg0, arg2);
    }

    entry fun retire_pcrs(arg0: &mut 0x50ab30e6fb02425e856e2d0c7919875f285d1e12a1d747f29a130ddd22af8e83::enclave::EnclaveConfig<MAILGATE>, arg1: &0x50ab30e6fb02425e856e2d0c7919875f285d1e12a1d747f29a130ddd22af8e83::caps::AdminCap<MAILGATE>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>) {
        0x50ab30e6fb02425e856e2d0c7919875f285d1e12a1d747f29a130ddd22af8e83::enclave::retire_pcrs_admin<MAILGATE>(arg0, arg2, arg3, arg4, arg5);
    }

    entry fun retire_pcrs_pcu(arg0: &mut 0x50ab30e6fb02425e856e2d0c7919875f285d1e12a1d747f29a130ddd22af8e83::enclave::EnclaveConfig<MAILGATE>, arg1: &0x50ab30e6fb02425e856e2d0c7919875f285d1e12a1d747f29a130ddd22af8e83::caps::PcrUpdateCap<MAILGATE>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>) {
        0x50ab30e6fb02425e856e2d0c7919875f285d1e12a1d747f29a130ddd22af8e83::enclave::retire_pcrs_with_pcu<MAILGATE>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    entry fun seal_approve(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: u64, arg4: &0x50ab30e6fb02425e856e2d0c7919875f285d1e12a1d747f29a130ddd22af8e83::enclave::Enclave<MAILGATE>, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        assert!(arg0 == x"00", 0);
        assert!(0x2::address::to_bytes(0x2::tx_context::sender(arg6)) == pk_to_address(&arg2), 0);
        assert!(is_timestamp_fresh(arg3, 0x2::clock::timestamp_ms(arg5)), 1);
        let v0 = WalletPK{pk: arg2};
        let v1 = 0x50ab30e6fb02425e856e2d0c7919875f285d1e12a1d747f29a130ddd22af8e83::enclave::create_intent_message<WalletPK>(1, arg3, v0);
        let v2 = 0x2::bcs::to_bytes<0x50ab30e6fb02425e856e2d0c7919875f285d1e12a1d747f29a130ddd22af8e83::enclave::IntentMessage<WalletPK>>(&v1);
        assert!(0x2::ed25519::ed25519_verify(&arg1, 0x50ab30e6fb02425e856e2d0c7919875f285d1e12a1d747f29a130ddd22af8e83::enclave::pk<MAILGATE>(arg4), &v2), 0);
    }

    entry fun seal_approve_delegate<T0>(arg0: vector<u8>, arg1: &0x50ab30e6fb02425e856e2d0c7919875f285d1e12a1d747f29a130ddd22af8e83::mailgate::MailGateAccount<T0>, arg2: &0x2::tx_context::TxContext) {
        0x50ab30e6fb02425e856e2d0c7919875f285d1e12a1d747f29a130ddd22af8e83::mailgate::assert_authorized<T0>(arg1, 0x2::tx_context::sender(arg2), 1);
    }

    entry fun seal_approve_email<T0>(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: u64, arg4: &0x50ab30e6fb02425e856e2d0c7919875f285d1e12a1d747f29a130ddd22af8e83::mailgate::MailGateAccount<T0>, arg5: &0x50ab30e6fb02425e856e2d0c7919875f285d1e12a1d747f29a130ddd22af8e83::enclave::Enclave<MAILGATE>, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) {
        assert!(arg0 == 0x50ab30e6fb02425e856e2d0c7919875f285d1e12a1d747f29a130ddd22af8e83::mailgate::get_email_hash<T0>(arg4), 0);
        assert!(0x2::address::to_bytes(0x2::tx_context::sender(arg7)) == pk_to_address(&arg2), 0);
        assert!(is_timestamp_fresh(arg3, 0x2::clock::timestamp_ms(arg6)), 1);
        let v0 = WalletPK{pk: arg2};
        let v1 = 0x50ab30e6fb02425e856e2d0c7919875f285d1e12a1d747f29a130ddd22af8e83::enclave::create_intent_message<WalletPK>(1, arg3, v0);
        let v2 = 0x2::bcs::to_bytes<0x50ab30e6fb02425e856e2d0c7919875f285d1e12a1d747f29a130ddd22af8e83::enclave::IntentMessage<WalletPK>>(&v1);
        assert!(0x2::ed25519::ed25519_verify(&arg1, 0x50ab30e6fb02425e856e2d0c7919875f285d1e12a1d747f29a130ddd22af8e83::enclave::pk<MAILGATE>(arg5), &v2), 0);
    }

    entry fun seal_approve_enclave_bootstrap(arg0: vector<u8>, arg1: vector<u8>, arg2: &0x50ab30e6fb02425e856e2d0c7919875f285d1e12a1d747f29a130ddd22af8e83::enclave::EnclaveConfig<MAILGATE>, arg3: &0x2::tx_context::TxContext) {
        seal_approve_enclave_bootstrap_impl(arg0, arg1, arg2, arg3);
    }

    public fun seal_approve_enclave_bootstrap_impl(arg0: vector<u8>, arg1: vector<u8>, arg2: &0x50ab30e6fb02425e856e2d0c7919875f285d1e12a1d747f29a130ddd22af8e83::enclave::EnclaveConfig<MAILGATE>, arg3: &0x2::tx_context::TxContext) {
        assert!(arg0 == seal_identity_for_env(0x50ab30e6fb02425e856e2d0c7919875f285d1e12a1d747f29a130ddd22af8e83::enclave::environment<MAILGATE>(arg2)), 2);
        assert!(0x2::address::to_bytes(0x2::tx_context::sender(arg3)) == pk_to_address(&arg1), 0);
        let v0 = 0x50ab30e6fb02425e856e2d0c7919875f285d1e12a1d747f29a130ddd22af8e83::enclave::bootstrap_pk<MAILGATE>(arg2);
        assert!(0x1::option::is_some<vector<u8>>(v0), 0);
        assert!(0x1::option::borrow<vector<u8>>(v0) == &arg1, 0);
    }

    public fun seal_identity_for_env(arg0: &vector<u8>) : vector<u8> {
        let v0 = b"mailgate:enclave-master-seed:";
        0x1::vector::append<u8>(&mut v0, *arg0);
        0x1::vector::append<u8>(&mut v0, b":v1");
        v0
    }

    entry fun update_enclave(arg0: &mut 0x50ab30e6fb02425e856e2d0c7919875f285d1e12a1d747f29a130ddd22af8e83::enclave::EnclaveConfig<MAILGATE>, arg1: &0x50ab30e6fb02425e856e2d0c7919875f285d1e12a1d747f29a130ddd22af8e83::caps::AdminCap<MAILGATE>, arg2: &mut 0x50ab30e6fb02425e856e2d0c7919875f285d1e12a1d747f29a130ddd22af8e83::enclave::Enclave<MAILGATE>, arg3: 0x2::nitro_attestation::NitroAttestationDocument) {
        0x50ab30e6fb02425e856e2d0c7919875f285d1e12a1d747f29a130ddd22af8e83::enclave::update_from_attestation_admin<MAILGATE>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v7
}

