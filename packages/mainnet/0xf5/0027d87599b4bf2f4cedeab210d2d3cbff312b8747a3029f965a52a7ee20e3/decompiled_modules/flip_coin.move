module 0xf50027d87599b4bf2f4cedeab210d2d3cbff312b8747a3029f965a52a7ee20e3::flip_coin {
    struct Game has key {
        id: 0x2::object::UID,
        amt: 0x2::balance::Balance<0xb9c287d9b42658529c0ea61b0ad36aeded7aa8c99bf1cce645a90d660ff8a349::faucetcoin::FAUCETCOIN>,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
    }

    public entry fun add_sui(arg0: &mut Game, arg1: 0x2::coin::Coin<0xb9c287d9b42658529c0ea61b0ad36aeded7aa8c99bf1cce645a90d660ff8a349::faucetcoin::FAUCETCOIN>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0xb9c287d9b42658529c0ea61b0ad36aeded7aa8c99bf1cce645a90d660ff8a349::faucetcoin::FAUCETCOIN>(&mut arg0.amt, 0x2::coin::into_balance<0xb9c287d9b42658529c0ea61b0ad36aeded7aa8c99bf1cce645a90d660ff8a349::faucetcoin::FAUCETCOIN>(arg1));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Game{
            id  : 0x2::object::new(arg0),
            amt : 0x2::balance::zero<0xb9c287d9b42658529c0ea61b0ad36aeded7aa8c99bf1cce645a90d660ff8a349::faucetcoin::FAUCETCOIN>(),
        };
        0x2::transfer::share_object<Game>(v0);
        let v1 = AdminCap{
            id   : 0x2::object::new(arg0),
            name : 0x1::string::utf8(b"FFclever"),
        };
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    entry fun play(arg0: &mut Game, arg1: &0x2::random::Random, arg2: bool, arg3: 0x2::coin::Coin<0xb9c287d9b42658529c0ea61b0ad36aeded7aa8c99bf1cce645a90d660ff8a349::faucetcoin::FAUCETCOIN>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0xb9c287d9b42658529c0ea61b0ad36aeded7aa8c99bf1cce645a90d660ff8a349::faucetcoin::FAUCETCOIN>(&arg3);
        assert!(0x2::balance::value<0xb9c287d9b42658529c0ea61b0ad36aeded7aa8c99bf1cce645a90d660ff8a349::faucetcoin::FAUCETCOIN>(&arg0.amt) >= v0 * 10, 273);
        let v1 = 0x2::random::new_generator(arg1, arg4);
        if (arg2 == 0x2::random::generate_bool(&mut v1)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xb9c287d9b42658529c0ea61b0ad36aeded7aa8c99bf1cce645a90d660ff8a349::faucetcoin::FAUCETCOIN>>(0x2::coin::from_balance<0xb9c287d9b42658529c0ea61b0ad36aeded7aa8c99bf1cce645a90d660ff8a349::faucetcoin::FAUCETCOIN>(0x2::balance::split<0xb9c287d9b42658529c0ea61b0ad36aeded7aa8c99bf1cce645a90d660ff8a349::faucetcoin::FAUCETCOIN>(&mut arg0.amt, v0), arg4), 0x2::tx_context::sender(arg4));
            0x2::transfer::public_transfer<0x2::coin::Coin<0xb9c287d9b42658529c0ea61b0ad36aeded7aa8c99bf1cce645a90d660ff8a349::faucetcoin::FAUCETCOIN>>(arg3, 0x2::tx_context::sender(arg4));
        } else {
            0x2::balance::join<0xb9c287d9b42658529c0ea61b0ad36aeded7aa8c99bf1cce645a90d660ff8a349::faucetcoin::FAUCETCOIN>(&mut arg0.amt, 0x2::coin::into_balance<0xb9c287d9b42658529c0ea61b0ad36aeded7aa8c99bf1cce645a90d660ff8a349::faucetcoin::FAUCETCOIN>(arg3));
        };
    }

    public entry fun remove_sui(arg0: &AdminCap, arg1: &mut Game, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0xb9c287d9b42658529c0ea61b0ad36aeded7aa8c99bf1cce645a90d660ff8a349::faucetcoin::FAUCETCOIN>>(0x2::coin::from_balance<0xb9c287d9b42658529c0ea61b0ad36aeded7aa8c99bf1cce645a90d660ff8a349::faucetcoin::FAUCETCOIN>(0x2::balance::split<0xb9c287d9b42658529c0ea61b0ad36aeded7aa8c99bf1cce645a90d660ff8a349::faucetcoin::FAUCETCOIN>(&mut arg1.amt, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

