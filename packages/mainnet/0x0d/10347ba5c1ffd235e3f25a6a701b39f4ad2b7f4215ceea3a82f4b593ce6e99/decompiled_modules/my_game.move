module 0xd10347ba5c1ffd235e3f25a6a701b39f4ad2b7f4215ceea3a82f4b593ce6e99::my_game {
    struct MyGame has key {
        id: 0x2::object::UID,
        amount: 0x2::balance::Balance<0x76ed920226db822677e4f23b47776f9ab4e1f5731ce5f7a44786ddf137cdfcd5::rmb::RMB>,
        author: 0x1::string::String,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    public entry fun deposit(arg0: &AdminCap, arg1: &mut MyGame, arg2: 0x2::coin::Coin<0x76ed920226db822677e4f23b47776f9ab4e1f5731ce5f7a44786ddf137cdfcd5::rmb::RMB>, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0x76ed920226db822677e4f23b47776f9ab4e1f5731ce5f7a44786ddf137cdfcd5::rmb::RMB>(&mut arg1.amount, 0x2::coin::into_balance<0x76ed920226db822677e4f23b47776f9ab4e1f5731ce5f7a44786ddf137cdfcd5::rmb::RMB>(arg2));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = MyGame{
            id     : 0x2::object::new(arg0),
            amount : 0x2::balance::zero<0x76ed920226db822677e4f23b47776f9ab4e1f5731ce5f7a44786ddf137cdfcd5::rmb::RMB>(),
            author : 0x1::string::utf8(b"liucanhui-eng"),
        };
        0x2::transfer::share_object<MyGame>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    entry fun play(arg0: &mut MyGame, arg1: bool, arg2: 0x2::coin::Coin<0x76ed920226db822677e4f23b47776f9ab4e1f5731ce5f7a44786ddf137cdfcd5::rmb::RMB>, arg3: &0x2::random::Random, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x76ed920226db822677e4f23b47776f9ab4e1f5731ce5f7a44786ddf137cdfcd5::rmb::RMB>(&arg2);
        if (v0 > 0x2::balance::value<0x76ed920226db822677e4f23b47776f9ab4e1f5731ce5f7a44786ddf137cdfcd5::rmb::RMB>(&arg0.amount) / 10) {
            abort 500
        };
        let v1 = 0x2::random::new_generator(arg3, arg4);
        if (0x2::random::generate_bool(&mut v1) == arg1) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x76ed920226db822677e4f23b47776f9ab4e1f5731ce5f7a44786ddf137cdfcd5::rmb::RMB>>(0x2::coin::from_balance<0x76ed920226db822677e4f23b47776f9ab4e1f5731ce5f7a44786ddf137cdfcd5::rmb::RMB>(0x2::balance::split<0x76ed920226db822677e4f23b47776f9ab4e1f5731ce5f7a44786ddf137cdfcd5::rmb::RMB>(&mut arg0.amount, v0), arg4), 0x2::tx_context::sender(arg4));
            0x2::transfer::public_transfer<0x2::coin::Coin<0x76ed920226db822677e4f23b47776f9ab4e1f5731ce5f7a44786ddf137cdfcd5::rmb::RMB>>(arg2, 0x2::tx_context::sender(arg4));
        } else {
            0x2::balance::join<0x76ed920226db822677e4f23b47776f9ab4e1f5731ce5f7a44786ddf137cdfcd5::rmb::RMB>(&mut arg0.amount, 0x2::coin::into_balance<0x76ed920226db822677e4f23b47776f9ab4e1f5731ce5f7a44786ddf137cdfcd5::rmb::RMB>(arg2));
        };
    }

    public entry fun withdraw(arg0: &AdminCap, arg1: &mut MyGame, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        if (arg2 > 0x2::balance::value<0x76ed920226db822677e4f23b47776f9ab4e1f5731ce5f7a44786ddf137cdfcd5::rmb::RMB>(&arg1.amount)) {
            abort 500
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x76ed920226db822677e4f23b47776f9ab4e1f5731ce5f7a44786ddf137cdfcd5::rmb::RMB>>(0x2::coin::from_balance<0x76ed920226db822677e4f23b47776f9ab4e1f5731ce5f7a44786ddf137cdfcd5::rmb::RMB>(0x2::balance::split<0x76ed920226db822677e4f23b47776f9ab4e1f5731ce5f7a44786ddf137cdfcd5::rmb::RMB>(&mut arg1.amount, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

