module 0x386a0e6aba0abcc1527560632ad5803b8a80e0d8649cbc4d06325c0c0478a8f1::utils {
    public entry fun destroy_zero<T0>(arg0: 0x2::coin::Coin<T0>) {
        0x2::coin::destroy_zero<T0>(arg0);
    }

    // decompiled from Move bytecode v6
}

