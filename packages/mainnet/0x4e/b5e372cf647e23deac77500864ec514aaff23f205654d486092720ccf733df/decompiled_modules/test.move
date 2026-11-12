module 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::test {
    struct SignatureVerifiedEvent has copy, drop {
        is_verified: bool,
    }

    struct PublicKeyRecoveredEvent has copy, drop {
        public_key: vector<u8>,
    }

    struct HashGeneratedEvent has copy, drop {
        hash: vector<u8>,
    }

    struct OrderSerializedEvent has copy, drop {
        serialized_order: vector<u8>,
    }

    struct PublicAddressGeneratedEvent has copy, drop {
        addr: vector<u8>,
    }

    struct CoinValue has copy, drop {
        value: u64,
        type_name: 0x1::type_name::TypeName,
        name: 0x1::ascii::String,
        addr: 0x1::ascii::String,
    }

    public fun get_public_address(arg0: vector<u8>) {
        abort 999
    }

    public fun get_public_address_from_signed_order(arg0: address, arg1: address, arg2: u8, arg3: u128, arg4: u128, arg5: u128, arg6: u64, arg7: u128, arg8: vector<u8>, arg9: vector<u8>) {
        abort 999
    }

    public fun get_serialized_order(arg0: address, arg1: address, arg2: u8, arg3: u128, arg4: u128, arg5: u128, arg6: u64, arg7: u128) {
        abort 999
    }

    public fun hash(arg0: address, arg1: address) {
        abort 999
    }

    public fun verify_signature(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>) {
        abort 999
    }

    // decompiled from Move bytecode v7
}

