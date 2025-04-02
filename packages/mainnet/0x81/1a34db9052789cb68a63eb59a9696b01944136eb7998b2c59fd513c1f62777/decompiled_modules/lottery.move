module 0x811a34db9052789cb68a63eb59a9696b01944136eb7998b2c59fd513c1f62777::lottery {
    struct LotteryResult has store, key {
        id: 0x2::object::UID,
        numbers: vector<u8>,
    }

    public entry fun generate_lottery_numbers(arg0: &0x2::random::Random, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::random::new_generator(arg0, arg1);
        let v1 = 0x1::vector::empty<u8>();
        let v2 = 0;
        while (v2 < 6) {
            0x1::vector::push_back<u8>(&mut v1, 0x2::random::generate_u8_in_range(&mut v0, 1, 49));
            v2 = v2 + 1;
        };
        let v3 = LotteryResult{
            id      : 0x2::object::new(arg1),
            numbers : v1,
        };
        0x2::transfer::transfer<LotteryResult>(v3, 0x2::tx_context::sender(arg1));
    }

    public fun get_numbers(arg0: &LotteryResult) : &vector<u8> {
        &arg0.numbers
    }

    // decompiled from Move bytecode v6
}

