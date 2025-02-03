module 0xb3c3bc0451b63705fc67c951119b67596f51cf8184e8f83a751d3582ae576423::oracle_version {
    public fun next_version() : u64 {
        0xb3c3bc0451b63705fc67c951119b67596f51cf8184e8f83a751d3582ae576423::oracle_constants::version() + 1
    }

    public fun pre_check_version(arg0: u64) {
        assert!(arg0 == 0xb3c3bc0451b63705fc67c951119b67596f51cf8184e8f83a751d3582ae576423::oracle_constants::version(), 0xb3c3bc0451b63705fc67c951119b67596f51cf8184e8f83a751d3582ae576423::oracle_error::incorrect_version());
    }

    public fun this_version() : u64 {
        0xb3c3bc0451b63705fc67c951119b67596f51cf8184e8f83a751d3582ae576423::oracle_constants::version()
    }

    // decompiled from Move bytecode v6
}

