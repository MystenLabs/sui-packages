module 0x63eca087f3d3d05f97cbcc7f44208051ddc43b758b9fdf8fdb0f6d170a4fd101::problem_a {
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

