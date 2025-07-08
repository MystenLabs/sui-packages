module 0x57e03d2a696480d57e6720db8ef3481ec88e078e7b8d05bf0c4c277d83a74237::auto {
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
        let v0 = mint(arg0, arg1, arg2, arg3, arg4);
        0x2::transfer::public_transfer<Auto>(v0, 0x2::tx_context::sender(arg4));
    }

    // decompiled from Move bytecode v6
}

