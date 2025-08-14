module 0xb166d456b6d86e16aa4c2dc473ce94cf0f9a8a753878f8062b52fa654d3abfb4::nft {
    struct MintCap has key {
        id: 0x2::object::UID,
    }

    struct AccessPass has store, key {
        id: 0x2::object::UID,
        name: vector<u8>,
        uri: vector<u8>,
        tier: vector<u8>,
    }

    public entry fun batch_mint(arg0: &MintCap, arg1: vector<vector<u8>>, arg2: vector<vector<u8>>, arg3: vector<vector<u8>>, arg4: vector<address>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<vector<u8>>(&arg1)) {
            let v1 = AccessPass{
                id   : 0x2::object::new(arg5),
                name : *0x1::vector::borrow<vector<u8>>(&arg1, v0),
                uri  : *0x1::vector::borrow<vector<u8>>(&arg2, v0),
                tier : *0x1::vector::borrow<vector<u8>>(&arg3, v0),
            };
            0x2::transfer::transfer<AccessPass>(v1, *0x1::vector::borrow<address>(&arg4, v0));
            v0 = v0 + 1;
        };
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = MintCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<MintCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun mint(arg0: &MintCap, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = AccessPass{
            id   : 0x2::object::new(arg5),
            name : arg1,
            uri  : arg2,
            tier : arg3,
        };
        0x2::transfer::transfer<AccessPass>(v0, arg4);
    }

    // decompiled from Move bytecode v6
}

