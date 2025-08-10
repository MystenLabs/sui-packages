module 0x96dffad448d589a3e0abda63793434789d16d6589f9ccdf16c1c0a475e1102a7::storage {
    struct AddressStorage has store, key {
        id: 0x2::object::UID,
        value: u64,
    }

    public entry fun create_storage(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = AddressStorage{
            id    : 0x2::object::new(arg1),
            value : arg0,
        };
        0x2::transfer::transfer<AddressStorage>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun get_value(arg0: &AddressStorage) : u64 {
        arg0.value
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
    }

    public entry fun update_value(arg0: &mut AddressStorage, arg1: u64) {
        arg0.value = arg1;
    }

    // decompiled from Move bytecode v6
}

