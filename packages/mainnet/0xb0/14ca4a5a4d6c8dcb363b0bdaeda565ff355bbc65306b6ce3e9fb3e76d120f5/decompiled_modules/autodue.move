module 0xb014ca4a5a4d6c8dcb363b0bdaeda565ff355bbc65306b6ce3e9fb3e76d120f5::autodue {
    struct Auto has store, key {
        id: 0x2::object::UID,
        name: vector<u8>,
        power: u64,
        timelap: u64,
        coef: u64,
    }

    public fun mint(arg0: vector<u8>, arg1: u64, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : Auto {
        Auto{
            id      : 0x2::object::new(arg4),
            name    : arg0,
            power   : arg1,
            timelap : arg2,
            coef    : arg3,
        }
    }

    public entry fun mint_and_transfer(arg0: vector<u8>, arg1: u64, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == @0x67f534486a00978e8ea74d0c0cf4043e742ed13cbcc41511898ee7703851ba1d, 0);
        let v0 = mint(arg0, arg1, arg2, arg3, arg4);
        0x2::transfer::public_transfer<Auto>(v0, 0x2::tx_context::sender(arg4));
    }

    // decompiled from Move bytecode v6
}

