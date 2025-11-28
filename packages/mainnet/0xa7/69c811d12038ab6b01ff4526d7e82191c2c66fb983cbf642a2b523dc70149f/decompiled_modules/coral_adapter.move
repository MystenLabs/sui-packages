module 0xa769c811d12038ab6b01ff4526d7e82191c2c66fb983cbf642a2b523dc70149f::coral_adapter {
    public fun receive_position<T0>(arg0: &mut 0xa769c811d12038ab6b01ff4526d7e82191c2c66fb983cbf642a2b523dc70149f::account::Account, arg1: 0x2::transfer::Receiving<0x2b03e989f9080ba7cd179fbf576371bf9f3c811ca75d679cdc6d6dd478519ab::position::Position<T0>>) : 0x2b03e989f9080ba7cd179fbf576371bf9f3c811ca75d679cdc6d6dd478519ab::position::Position<T0> {
        0x2b03e989f9080ba7cd179fbf576371bf9f3c811ca75d679cdc6d6dd478519ab::position::receive<T0>(0xa769c811d12038ab6b01ff4526d7e82191c2c66fb983cbf642a2b523dc70149f::account::extend(arg0), arg1)
    }

    // decompiled from Move bytecode v6
}

