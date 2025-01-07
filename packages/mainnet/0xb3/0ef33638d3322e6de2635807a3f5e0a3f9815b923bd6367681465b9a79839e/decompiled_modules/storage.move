module 0xb30ef33638d3322e6de2635807a3f5e0a3f9815b923bd6367681465b9a79839e::storage {
    struct Storage has store, key {
        id: 0x2::object::UID,
        obligations: 0x2::bag::Bag,
        last_digest: vector<u8>,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Storage{
            id          : 0x2::object::new(arg0),
            obligations : 0x2::bag::new(arg0),
            last_digest : 0x1::vector::empty<u8>(),
        };
        0x2::transfer::share_object<Storage>(v0);
    }

    public entry fun update(arg0: &mut Storage, arg1: vector<address>, arg2: vector<u8>) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg1)) {
            0x2::bag::add<address, bool>(&mut arg0.obligations, 0x1::vector::pop_back<address>(&mut arg1), true);
            v0 = v0 + 1;
        };
        arg0.last_digest = arg2;
    }

    // decompiled from Move bytecode v6
}

