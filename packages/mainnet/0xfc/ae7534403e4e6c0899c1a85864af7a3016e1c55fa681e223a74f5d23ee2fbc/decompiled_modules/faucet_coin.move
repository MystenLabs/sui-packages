module 0xfcae7534403e4e6c0899c1a85864af7a3016e1c55fa681e223a74f5d23ee2fbc::faucet_coin {
    struct Faucet has key {
        id: 0x2::object::UID,
        treasury_cap: 0x2::coin::TreasuryCap<0xfcae7534403e4e6c0899c1a85864af7a3016e1c55fa681e223a74f5d23ee2fbc::MY_COIN::MY_COIN>,
    }

    public entry fun create_faucet(arg0: 0x2::coin::TreasuryCap<0xfcae7534403e4e6c0899c1a85864af7a3016e1c55fa681e223a74f5d23ee2fbc::MY_COIN::MY_COIN>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Faucet{
            id           : 0x2::object::new(arg1),
            treasury_cap : arg0,
        };
        0x2::transfer::share_object<Faucet>(v0);
    }

    public entry fun request_coin(arg0: &mut Faucet, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0xfcae7534403e4e6c0899c1a85864af7a3016e1c55fa681e223a74f5d23ee2fbc::MY_COIN::mint(&mut arg0.treasury_cap, 1000000, arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

