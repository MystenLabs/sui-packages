module 0x6c46888d7d4f0c97fb401be204c7ce080daa025ff3ed561cdf7632f7c0287460::yy_guessing_game {
    struct GuessingGame<phantom T0> has key {
        id: 0x2::object::UID,
        yy_balace: 0x2::balance::Balance<T0>,
        withdraw_address: address,
        admin: vector<address>,
    }

    struct Owner has store, key {
        id: 0x2::object::UID,
        admin: address,
    }

    fun check_permissions(arg0: &vector<address>, arg1: address) {
        assert!(0x1::vector::contains<address>(arg0, &arg1), 101);
    }

    public fun deladmin<T0>(arg0: &Owner, arg1: &mut GuessingGame<T0>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&mut arg1.admin)) {
            if (0x1::vector::borrow<address>(&mut arg1.admin, v0) == &arg2) {
                0x1::vector::remove<address>(&mut arg1.admin, v0);
            };
            v0 = v0 + 1;
        };
    }

    public fun extract_yy<T0>(arg0: &mut GuessingGame<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = &mut arg0.yy_balace;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(v0, 0x2::balance::value<T0>(v0), arg1), arg0.withdraw_address);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Owner{
            id    : 0x2::object::new(arg0),
            admin : @0xfec2432232f6a7a9dd1fdbdab5d44ec0ecf6ca104cdee0e7f0adc66c3bff2e61,
        };
        0x2::transfer::transfer<Owner>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun init_new_resource<T0>(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = GuessingGame<T0>{
            id               : 0x2::object::new(arg0),
            yy_balace        : 0x2::balance::zero<T0>(),
            withdraw_address : @0x28b2496b0b6d6ebd4e2ec3befca8f679ea84334b2eb27494b9388ed3ecbcd6ee,
            admin            : vector[],
        };
        0x1::vector::push_back<address>(&mut v0.admin, @0x52a3a7620a0a7d0974ae20813357d7e7a0c6c8ec52d071b4ab2d249f690a2c35);
        0x2::transfer::share_object<GuessingGame<T0>>(v0);
    }

    public fun playgame<T0>(arg0: &mut GuessingGame<T0>, arg1: 0x2::coin::Coin<T0>, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 >= 100000, 6);
        0x2::balance::join<T0>(&mut arg0.yy_balace, 0x2::coin::into_balance<T0>(arg1));
        0x6c46888d7d4f0c97fb401be204c7ce080daa025ff3ed561cdf7632f7c0287460::customize_event::purchase_event(0x2::tx_context::sender(arg3), v0, arg2);
    }

    public entry fun set_withdraw_confV1<T0>(arg0: &mut GuessingGame<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        check_permissions(&arg0.admin, 0x2::tx_context::sender(arg2));
        arg0.withdraw_address = arg1;
    }

    public fun setadmin<T0>(arg0: &Owner, arg1: &mut GuessingGame<T0>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x1::vector::push_back<address>(&mut arg1.admin, arg2);
    }

    // decompiled from Move bytecode v6
}

