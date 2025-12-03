module 0xa824359b3507f1255dc6d4daf29383aab5ae77e726effeac3922b6f1fc29da67::oracle_utils {
    struct OracleConfig has key {
        id: 0x2::object::UID,
        public_key: vector<u8>,
        admin: address,
    }

    struct OraclePublicKeyUpdatedEvent has copy, drop {
        old_key: vector<u8>,
        new_key: vector<u8>,
        timestamp: u64,
    }

    public fun get_oracle_admin(arg0: &OracleConfig) : address {
        arg0.admin
    }

    public fun get_oracle_public_key(arg0: &OracleConfig) : vector<u8> {
        arg0.public_key
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = OracleConfig{
            id         : 0x2::object::new(arg0),
            public_key : x"7f55f796aed7c4b78376223f0a3a7091a45d9fee9d5ae964ee0ca61b50c97556",
            admin      : 0x2::tx_context::sender(arg0),
        };
        0x2::transfer::share_object<OracleConfig>(v0);
    }

    public fun transfer_admin(arg0: &mut OracleConfig, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 2);
        arg0.admin = arg1;
    }

    public fun update_oracle_public_key(arg0: &mut OracleConfig, arg1: vector<u8>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 2);
        assert!(0x1::vector::length<u8>(&arg1) == 32, 13906834410566582273);
        arg0.public_key = arg1;
        let v0 = OraclePublicKeyUpdatedEvent{
            old_key   : arg0.public_key,
            new_key   : arg1,
            timestamp : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<OraclePublicKeyUpdatedEvent>(v0);
    }

    public fun validate_oracle_public_key(arg0: &vector<u8>) {
        assert!(0x1::vector::length<u8>(arg0) == 32, 13906834582365274113);
    }

    public fun verify_oracle_signature(arg0: &vector<u8>, arg1: &vector<u8>, arg2: &vector<u8>) {
        assert!(0x1::vector::length<u8>(arg1) == 32, 13906834548005535745);
        assert!(0x1::vector::length<u8>(arg2) == 64, 13906834552300503041);
        assert!(0x2::ed25519::ed25519_verify(arg2, arg1, arg0), 3);
    }

    // decompiled from Move bytecode v6
}

