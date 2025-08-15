module 0x7dea8cca3f9970e8c52813d7a0cfb6c8e481fd92e9186834e1e3b58db2068029::private_data {
    struct PrivateData has store, key {
        id: 0x2::object::UID,
        creator: address,
        nonce: vector<u8>,
        data: vector<u8>,
    }

    fun check_policy(arg0: vector<u8>, arg1: &PrivateData) : bool {
        compute_key_id(arg1.creator, arg1.nonce) == arg0
    }

    fun compute_key_id(arg0: address, arg1: vector<u8>) : vector<u8> {
        let v0 = 0x2::address::to_bytes(arg0);
        0x1::vector::append<u8>(&mut v0, arg1);
        v0
    }

    entry fun seal_approve(arg0: vector<u8>, arg1: &PrivateData) {
        assert!(check_policy(arg0, arg1), 77);
    }

    public fun store(arg0: vector<u8>, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) : PrivateData {
        PrivateData{
            id      : 0x2::object::new(arg2),
            creator : 0x2::tx_context::sender(arg2),
            nonce   : arg0,
            data    : arg1,
        }
    }

    entry fun store_entry(arg0: vector<u8>, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = store(arg0, arg1, arg2);
        0x2::transfer::transfer<PrivateData>(v0, 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

