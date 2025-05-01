module 0x2f09771ec652de64d028a92448f445b4f264eec5df05de6d44ed3ae1abb0dc10::problem_a {
    struct Answer has copy, drop {
        answer: u64,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
    }

    public fun main(arg0: &mut 0x2::tx_context::TxContext) {
        solve(arg0);
    }

    fun solve(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Answer{answer: 1};
        0x2::event::emit<Answer>(v0);
    }

    // decompiled from Move bytecode v6
}

