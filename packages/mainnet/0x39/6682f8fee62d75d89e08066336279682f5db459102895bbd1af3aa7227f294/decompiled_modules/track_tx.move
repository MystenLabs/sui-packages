module 0x396682f8fee62d75d89e08066336279682f5db459102895bbd1af3aa7227f294::track_tx {
    struct TxEvent has copy, drop {
        tx_id: vector<u8>,
        tx_type: vector<u8>,
    }

    public fun track(arg0: vector<u8>, arg1: vector<u8>) {
        let v0 = TxEvent{
            tx_id   : arg0,
            tx_type : arg1,
        };
        0x2::event::emit<TxEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

