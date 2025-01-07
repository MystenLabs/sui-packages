module 0x53be4c223a9290411d35ed6718e009813448a844c975063afdc25f9ae6e7e3c6::noop {
    struct MetaData has copy, drop {
        creator: address,
        metadata: vector<u8>,
    }

    public entry fun noop() {
    }

    public entry fun noop_w_metadata(arg0: vector<u8>) {
    }

    public entry fun noop_w_metadata_event(arg0: vector<u8>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = MetaData{
            creator  : 0x2::tx_context::sender(arg1),
            metadata : arg0,
        };
        0x2::event::emit<MetaData>(v0);
    }

    // decompiled from Move bytecode v6
}

