module 0xc627c220bc34642faae375ff008c7b493f63bb6e1d094fee41bb3a57851d0762::borrow_session {
    struct BorrowSession {
        account_id: 0x2::object::ID,
        objects: vector<0x2::object::ID>,
    }

    public fun borrow_object<T0: store + key>(arg0: &mut BorrowSession, arg1: &mut 0xc627c220bc34642faae375ff008c7b493f63bb6e1d094fee41bb3a57851d0762::account::Account, arg2: 0x2::transfer::Receiving<T0>) : T0 {
        assert!(0xc627c220bc34642faae375ff008c7b493f63bb6e1d094fee41bb3a57851d0762::account::id(arg1) == arg0.account_id, 1);
        let v0 = 0x2::transfer::public_receive<T0>(0xc627c220bc34642faae375ff008c7b493f63bb6e1d094fee41bb3a57851d0762::account::extend(arg1), arg2);
        0x1::vector::push_back<0x2::object::ID>(&mut arg0.objects, 0x2::object::id<T0>(&v0));
        v0
    }

    public fun destroy(arg0: BorrowSession, arg1: &mut 0xc627c220bc34642faae375ff008c7b493f63bb6e1d094fee41bb3a57851d0762::account::Account) {
        let BorrowSession {
            account_id : v0,
            objects    : v1,
        } = arg0;
        let v2 = v1;
        assert!(0xc627c220bc34642faae375ff008c7b493f63bb6e1d094fee41bb3a57851d0762::account::id(arg1) == v0, 1);
        assert!(0x1::vector::is_empty<0x2::object::ID>(&v2), 2);
    }

    public fun new(arg0: &0xc627c220bc34642faae375ff008c7b493f63bb6e1d094fee41bb3a57851d0762::account::Account, arg1: &0x2::tx_context::TxContext) : BorrowSession {
        0xc627c220bc34642faae375ff008c7b493f63bb6e1d094fee41bb3a57851d0762::account::assert_owner(arg0, arg1);
        BorrowSession{
            account_id : 0xc627c220bc34642faae375ff008c7b493f63bb6e1d094fee41bb3a57851d0762::account::id(arg0),
            objects    : 0x1::vector::empty<0x2::object::ID>(),
        }
    }

    public fun return_object<T0: store + key>(arg0: &mut BorrowSession, arg1: &mut 0xc627c220bc34642faae375ff008c7b493f63bb6e1d094fee41bb3a57851d0762::account::Account, arg2: T0) {
        assert!(0xc627c220bc34642faae375ff008c7b493f63bb6e1d094fee41bb3a57851d0762::account::id(arg1) == arg0.account_id, 1);
        let v0 = 0x2::object::id<T0>(&arg2);
        let (v1, v2) = 0x1::vector::index_of<0x2::object::ID>(&arg0.objects, &v0);
        assert!(v1, 0);
        0x1::vector::swap_remove<0x2::object::ID>(&mut arg0.objects, v2);
        0x2::transfer::public_transfer<T0>(arg2, 0xc627c220bc34642faae375ff008c7b493f63bb6e1d094fee41bb3a57851d0762::account::get_address(arg1));
    }

    // decompiled from Move bytecode v6
}

