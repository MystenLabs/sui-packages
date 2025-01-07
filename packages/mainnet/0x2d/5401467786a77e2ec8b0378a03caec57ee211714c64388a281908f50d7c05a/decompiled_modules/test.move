module 0x2d5401467786a77e2ec8b0378a03caec57ee211714c64388a281908f50d7c05a::test {
    struct Test has store, key {
        id: 0x2::object::UID,
        test: u64,
        test_table: 0x2::table::Table<0x1::string::String, u64>,
    }

    struct Test2 has store, key {
        id: 0x2::object::UID,
        test: u64,
    }

    public entry fun add_entry(arg0: &mut Test, arg1: 0x1::string::String, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::table::add<0x1::string::String, u64>(&mut arg0.test_table, arg1, arg2);
    }

    public entry fun add_value(arg0: &mut Test, arg1: 0x1::string::String, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::table::borrow_mut<0x1::string::String, u64>(&mut arg0.test_table, arg1);
        *v0 = *v0 + arg2;
    }

    public entry fun create_test(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Test{
            id         : 0x2::object::new(arg1),
            test       : arg0,
            test_table : 0x2::table::new<0x1::string::String, u64>(arg1),
        };
        0x2::transfer::transfer<Test>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun create_test2(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Test2{
            id   : 0x2::object::new(arg1),
            test : arg0,
        };
        0x2::transfer::transfer<Test2>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun dummy(arg0: Test, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::transfer<Test>(arg0, arg1);
    }

    public entry fun new_transfer_test(arg0: Test, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::transfer<Test>(arg0, arg1);
    }

    public entry fun transfer_test(arg0: Test, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::transfer<Test>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

