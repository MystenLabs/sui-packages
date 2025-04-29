module 0xe51f75e43ed65084b76da77277747fe4797a8ad0b83ddc970b98445be790e9b5::my_string_storage {
    struct StringStorage has store, key {
        id: 0x2::object::UID,
        value: 0x1::string::String,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = StringStorage{
            id    : 0x2::object::new(arg0),
            value : 0x1::string::utf8(b"Hello from Sui!"),
        };
        0x2::transfer::transfer<StringStorage>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun update_string(arg0: &mut StringStorage, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.value = 0x1::string::utf8(arg1);
    }

    // decompiled from Move bytecode v6
}

