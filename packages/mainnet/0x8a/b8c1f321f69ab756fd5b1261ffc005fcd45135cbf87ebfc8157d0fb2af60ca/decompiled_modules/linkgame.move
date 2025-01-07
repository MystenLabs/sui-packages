module 0x8ab8c1f321f69ab756fd5b1261ffc005fcd45135cbf87ebfc8157d0fb2af60ca::linkgame {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct LinkGame has store, key {
        id: 0x2::object::UID,
        amount: 0x2::balance::Balance<0xf855a34f6870634a444260ec3a7ad5581334849d8388f63d67e703b06428edc4::eig::EIG>,
    }

    public entry fun deposit(arg0: &mut LinkGame, arg1: 0x2::coin::Coin<0xf855a34f6870634a444260ec3a7ad5581334849d8388f63d67e703b06428edc4::eig::EIG>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0xf855a34f6870634a444260ec3a7ad5581334849d8388f63d67e703b06428edc4::eig::EIG>(&mut arg0.amount, 0x2::coin::into_balance<0xf855a34f6870634a444260ec3a7ad5581334849d8388f63d67e703b06428edc4::eig::EIG>(arg1));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = LinkGame{
            id     : 0x2::object::new(arg0),
            amount : 0x2::balance::zero<0xf855a34f6870634a444260ec3a7ad5581334849d8388f63d67e703b06428edc4::eig::EIG>(),
        };
        0x2::transfer::share_object<LinkGame>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    entry fun play(arg0: &mut LinkGame, arg1: &0x2::random::Random, arg2: bool, arg3: 0x2::coin::Coin<0xf855a34f6870634a444260ec3a7ad5581334849d8388f63d67e703b06428edc4::eig::EIG>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0xf855a34f6870634a444260ec3a7ad5581334849d8388f63d67e703b06428edc4::eig::EIG>(&arg3);
        assert!(0x2::balance::value<0xf855a34f6870634a444260ec3a7ad5581334849d8388f63d67e703b06428edc4::eig::EIG>(&arg0.amount) >= v0 * 10, 1);
        let v1 = 0x2::random::new_generator(arg1, arg4);
        if (arg2 == 0x2::random::generate_bool(&mut v1)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xf855a34f6870634a444260ec3a7ad5581334849d8388f63d67e703b06428edc4::eig::EIG>>(0x2::coin::from_balance<0xf855a34f6870634a444260ec3a7ad5581334849d8388f63d67e703b06428edc4::eig::EIG>(0x2::balance::split<0xf855a34f6870634a444260ec3a7ad5581334849d8388f63d67e703b06428edc4::eig::EIG>(&mut arg0.amount, v0), arg4), 0x2::tx_context::sender(arg4));
            0x2::transfer::public_transfer<0x2::coin::Coin<0xf855a34f6870634a444260ec3a7ad5581334849d8388f63d67e703b06428edc4::eig::EIG>>(arg3, 0x2::tx_context::sender(arg4));
        } else {
            0x2::balance::join<0xf855a34f6870634a444260ec3a7ad5581334849d8388f63d67e703b06428edc4::eig::EIG>(&mut arg0.amount, 0x2::coin::into_balance<0xf855a34f6870634a444260ec3a7ad5581334849d8388f63d67e703b06428edc4::eig::EIG>(arg3));
        };
    }

    public entry fun withdraw(arg0: &AdminCap, arg1: &mut LinkGame, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0xf855a34f6870634a444260ec3a7ad5581334849d8388f63d67e703b06428edc4::eig::EIG>>(0x2::coin::from_balance<0xf855a34f6870634a444260ec3a7ad5581334849d8388f63d67e703b06428edc4::eig::EIG>(0x2::balance::split<0xf855a34f6870634a444260ec3a7ad5581334849d8388f63d67e703b06428edc4::eig::EIG>(&mut arg1.amount, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

