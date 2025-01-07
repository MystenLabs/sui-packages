module 0x707244e0331c07cbb2a4791ceae693ad9e59ee7152396f9b1c8ae2b4fa833b5a::trusted_swap {
    struct Object has store, key {
        id: 0x2::object::UID,
        scarcity: u8,
        style: u8,
    }

    struct ObjectWrapper has key {
        id: 0x2::object::UID,
        original_owner: address,
        to_swap: Object,
        fee: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    public entry fun create_object(arg0: u8, arg1: u8, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Object{
            id       : 0x2::object::new(arg2),
            scarcity : arg0,
            style    : arg1,
        };
        0x2::transfer::public_transfer<Object>(v0, 0x2::tx_context::sender(arg2));
    }

    public entry fun execute_swap(arg0: ObjectWrapper, arg1: ObjectWrapper, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.to_swap.scarcity == arg1.to_swap.scarcity, 0);
        assert!(arg0.to_swap.style != arg1.to_swap.style, 0);
        let ObjectWrapper {
            id             : v0,
            original_owner : v1,
            to_swap        : v2,
            fee            : v3,
        } = arg0;
        let v4 = v3;
        let ObjectWrapper {
            id             : v5,
            original_owner : v6,
            to_swap        : v7,
            fee            : v8,
        } = arg1;
        0x2::transfer::transfer<Object>(v2, v6);
        0x2::transfer::transfer<Object>(v7, v1);
        0x2::balance::join<0x2::sui::SUI>(&mut v4, v8);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v4, arg2), 0x2::tx_context::sender(arg2));
        0x2::object::delete(v0);
        0x2::object::delete(v5);
    }

    public entry fun request_swap(arg0: Object, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) >= 1000, 0);
        let v0 = ObjectWrapper{
            id             : 0x2::object::new(arg3),
            original_owner : 0x2::tx_context::sender(arg3),
            to_swap        : arg0,
            fee            : 0x2::coin::into_balance<0x2::sui::SUI>(arg1),
        };
        0x2::transfer::transfer<ObjectWrapper>(v0, arg2);
    }

    // decompiled from Move bytecode v6
}

