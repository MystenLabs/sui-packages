module 0x985fbe0cf17fc777fa3017948fb558b94be7413afc6f63c2a24f4c8064e4f97d::record {
    struct OperatorCap has store, key {
        id: 0x2::object::UID,
        operator: address,
        version: u64,
    }

    struct Orders has key {
        id: 0x2::object::UID,
        orders: 0x2::table::Table<0x1::string::String, bool>,
        operator_version: u64,
    }

    struct Record has copy, drop {
        order_no: 0x1::string::String,
        trade_time: 0x1::string::String,
        action: 0x1::string::String,
        code: 0x1::string::String,
        price: 0x1::string::String,
        quantity: 0x1::string::String,
        amount: 0x1::string::String,
    }

    struct OperatorTransferred has copy, drop {
        old_operator: address,
        new_operator: address,
        new_version: u64,
    }

    public fun record(arg0: &OperatorCap, arg1: &mut Orders, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg9) == arg0.operator, 1);
        assert!(arg0.version == arg1.operator_version, 2);
        assert!(!0x2::table::contains<0x1::string::String, bool>(&arg1.orders, arg2), 3);
        0x2::table::add<0x1::string::String, bool>(&mut arg1.orders, arg2, true);
        let v0 = Record{
            order_no   : arg2,
            trade_time : arg3,
            action     : arg4,
            code       : arg5,
            price      : arg6,
            quantity   : arg7,
            amount     : arg8,
        };
        0x2::event::emit<Record>(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = OperatorCap{
            id       : 0x2::object::new(arg0),
            operator : @0x8bbdc2f2414336fc5adb1198a5961091b35f8d7652a9bf0a583fba7257abcb6b,
            version  : 1,
        };
        let v1 = Orders{
            id               : 0x2::object::new(arg0),
            orders           : 0x2::table::new<0x1::string::String, bool>(arg0),
            operator_version : 1,
        };
        0x2::transfer::public_transfer<OperatorCap>(v0, @0x8bbdc2f2414336fc5adb1198a5961091b35f8d7652a9bf0a583fba7257abcb6b);
        0x2::transfer::share_object<Orders>(v1);
    }

    public fun operator_transfer(arg0: OperatorCap, arg1: &mut Orders, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.operator, 1);
        assert!(arg0.version == arg1.operator_version, 2);
        assert!(arg2 != @0x0, 4);
        assert!(arg2 != arg0.operator, 5);
        arg1.operator_version = arg1.operator_version + 1;
        let v0 = OperatorCap{
            id       : 0x2::object::new(arg3),
            operator : arg2,
            version  : arg1.operator_version,
        };
        0x2::transfer::public_transfer<OperatorCap>(v0, arg2);
        let OperatorCap {
            id       : v1,
            operator : _,
            version  : _,
        } = arg0;
        0x2::object::delete(v1);
        let v4 = OperatorTransferred{
            old_operator : arg0.operator,
            new_operator : arg2,
            new_version  : arg1.operator_version,
        };
        0x2::event::emit<OperatorTransferred>(v4);
    }

    // decompiled from Move bytecode v6
}

