module 0xa210de6094352ace503c219362ad61c9b867d13e5985223ea8fee6d31d5be4d::flip_coin {
    struct Game has key {
        id: 0x2::object::UID,
        amount: 0x2::balance::Balance<0x98694f8486d4bcb29b3eb58ea8d97e8ff4b072e25fba4976cd46e609f3c802a4::operaxxxfaucet::OPERAXXXFAUCET>,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    public entry fun addTokens(arg0: &mut Game, arg1: 0x2::coin::Coin<0x98694f8486d4bcb29b3eb58ea8d97e8ff4b072e25fba4976cd46e609f3c802a4::operaxxxfaucet::OPERAXXXFAUCET>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x98694f8486d4bcb29b3eb58ea8d97e8ff4b072e25fba4976cd46e609f3c802a4::operaxxxfaucet::OPERAXXXFAUCET>(&arg1) > 0, 2);
        0x2::balance::join<0x98694f8486d4bcb29b3eb58ea8d97e8ff4b072e25fba4976cd46e609f3c802a4::operaxxxfaucet::OPERAXXXFAUCET>(&mut arg0.amount, 0x2::coin::into_balance<0x98694f8486d4bcb29b3eb58ea8d97e8ff4b072e25fba4976cd46e609f3c802a4::operaxxxfaucet::OPERAXXXFAUCET>(arg1));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Game{
            id     : 0x2::object::new(arg0),
            amount : 0x2::balance::zero<0x98694f8486d4bcb29b3eb58ea8d97e8ff4b072e25fba4976cd46e609f3c802a4::operaxxxfaucet::OPERAXXXFAUCET>(),
        };
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<Game>(v0);
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    entry fun play(arg0: &mut Game, arg1: &0x2::random::Random, arg2: bool, arg3: 0x2::coin::Coin<0x98694f8486d4bcb29b3eb58ea8d97e8ff4b072e25fba4976cd46e609f3c802a4::operaxxxfaucet::OPERAXXXFAUCET>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x98694f8486d4bcb29b3eb58ea8d97e8ff4b072e25fba4976cd46e609f3c802a4::operaxxxfaucet::OPERAXXXFAUCET>(&arg3) <= 0x2::balance::value<0x98694f8486d4bcb29b3eb58ea8d97e8ff4b072e25fba4976cd46e609f3c802a4::operaxxxfaucet::OPERAXXXFAUCET>(&arg0.amount) / 10, 1);
        assert!(0x2::balance::value<0x98694f8486d4bcb29b3eb58ea8d97e8ff4b072e25fba4976cd46e609f3c802a4::operaxxxfaucet::OPERAXXXFAUCET>(&arg0.amount) > 0, 2);
        let v0 = 0x2::random::new_generator(arg1, arg4);
        if (0x2::random::generate_bool(&mut v0) == arg2) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x98694f8486d4bcb29b3eb58ea8d97e8ff4b072e25fba4976cd46e609f3c802a4::operaxxxfaucet::OPERAXXXFAUCET>>(arg3, 0x2::tx_context::sender(arg4));
            0x2::transfer::public_transfer<0x2::coin::Coin<0x98694f8486d4bcb29b3eb58ea8d97e8ff4b072e25fba4976cd46e609f3c802a4::operaxxxfaucet::OPERAXXXFAUCET>>(0x2::coin::from_balance<0x98694f8486d4bcb29b3eb58ea8d97e8ff4b072e25fba4976cd46e609f3c802a4::operaxxxfaucet::OPERAXXXFAUCET>(0x2::balance::split<0x98694f8486d4bcb29b3eb58ea8d97e8ff4b072e25fba4976cd46e609f3c802a4::operaxxxfaucet::OPERAXXXFAUCET>(&mut arg0.amount, 0x2::coin::value<0x98694f8486d4bcb29b3eb58ea8d97e8ff4b072e25fba4976cd46e609f3c802a4::operaxxxfaucet::OPERAXXXFAUCET>(&arg3)), arg4), 0x2::tx_context::sender(arg4));
        } else {
            0x2::balance::join<0x98694f8486d4bcb29b3eb58ea8d97e8ff4b072e25fba4976cd46e609f3c802a4::operaxxxfaucet::OPERAXXXFAUCET>(&mut arg0.amount, 0x2::coin::into_balance<0x98694f8486d4bcb29b3eb58ea8d97e8ff4b072e25fba4976cd46e609f3c802a4::operaxxxfaucet::OPERAXXXFAUCET>(arg3));
        };
    }

    public entry fun withdraw(arg0: &AdminCap, arg1: &mut Game, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 <= 0x2::balance::value<0x98694f8486d4bcb29b3eb58ea8d97e8ff4b072e25fba4976cd46e609f3c802a4::operaxxxfaucet::OPERAXXXFAUCET>(&arg1.amount), 1);
        assert!(arg2 > 0, 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x98694f8486d4bcb29b3eb58ea8d97e8ff4b072e25fba4976cd46e609f3c802a4::operaxxxfaucet::OPERAXXXFAUCET>>(0x2::coin::from_balance<0x98694f8486d4bcb29b3eb58ea8d97e8ff4b072e25fba4976cd46e609f3c802a4::operaxxxfaucet::OPERAXXXFAUCET>(0x2::balance::split<0x98694f8486d4bcb29b3eb58ea8d97e8ff4b072e25fba4976cd46e609f3c802a4::operaxxxfaucet::OPERAXXXFAUCET>(&mut arg1.amount, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

