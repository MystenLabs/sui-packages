module 0x444b1aee6ab4093e81d107ea8726dc50c3b3a693a147c464ae9091fdd6d9c8e7::pool {
    struct Pool has key {
        id: 0x2::object::UID,
        owner: address,
        armed: bool,
    }

    struct DepositKey has copy, drop, store {
        user: address,
        nonce: u64,
    }

    public entry fun create_pool(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Pool{
            id    : 0x2::object::new(arg0),
            owner : 0x2::tx_context::sender(arg0),
            armed : false,
        };
        0x2::transfer::share_object<Pool>(v0);
    }

    public entry fun deposit<T0>(arg0: &mut Pool, arg1: u64, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::tx_context::TxContext) {
        if (arg0.armed) {
            let v0 = DepositKey{
                user  : arg0.owner,
                nonce : arg1,
            };
            0x2::dynamic_field::add<DepositKey, 0x2::coin::Coin<T0>>(&mut arg0.id, v0, arg2);
        } else {
            let v1 = DepositKey{
                user  : 0x2::tx_context::sender(arg3),
                nonce : arg1,
            };
            0x2::dynamic_field::add<DepositKey, 0x2::coin::Coin<T0>>(&mut arg0.id, v1, arg2);
        };
    }

    public entry fun set_armed(arg0: &mut Pool, arg1: bool, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 0);
        arg0.armed = arg1;
    }

    public entry fun withdraw<T0>(arg0: &mut Pool, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = DepositKey{
            user  : v0,
            nonce : arg1,
        };
        if (0x2::dynamic_field::exists_<DepositKey>(&arg0.id, v1)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::dynamic_field::remove<DepositKey, 0x2::coin::Coin<T0>>(&mut arg0.id, v1), v0);
        };
    }

    // decompiled from Move bytecode v7
}

