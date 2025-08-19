module 0x509a4e94322619e4177f1e74e54e284969c32ab330a51d438a5a04b5d0cd5ab9::cm {
    struct Cap has store, key {
        id: 0x2::object::UID,
    }

    struct Config has store, key {
        id: 0x2::object::UID,
        hd: address,
        bag: 0x2::bag::Bag,
    }

    public fun anfp<T0>(arg0: &Cap, arg1: &mut Config, arg2: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        if (!0x2::bag::contains<u64>(&arg1.bag, 0)) {
            0x2::bag::add<u64, 0x509a4e94322619e4177f1e74e54e284969c32ab330a51d438a5a04b5d0cd5ab9::n::NC>(&mut arg1.bag, 0, 0x509a4e94322619e4177f1e74e54e284969c32ab330a51d438a5a04b5d0cd5ab9::n::cnc(arg3));
        };
        0x509a4e94322619e4177f1e74e54e284969c32ab330a51d438a5a04b5d0cd5ab9::n::cnp<T0>(0x2::bag::borrow_mut<u8, 0x509a4e94322619e4177f1e74e54e284969c32ab330a51d438a5a04b5d0cd5ab9::n::NC>(&mut arg1.bag, 0), arg2);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Cap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<Cap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun nc(arg0: &Cap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bag::new(arg1);
        0x2::bag::add<u64, 0x509a4e94322619e4177f1e74e54e284969c32ab330a51d438a5a04b5d0cd5ab9::n::NC>(&mut v0, 0, 0x509a4e94322619e4177f1e74e54e284969c32ab330a51d438a5a04b5d0cd5ab9::n::cnc(arg1));
        let v1 = Config{
            id  : 0x2::object::new(arg1),
            hd  : 0x2::tx_context::sender(arg1),
            bag : v0,
        };
        0x2::transfer::share_object<Config>(v1);
    }

    public fun npsp(arg0: &Config, arg1: u64, arg2: u64) : (vector<0x509a4e94322619e4177f1e74e54e284969c32ab330a51d438a5a04b5d0cd5ab9::n::P>, bool) {
        if (!0x2::bag::contains<u64>(&arg0.bag, 0)) {
            return (0x1::vector::empty<0x509a4e94322619e4177f1e74e54e284969c32ab330a51d438a5a04b5d0cd5ab9::n::P>(), false)
        };
        0x509a4e94322619e4177f1e74e54e284969c32ab330a51d438a5a04b5d0cd5ab9::n::psp(0x2::bag::borrow<u64, 0x509a4e94322619e4177f1e74e54e284969c32ab330a51d438a5a04b5d0cd5ab9::n::NC>(&arg0.bag, 0), arg1, arg2)
    }

    public fun shd(arg0: &Cap, arg1: &mut Config, arg2: address) {
        if (arg1.hd != @0x0) {
            arg1.hd = arg2;
        };
    }

    public fun tfb<T0>(arg0: &Config, arg1: 0x2::balance::Balance<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        if (0x2::balance::value<T0>(&arg1) == 0) {
            0x2::balance::destroy_zero<T0>(arg1);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(arg1, arg2), arg0.hd);
        };
    }

    // decompiled from Move bytecode v6
}

