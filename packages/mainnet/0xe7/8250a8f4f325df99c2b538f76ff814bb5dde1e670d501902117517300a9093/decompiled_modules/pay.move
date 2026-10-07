module 0xe78250a8f4f325df99c2b538f76ff814bb5dde1e670d501902117517300a9093::pay {
    public fun pay<T0>(arg0: 0x2::balance::Balance<T0>, arg1: address) {
        0x2::balance::send_funds<T0>(arg0, arg1);
    }

    // decompiled from Move bytecode v7
}

