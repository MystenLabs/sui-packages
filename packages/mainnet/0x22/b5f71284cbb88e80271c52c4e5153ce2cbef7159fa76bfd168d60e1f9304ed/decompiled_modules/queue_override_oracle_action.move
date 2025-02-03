module 0x22b5f71284cbb88e80271c52c4e5153ce2cbef7159fa76bfd168d60e1f9304ed::queue_override_oracle_action {
    struct QueueOracleOverride has copy, drop {
        queue_id: 0x2::object::ID,
        oracle_id: 0x2::object::ID,
        secp256k1_key: vector<u8>,
        mr_enclave: vector<u8>,
        expiration_time_ms: u64,
    }

    fun actuate(arg0: &mut 0x22b5f71284cbb88e80271c52c4e5153ce2cbef7159fa76bfd168d60e1f9304ed::oracle::Oracle, arg1: &mut 0x22b5f71284cbb88e80271c52c4e5153ce2cbef7159fa76bfd168d60e1f9304ed::queue::Queue, arg2: vector<u8>, arg3: vector<u8>, arg4: u64, arg5: &0x2::clock::Clock) {
        0x22b5f71284cbb88e80271c52c4e5153ce2cbef7159fa76bfd168d60e1f9304ed::oracle::enable_oracle(arg0, arg2, arg3, arg4);
        0x22b5f71284cbb88e80271c52c4e5153ce2cbef7159fa76bfd168d60e1f9304ed::queue::set_last_queue_override_ms(arg1, 0x2::clock::timestamp_ms(arg5));
        let v0 = QueueOracleOverride{
            queue_id           : 0x22b5f71284cbb88e80271c52c4e5153ce2cbef7159fa76bfd168d60e1f9304ed::queue::id(arg1),
            oracle_id          : 0x22b5f71284cbb88e80271c52c4e5153ce2cbef7159fa76bfd168d60e1f9304ed::oracle::id(arg0),
            secp256k1_key      : arg2,
            mr_enclave         : arg3,
            expiration_time_ms : arg4,
        };
        0x2::event::emit<QueueOracleOverride>(v0);
    }

    public entry fun run(arg0: &mut 0x22b5f71284cbb88e80271c52c4e5153ce2cbef7159fa76bfd168d60e1f9304ed::queue::Queue, arg1: &mut 0x22b5f71284cbb88e80271c52c4e5153ce2cbef7159fa76bfd168d60e1f9304ed::oracle::Oracle, arg2: vector<u8>, arg3: vector<u8>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        validate(arg0, arg1, arg4, arg6);
        actuate(arg1, arg0, arg2, arg3, arg4, arg5);
    }

    public fun validate(arg0: &0x22b5f71284cbb88e80271c52c4e5153ce2cbef7159fa76bfd168d60e1f9304ed::queue::Queue, arg1: &0x22b5f71284cbb88e80271c52c4e5153ce2cbef7159fa76bfd168d60e1f9304ed::oracle::Oracle, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x22b5f71284cbb88e80271c52c4e5153ce2cbef7159fa76bfd168d60e1f9304ed::queue::version(arg0) == 1, 9223372200064122890);
        assert!(0x22b5f71284cbb88e80271c52c4e5153ce2cbef7159fa76bfd168d60e1f9304ed::oracle::version(arg1) == 1, 9223372204359221260);
        assert!(0x22b5f71284cbb88e80271c52c4e5153ce2cbef7159fa76bfd168d60e1f9304ed::queue::queue_key(arg0) == 0x22b5f71284cbb88e80271c52c4e5153ce2cbef7159fa76bfd168d60e1f9304ed::oracle::queue_key(arg1), 9223372208653926408);
        assert!(0x22b5f71284cbb88e80271c52c4e5153ce2cbef7159fa76bfd168d60e1f9304ed::queue::id(arg0) == 0x22b5f71284cbb88e80271c52c4e5153ce2cbef7159fa76bfd168d60e1f9304ed::oracle::queue(arg1), 9223372212948762630);
        assert!(0x22b5f71284cbb88e80271c52c4e5153ce2cbef7159fa76bfd168d60e1f9304ed::queue::has_authority(arg0, arg3), 9223372217243467778);
        assert!(arg2 > 0, 9223372221538566148);
    }

    // decompiled from Move bytecode v6
}

