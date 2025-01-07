module 0x6a90511de81ced5cc6c0ef7e27046ffff31ada8948f96398a0212004b43ed7bc::deposit {
    struct DEPOSIT has drop {
        dummy_field: bool,
    }

    struct OwnerCap has store, key {
        id: 0x2::object::UID,
        admin: address,
    }

    struct DepositEvent has copy, drop {
        coin_type: 0x1::string::String,
        sender: address,
        receiver: address,
        to: 0x1::string::String,
        amount: u64,
    }

    public entry fun deposit<T0>(arg0: 0x2::coin::Coin<T0>, arg1: address, arg2: vector<u8>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<T0>(&arg0) >= arg3, 1);
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x1::string::utf8(b"");
        0x1::string::append_utf8(&mut v1, 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T0>())));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg0, arg3, arg4), arg1);
        if (0x2::coin::value<T0>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, v0);
        } else {
            0x2::coin::destroy_zero<T0>(arg0);
        };
        let v2 = DepositEvent{
            coin_type : v1,
            sender    : v0,
            receiver  : arg1,
            to        : 0x1::string::utf8(arg2),
            amount    : arg3,
        };
        0x2::event::emit<DepositEvent>(v2);
    }

    fun init(arg0: DEPOSIT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<DEPOSIT>(arg0, arg1), v0);
        let v1 = OwnerCap{
            id    : 0x2::object::new(arg1),
            admin : v0,
        };
        0x2::transfer::transfer<OwnerCap>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

