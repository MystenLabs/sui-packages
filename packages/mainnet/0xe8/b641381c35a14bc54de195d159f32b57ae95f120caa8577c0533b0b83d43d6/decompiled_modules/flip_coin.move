module 0xe8b641381c35a14bc54de195d159f32b57ae95f120caa8577c0533b0b83d43d6::flip_coin {
    struct Game has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        amt: 0x2::balance::Balance<0xe93d2cc472732bd42c10c031d28f15f525b3f98ab4eceee9490a820c313e36c8::shuCoin::SHUCOIN>,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    public entry fun add_coin(arg0: &mut Game, arg1: 0x2::coin::Coin<0xe93d2cc472732bd42c10c031d28f15f525b3f98ab4eceee9490a820c313e36c8::shuCoin::SHUCOIN>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0xe93d2cc472732bd42c10c031d28f15f525b3f98ab4eceee9490a820c313e36c8::shuCoin::SHUCOIN>(&mut arg0.amt, 0x2::coin::into_balance<0xe93d2cc472732bd42c10c031d28f15f525b3f98ab4eceee9490a820c313e36c8::shuCoin::SHUCOIN>(arg1));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Game{
            id   : 0x2::object::new(arg0),
            name : 0x1::string::utf8(b"my game by shuCoin"),
            amt  : 0x2::balance::zero<0xe93d2cc472732bd42c10c031d28f15f525b3f98ab4eceee9490a820c313e36c8::shuCoin::SHUCOIN>(),
        };
        0x2::transfer::share_object<Game>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    entry fun play(arg0: &mut Game, arg1: &0x2::random::Random, arg2: bool, arg3: 0x2::coin::Coin<0xe93d2cc472732bd42c10c031d28f15f525b3f98ab4eceee9490a820c313e36c8::shuCoin::SHUCOIN>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0xe93d2cc472732bd42c10c031d28f15f525b3f98ab4eceee9490a820c313e36c8::shuCoin::SHUCOIN>(&arg3);
        assert!(0x2::balance::value<0xe93d2cc472732bd42c10c031d28f15f525b3f98ab4eceee9490a820c313e36c8::shuCoin::SHUCOIN>(&arg0.amt) >= v0 * 10, 273);
        let v1 = 0x2::random::new_generator(arg1, arg4);
        if (arg2 == 0x2::random::generate_bool(&mut v1)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xe93d2cc472732bd42c10c031d28f15f525b3f98ab4eceee9490a820c313e36c8::shuCoin::SHUCOIN>>(0x2::coin::from_balance<0xe93d2cc472732bd42c10c031d28f15f525b3f98ab4eceee9490a820c313e36c8::shuCoin::SHUCOIN>(0x2::balance::split<0xe93d2cc472732bd42c10c031d28f15f525b3f98ab4eceee9490a820c313e36c8::shuCoin::SHUCOIN>(&mut arg0.amt, v0), arg4), 0x2::tx_context::sender(arg4));
            0x2::transfer::public_transfer<0x2::coin::Coin<0xe93d2cc472732bd42c10c031d28f15f525b3f98ab4eceee9490a820c313e36c8::shuCoin::SHUCOIN>>(arg3, 0x2::tx_context::sender(arg4));
        } else {
            0x2::balance::join<0xe93d2cc472732bd42c10c031d28f15f525b3f98ab4eceee9490a820c313e36c8::shuCoin::SHUCOIN>(&mut arg0.amt, 0x2::coin::into_balance<0xe93d2cc472732bd42c10c031d28f15f525b3f98ab4eceee9490a820c313e36c8::shuCoin::SHUCOIN>(arg3));
        };
    }

    public entry fun remove_coin(arg0: &AdminCap, arg1: &mut Game, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0xe93d2cc472732bd42c10c031d28f15f525b3f98ab4eceee9490a820c313e36c8::shuCoin::SHUCOIN>>(0x2::coin::from_balance<0xe93d2cc472732bd42c10c031d28f15f525b3f98ab4eceee9490a820c313e36c8::shuCoin::SHUCOIN>(0x2::balance::split<0xe93d2cc472732bd42c10c031d28f15f525b3f98ab4eceee9490a820c313e36c8::shuCoin::SHUCOIN>(&mut arg1.amt, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

