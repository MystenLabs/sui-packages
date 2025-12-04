module 0x2::event {
    native public fun emit<T0: copy + drop>(arg0: T0);
    public fun emit_authenticated<T0: copy + drop>(arg0: T0) {
        let v0 = 0x1::type_name::original_id<T0>();
        emit_authenticated_impl<0x2::accumulator_settlement::EventStreamHead, T0>(0x2::accumulator::accumulator_address<0x2::accumulator_settlement::EventStreamHead>(v0), v0, arg0);
    }

    native fun emit_authenticated_impl<T0, T1: copy + drop>(arg0: address, arg1: address, arg2: T1);
    // decompiled from Move bytecode v6
}

