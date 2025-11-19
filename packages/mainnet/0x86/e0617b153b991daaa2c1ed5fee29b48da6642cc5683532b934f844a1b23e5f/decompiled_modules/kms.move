module 0x86e0617b153b991daaa2c1ed5fee29b48da6642cc5683532b934f844a1b23e5f::kms {
    struct SealRequest has copy, drop {
        timestamp_ms: u64,
        id: vector<u8>,
        requester: vector<u8>,
    }

    struct SetMasterKeyRequest has copy, drop {
        encrypted_key: vector<u8>,
    }

    struct EncryptedMasterKey has key {
        id: 0x2::object::UID,
        encrypted_key: vector<u8>,
        version: u64,
        updated_at: u64,
    }

    struct KMS has drop {
        dummy_field: bool,
    }

    fun check_enclave_access(arg0: vector<u8>, arg1: u64, arg2: &vector<u8>, arg3: &0xb5e176170a7aaa2a2d520b307abe7a31a97699c0127ef9b90c0e529d81ca33e8::enclave::Enclave<KMS>, arg4: &0x2::tx_context::TxContext) : bool {
        let v0 = SealRequest{
            timestamp_ms : arg1,
            id           : arg0,
            requester    : 0x2::address::to_bytes(0x2::tx_context::sender(arg4)),
        };
        0xb5e176170a7aaa2a2d520b307abe7a31a97699c0127ef9b90c0e529d81ca33e8::enclave::verify_signature<KMS, SealRequest>(arg3, 0, arg1, v0, arg2)
    }

    fun init(arg0: KMS, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0xb5e176170a7aaa2a2d520b307abe7a31a97699c0127ef9b90c0e529d81ca33e8::enclave::Cap<KMS>>(0xb5e176170a7aaa2a2d520b307abe7a31a97699c0127ef9b90c0e529d81ca33e8::enclave::new_cap<KMS>(arg0, arg1), 0x2::tx_context::sender(arg1));
        let v0 = EncryptedMasterKey{
            id            : 0x2::object::new(arg1),
            encrypted_key : 0x1::vector::empty<u8>(),
            version       : 0,
            updated_at    : 0,
        };
        0x2::transfer::share_object<EncryptedMasterKey>(v0);
    }

    entry fun seal_approve(arg0: vector<u8>, arg1: u64, arg2: vector<u8>, arg3: &0xb5e176170a7aaa2a2d520b307abe7a31a97699c0127ef9b90c0e529d81ca33e8::enclave::Enclave<KMS>, arg4: &0x2::tx_context::TxContext) {
        assert!(check_enclave_access(arg0, arg1, &arg2, arg3, arg4), 77);
    }

    public fun set_master_key(arg0: &mut EncryptedMasterKey, arg1: &0xb5e176170a7aaa2a2d520b307abe7a31a97699c0127ef9b90c0e529d81ca33e8::enclave::Enclave<KMS>, arg2: u64, arg3: vector<u8>, arg4: vector<u8>, arg5: &0x2::clock::Clock) {
        let v0 = SetMasterKeyRequest{encrypted_key: arg3};
        assert!(0xb5e176170a7aaa2a2d520b307abe7a31a97699c0127ef9b90c0e529d81ca33e8::enclave::verify_signature<KMS, SetMasterKeyRequest>(arg1, 1, arg2, v0, &arg4), 77);
        arg0.encrypted_key = arg3;
        arg0.version = arg0.version + 1;
        arg0.updated_at = 0x2::clock::timestamp_ms(arg5);
    }

    // decompiled from Move bytecode v6
}

