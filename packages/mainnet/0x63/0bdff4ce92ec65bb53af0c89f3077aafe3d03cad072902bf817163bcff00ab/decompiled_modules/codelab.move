module 0x630bdff4ce92ec65bb53af0c89f3077aafe3d03cad072902bf817163bcff00ab::codelab {
    struct NamesEvent has copy, drop {
        x_name: 0x1::ascii::String,
        x_bytes: vector<u8>,
        y_name: 0x1::ascii::String,
        y_bytes: vector<u8>,
        is_order: bool,
    }

    struct Global has key {
        id: 0x2::object::UID,
        upgrade_bag: 0x2::bag::Bag,
    }

    struct Global2 has store, key {
        id: 0x2::object::UID,
        upgrade_bag: 0x2::bag::Bag,
    }

    struct ValueA has copy, drop, store {
        a: u64,
    }

    struct ValueB has copy, drop, store {
        b: u64,
    }

    struct ValueData has copy, drop {
        old_a: u64,
        old_b: u64,
        value_1: ValueA,
        value_2: ValueB,
    }

    public entry fun batch_transfer<T0>(arg0: 0x2::coin::Coin<T0>, arg1: vector<address>, arg2: vector<u64>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        assert!(0x1::vector::length<address>(&arg1) == 0x1::vector::length<u64>(&arg2), 1002);
        while (v0 < 0x1::vector::length<address>(&arg1)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg0, *0x1::vector::borrow<u64>(&arg2, v0), arg3), *0x1::vector::borrow<address>(&arg1, v0));
            v0 = v0 + 1;
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, 0x2::tx_context::sender(arg3));
    }

    public entry fun getTypeNames<T0, T1>() {
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0x1::type_name::get<T1>();
        let (v2, v3) = 0x630bdff4ce92ec65bb53af0c89f3077aafe3d03cad072902bf817163bcff00ab::comparator::to_bytes<0x1::type_name::TypeName>(&v0, &v1);
        let v4 = NamesEvent{
            x_name   : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            x_bytes  : v2,
            y_name   : 0x1::type_name::into_string(0x1::type_name::get<T1>()),
            y_bytes  : v3,
            is_order : is_order<T0, T1>(),
        };
        0x2::event::emit<NamesEvent>(v4);
    }

    public fun getValues(arg0: &Global) {
        let v0 = b"123";
        let v1 = 0x2::bag::borrow<vector<u8>, ValueA>(&arg0.upgrade_bag, v0);
        let v2 = 0x2::bag::borrow<vector<u8>, ValueB>(&arg0.upgrade_bag, v0);
        let v3 = ValueData{
            old_a   : v1.a,
            old_b   : v2.b,
            value_1 : *v1,
            value_2 : *v2,
        };
        0x2::event::emit<ValueData>(v3);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Global{
            id          : 0x2::object::new(arg0),
            upgrade_bag : 0x2::bag::new(arg0),
        };
        let v1 = Global2{
            id          : 0x2::object::new(arg0),
            upgrade_bag : 0x2::bag::new(arg0),
        };
        let v2 = ValueA{a: 1};
        0x2::bag::add<vector<u8>, ValueA>(&mut v0.upgrade_bag, b"123", v2);
        0x2::transfer::transfer<Global>(v0, 0x2::tx_context::sender(arg0));
        0x2::transfer::transfer<Global2>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun is_order<T0, T1>() : bool {
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0x1::type_name::get<T1>();
        let v2 = 0x630bdff4ce92ec65bb53af0c89f3077aafe3d03cad072902bf817163bcff00ab::comparator::compare<0x1::type_name::TypeName>(&v0, &v1);
        assert!(!0x630bdff4ce92ec65bb53af0c89f3077aafe3d03cad072902bf817163bcff00ab::comparator::is_equal(&v2), 1001);
        0x630bdff4ce92ec65bb53af0c89f3077aafe3d03cad072902bf817163bcff00ab::comparator::is_smaller_than(&v2)
    }

    public fun setValues(arg0: &mut Global) {
        let v0 = b"123";
        let v1 = 0x2::bag::borrow_mut<vector<u8>, ValueA>(&mut arg0.upgrade_bag, v0);
        v1.a = v1.a + 11;
        let v2 = 0x2::bag::borrow_mut<vector<u8>, ValueB>(&mut arg0.upgrade_bag, v0);
        v2.b = v2.b + 22;
    }

    // decompiled from Move bytecode v6
}

