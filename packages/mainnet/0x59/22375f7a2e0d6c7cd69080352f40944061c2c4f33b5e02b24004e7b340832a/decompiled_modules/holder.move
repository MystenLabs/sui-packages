module 0x5922375f7a2e0d6c7cd69080352f40944061c2c4f33b5e02b24004e7b340832a::holder {
    struct Holder has key {
        id: 0x2::object::UID,
    }

    public entry fun create_holder(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Holder{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<Holder>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun extract_asset<T0: store + key, T1: copy + drop + store>(arg0: &mut Holder, arg1: T1, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::dynamic_field::exists_<T1>(&arg0.id, arg1), 0);
        0x2::transfer::public_transfer<T0>(0x2::dynamic_field::remove<T1, T0>(&mut arg0.id, arg1), 0x2::tx_context::sender(arg2));
    }

    public entry fun store_asset<T0: store + key, T1: copy + drop + store>(arg0: &mut Holder, arg1: T0, arg2: T1) {
        0x2::dynamic_field::add<T1, T0>(&mut arg0.id, arg2, arg1);
    }

    // decompiled from Move bytecode v6
}

