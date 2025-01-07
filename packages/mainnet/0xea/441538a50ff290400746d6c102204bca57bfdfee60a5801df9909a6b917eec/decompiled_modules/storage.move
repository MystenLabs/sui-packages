module 0xea441538a50ff290400746d6c102204bca57bfdfee60a5801df9909a6b917eec::storage {
    struct Storage has store, key {
        id: 0x2::object::UID,
        obligations: 0x2::table::Table<address, address>,
        last_digest: vector<u8>,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Storage{
            id          : 0x2::object::new(arg0),
            obligations : 0x2::table::new<address, address>(arg0),
            last_digest : 0x1::vector::empty<u8>(),
        };
        0x2::transfer::share_object<Storage>(v0);
    }

    public entry fun update(arg0: &mut Storage, arg1: vector<address>, arg2: vector<address>, arg3: vector<u8>) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg1)) {
            0x2::table::add<address, address>(&mut arg0.obligations, 0x1::vector::pop_back<address>(&mut arg1), 0x1::vector::pop_back<address>(&mut arg2));
            v0 = v0 + 1;
        };
        arg0.last_digest = arg3;
    }

    // decompiled from Move bytecode v6
}

