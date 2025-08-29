module 0x1c515fb0c7979c0106b841f528374bf2ee14b0c605ab2d97c52e25ed3488826a::nft {
    struct MintCap has key {
        id: 0x2::object::UID,
    }

    struct AccessPass has store, key {
        id: 0x2::object::UID,
        name: vector<u8>,
        uri: vector<u8>,
    }

    public entry fun batch_mint(arg0: &MintCap, arg1: vector<vector<u8>>, arg2: vector<vector<u8>>, arg3: vector<address>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<vector<u8>>(&arg1)) {
            let v1 = AccessPass{
                id   : 0x2::object::new(arg4),
                name : *0x1::vector::borrow<vector<u8>>(&arg1, v0),
                uri  : *0x1::vector::borrow<vector<u8>>(&arg2, v0),
            };
            0x2::transfer::transfer<AccessPass>(v1, *0x1::vector::borrow<address>(&arg3, v0));
            v0 = v0 + 1;
        };
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = MintCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<MintCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun mint(arg0: &MintCap, arg1: vector<u8>, arg2: vector<u8>, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = AccessPass{
            id   : 0x2::object::new(arg4),
            name : arg1,
            uri  : arg2,
        };
        0x2::transfer::transfer<AccessPass>(v0, arg3);
    }

    public entry fun mint_public(arg0: vector<u8>, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = AccessPass{
            id   : 0x2::object::new(arg2),
            name : arg0,
            uri  : arg1,
        };
        0x2::transfer::transfer<AccessPass>(v0, 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

