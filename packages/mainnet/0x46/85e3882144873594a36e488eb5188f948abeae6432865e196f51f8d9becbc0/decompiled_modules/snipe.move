module 0x6e8a2d35ea74504284f9b86fa258f741a776b731aee47892c26c88c136e31247::snipe {
    struct TxKey has copy, drop, store {
        dummy_field: bool,
    }

    struct Tx has drop, store {
        digest: vector<u8>,
        bought: u64,
    }

    public(friend) fun bought_in_tx(arg0: &mut 0x2::object::UID, arg1: vector<u8>, arg2: u64) : u64 {
        let v0 = TxKey{dummy_field: false};
        if (!0x2::dynamic_field::exists<TxKey>(arg0, v0)) {
            let v1 = TxKey{dummy_field: false};
            let v2 = Tx{
                digest : arg1,
                bought : arg2,
            };
            0x2::dynamic_field::add<TxKey, Tx>(arg0, v1, v2);
            return arg2
        };
        let v3 = TxKey{dummy_field: false};
        let v4 = 0x2::dynamic_field::borrow_mut<TxKey, Tx>(arg0, v3);
        if (v4.digest != arg1) {
            v4.digest = arg1;
            v4.bought = 0;
        };
        v4.bought = v4.bought + arg2;
        v4.bought
    }

    // decompiled from Move bytecode v7
}

