module 0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::job_init_action {
    struct JobConfigParams has copy, drop {
        name: vector<u8>,
        data: vector<u8>,
    }

    public entry fun run(arg0: vector<u8>, arg1: vector<u8>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::job::freeze_job(0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::job::new(arg0, arg1, 0x2::clock::timestamp_ms(arg2) / 1000, arg3));
    }

    // decompiled from Move bytecode v6
}

