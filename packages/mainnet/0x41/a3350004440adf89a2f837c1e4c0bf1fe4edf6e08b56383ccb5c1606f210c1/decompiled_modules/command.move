module 0x41a3350004440adf89a2f837c1e4c0bf1fe4edf6e08b56383ccb5c1606f210c1::command {
    public fun mint_and_transfer_bulk(arg0: &mut 0x41a3350004440adf89a2f837c1e4c0bf1fe4edf6e08b56383ccb5c1606f210c1::meet::Meet, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u8, arg5: vector<address>, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg5)) {
            0x41a3350004440adf89a2f837c1e4c0bf1fe4edf6e08b56383ccb5c1606f210c1::attendance::mint_and_transfer(arg0, arg1, arg2, arg3, arg4, *0x1::vector::borrow<address>(&arg5, v0), arg6);
            v0 = v0 + 1;
        };
    }

    // decompiled from Move bytecode v6
}

