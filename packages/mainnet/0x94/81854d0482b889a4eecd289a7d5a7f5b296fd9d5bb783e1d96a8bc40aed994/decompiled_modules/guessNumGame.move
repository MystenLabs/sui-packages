module 0x9481854d0482b889a4eecd289a7d5a7f5b296fd9d5bb783e1d96a8bc40aed994::guessNumGame {
    struct RandomKey has store, key {
        id: 0x2::object::UID,
        value: u64,
        count: u64,
    }

    struct GuessResult has store, key {
        id: 0x2::object::UID,
        count: u64,
        win: bool,
        yourNum: u64,
        actualNum: u64,
    }

    public entry fun StartGame(arg0: u64, arg1: &mut RandomKey, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = generate_pseudo_random_number(arg1.value);
        let v1 = false;
        if (v0 == arg0) {
            v1 = true;
        };
        arg1.count = arg1.count + 1;
        let v2 = GuessResult{
            id        : 0x2::object::new(arg2),
            count     : arg1.count,
            win       : v1,
            yourNum   : arg0,
            actualNum : v0,
        };
        arg1.value = arg1.value + v0 + arg1.count;
        0x2::transfer::public_transfer<GuessResult>(v2, 0x2::tx_context::sender(arg2));
    }

    public fun generate_pseudo_random_number(arg0: u64) : u64 {
        arg0 % 6 + 1
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = RandomKey{
            id    : 0x2::object::new(arg0),
            value : 1,
            count : 0,
        };
        0x2::transfer::share_object<RandomKey>(v0);
    }

    // decompiled from Move bytecode v6
}

