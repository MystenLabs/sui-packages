module 0x9ed50429ae12b4207c648d1f2f7d36b849d3a0227d8df6f45b5494c5f0a56e37::metadata {
    struct CustomMetadata has copy, drop {
        event_id: vector<u8>,
        data: vector<u8>,
    }

    public fun emit_metadata(arg0: vector<u8>, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = CustomMetadata{
            event_id : arg0,
            data     : arg1,
        };
        0x2::event::emit<CustomMetadata>(v0);
    }

    // decompiled from Move bytecode v6
}

