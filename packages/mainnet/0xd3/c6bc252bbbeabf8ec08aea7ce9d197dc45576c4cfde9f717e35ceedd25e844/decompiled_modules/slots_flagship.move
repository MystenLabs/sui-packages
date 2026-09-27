module 0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::slots_flagship {
    public fun config_v1() : 0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::slot_config::SlotConfig {
        0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::slot_config::new(5, 3, 11, 0, 1, vector[x"00050a0709020406080a0509070803060a040905070801020a0609050804070a09030608", x"060308050a07000906040208050a030709060804050a07000903060208050a07040901", x"07040906080103050a070906000408050a02070309060801050a04070906030008050a02", x"0805000a070902040608050a03070906080405000a07030902060108050a0704090603", x"090608030a010507090806040a020509030708000a0609050408070a0306090208050a0704"], vector[vector[0, 0, 0, 100, 500, 2000], vector[0, 0, 0, 0, 0, 0], vector[0, 0, 0, 60, 200, 1000], vector[0, 0, 0, 40, 150, 600], vector[0, 0, 0, 30, 100, 400], vector[0, 0, 0, 20, 60, 300], vector[0, 0, 0, 10, 40, 200], vector[0, 0, 0, 10, 30, 150], vector[0, 0, 0, 8, 20, 100], vector[0, 0, 0, 6, 16, 80], vector[0, 0, 0, 5, 12, 60]], vector[0, 0, 0, 40, 200, 1000, 1000, 1000, 1000, 1000, 1000, 1000, 1000, 1000, 1000, 1000], vector[x"0101010101", x"0000000000", x"0202020202", x"0001020100", x"0201000102", x"0000010202", x"0202010000", x"0100000001", x"0102020201", x"0100010201", x"0102010001", x"0001000100", x"0201020102", x"0001010100", x"0201010102", x"0101000101", x"0101020101", x"0002000200", x"0200020002", x"0002020200"], 1, 3, 10, 10, 30, 2, 1, 10, 1000, 1000000, 0, 9600)
    }

    public fun machine_id() : u64 {
        1
    }

    public fun publish_v1(arg0: &mut 0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::pool::Pool, arg1: &0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::pool::AdminCap) : u64 {
        if (!0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::slots::machine_exists(arg0, 1)) {
            0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::slots::create_machine(arg0, arg1, 1, 0x1::string::utf8(b"Sui Slots Flagship"));
        };
        0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::slots::publish_version(arg0, arg1, 1, config_v1())
    }

    // decompiled from Move bytecode v7
}

