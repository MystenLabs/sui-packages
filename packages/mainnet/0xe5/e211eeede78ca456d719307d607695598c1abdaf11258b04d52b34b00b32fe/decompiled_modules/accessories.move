module 0xe5e211eeede78ca456d719307d607695598c1abdaf11258b04d52b34b00b32fe::accessories {
    public fun bulk_purchase_and_transfer(arg0: &mut 0x7aee872d77cade27e7d9b79bf9c67ac40bfb1b797e8b7438ee73f0af21bb4664::store::AccessoriesStore, arg1: 0x1::string::String, arg2: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg3: u16, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < arg3) {
            0x2::transfer::public_transfer<0x7aee872d77cade27e7d9b79bf9c67ac40bfb1b797e8b7438ee73f0af21bb4664::accessories::Accessory>(0x7aee872d77cade27e7d9b79bf9c67ac40bfb1b797e8b7438ee73f0af21bb4664::store::buy(arg0, arg1, arg2, arg5), arg4);
            v0 = v0 + 1;
        };
    }

    // decompiled from Move bytecode v6
}

