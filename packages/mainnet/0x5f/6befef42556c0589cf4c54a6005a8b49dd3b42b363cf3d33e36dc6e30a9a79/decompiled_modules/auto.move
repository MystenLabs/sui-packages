module 0x5f6befef42556c0589cf4c54a6005a8b49dd3b42b363cf3d33e36dc6e30a9a79::auto {
    struct Auto has store, key {
        id: 0x2::object::UID,
        name: u64,
        power: u64,
        timelap: u64,
        coef: u64,
    }

    public fun mint(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : Auto {
        Auto{
            id      : 0x2::object::new(arg4),
            name    : arg0,
            power   : arg1,
            timelap : arg2,
            coef    : arg3,
        }
    }

    public entry fun mint_and_transfer(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = mint(arg0, arg1, arg2, arg3, arg4);
        0x2::transfer::public_transfer<Auto>(v0, 0x2::tx_context::sender(arg4));
    }

    // decompiled from Move bytecode v6
}

