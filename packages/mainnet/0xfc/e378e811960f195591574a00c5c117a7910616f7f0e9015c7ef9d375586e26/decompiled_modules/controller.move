module 0xfce378e811960f195591574a00c5c117a7910616f7f0e9015c7ef9d375586e26::controller {
    public entry fun pause(arg0: &mut 0xfce378e811960f195591574a00c5c117a7910616f7f0e9015c7ef9d375586e26::implements::Global, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(!0xfce378e811960f195591574a00c5c117a7910616f7f0e9015c7ef9d375586e26::implements::is_emergency(arg0), 202);
        assert!(0xfce378e811960f195591574a00c5c117a7910616f7f0e9015c7ef9d375586e26::implements::controller(arg0) == 0x2::tx_context::sender(arg1), 201);
        0xfce378e811960f195591574a00c5c117a7910616f7f0e9015c7ef9d375586e26::implements::pause(arg0);
    }

    public entry fun resume(arg0: &mut 0xfce378e811960f195591574a00c5c117a7910616f7f0e9015c7ef9d375586e26::implements::Global, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0xfce378e811960f195591574a00c5c117a7910616f7f0e9015c7ef9d375586e26::implements::is_emergency(arg0), 203);
        assert!(0xfce378e811960f195591574a00c5c117a7910616f7f0e9015c7ef9d375586e26::implements::controller(arg0) == 0x2::tx_context::sender(arg1), 201);
        0xfce378e811960f195591574a00c5c117a7910616f7f0e9015c7ef9d375586e26::implements::resume(arg0);
    }

    // decompiled from Move bytecode v6
}

