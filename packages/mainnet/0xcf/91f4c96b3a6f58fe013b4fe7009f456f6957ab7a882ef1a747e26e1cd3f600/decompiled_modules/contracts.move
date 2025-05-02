module 0xcf91f4c96b3a6f58fe013b4fe7009f456f6957ab7a882ef1a747e26e1cd3f600::contracts {
    struct Contract has store, key {
        id: 0x2::object::UID,
        hash: vector<u8>,
        owner: address,
        measurements: 0x2::vec_map::VecMap<u64, vector<u8>>,
    }

    public entry fun add_measurement(arg0: &mut Contract, arg1: u64, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::vec_map::insert<u64, vector<u8>>(&mut arg0.measurements, arg1, arg2);
    }

    public entry fun register_contract(arg0: vector<u8>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Contract{
            id           : 0x2::object::new(arg1),
            hash         : arg0,
            owner        : 0x2::tx_context::sender(arg1),
            measurements : 0x2::vec_map::empty<u64, vector<u8>>(),
        };
        0x2::transfer::transfer<Contract>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

