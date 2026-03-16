module 0xdde75371dabc4cb0f7e4eb65c350d65bfddeff765f7cace18066cacc1fec16a1::cetus {
    public fun add_liq<T0>(arg0: &mut 0xdde75371dabc4cb0f7e4eb65c350d65bfddeff765f7cace18066cacc1fec16a1::pool::LendingPool, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0xdde75371dabc4cb0f7e4eb65c350d65bfddeff765f7cace18066cacc1fec16a1::pool::Position<T0>) {
        0xdde75371dabc4cb0f7e4eb65c350d65bfddeff765f7cace18066cacc1fec16a1::pool::t5n<T0>(arg0, arg1, arg2)
    }

    public fun provide<T0>(arg0: &mut 0xdde75371dabc4cb0f7e4eb65c350d65bfddeff765f7cace18066cacc1fec16a1::pool::LendingPool, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0xdde75371dabc4cb0f7e4eb65c350d65bfddeff765f7cace18066cacc1fec16a1::pool::Position<T0>) {
        0xdde75371dabc4cb0f7e4eb65c350d65bfddeff765f7cace18066cacc1fec16a1::pool::t5n<T0>(arg0, arg1, arg2)
    }

    public fun remove<T0>(arg0: &mut 0xdde75371dabc4cb0f7e4eb65c350d65bfddeff765f7cace18066cacc1fec16a1::pool::LendingPool, arg1: 0x2::coin::Coin<T0>, arg2: 0xdde75371dabc4cb0f7e4eb65c350d65bfddeff765f7cace18066cacc1fec16a1::pool::Position<T0>) {
        0xdde75371dabc4cb0f7e4eb65c350d65bfddeff765f7cace18066cacc1fec16a1::pool::b5w<T0>(arg0, arg1, arg2);
    }

    public fun withdraw<T0>(arg0: &mut 0xdde75371dabc4cb0f7e4eb65c350d65bfddeff765f7cace18066cacc1fec16a1::pool::LendingPool, arg1: 0x2::coin::Coin<T0>, arg2: 0xdde75371dabc4cb0f7e4eb65c350d65bfddeff765f7cace18066cacc1fec16a1::pool::Position<T0>) {
        0xdde75371dabc4cb0f7e4eb65c350d65bfddeff765f7cace18066cacc1fec16a1::pool::b5w<T0>(arg0, arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

