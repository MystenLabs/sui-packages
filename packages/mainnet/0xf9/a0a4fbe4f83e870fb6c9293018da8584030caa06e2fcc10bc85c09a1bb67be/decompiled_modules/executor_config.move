module 0xf9a0a4fbe4f83e870fb6c9293018da8584030caa06e2fcc10bc85c09a1bb67be::executor_config {
    struct ExecutorConfig has copy, drop, store {
        max_message_size: u64,
        executor: address,
    }

    public fun new() : ExecutorConfig {
        ExecutorConfig{
            max_message_size : 0,
            executor         : @0x0,
        }
    }

    public fun assert_default_config(arg0: &ExecutorConfig) {
        assert!(arg0.max_message_size != 0, 3);
        assert!(arg0.executor != @0x0, 1);
    }

    public fun create(arg0: u64, arg1: address) : ExecutorConfig {
        ExecutorConfig{
            max_message_size : arg0,
            executor         : arg1,
        }
    }

    public fun deserialize(arg0: vector<u8>) : ExecutorConfig {
        let v0 = 0x2::bcs::new(arg0);
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::length<u8>(&v1) == 0, 2);
        create(0x2::bcs::peel_u64(&mut v0), 0x2::bcs::peel_address(&mut v0))
    }

    public fun executor(arg0: &ExecutorConfig) : address {
        arg0.executor
    }

    public fun get_effective_executor_config(arg0: &ExecutorConfig, arg1: &ExecutorConfig) : ExecutorConfig {
        let v0 = if (arg0.max_message_size != 0) {
            arg0.max_message_size
        } else {
            arg1.max_message_size
        };
        let v1 = if (arg0.executor != @0x0) {
            arg0.executor
        } else {
            arg1.executor
        };
        create(v0, v1)
    }

    public fun max_message_size(arg0: &ExecutorConfig) : u64 {
        arg0.max_message_size
    }

    // decompiled from Move bytecode v6
}

