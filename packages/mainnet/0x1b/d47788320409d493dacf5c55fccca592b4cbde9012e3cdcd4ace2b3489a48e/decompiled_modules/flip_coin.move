module 0x1bd47788320409d493dacf5c55fccca592b4cbde9012e3cdcd4ace2b3489a48e::flip_coin {
    struct Game has key {
        id: 0x2::object::UID,
        val: 0x2::balance::Balance<0xd3929e729b017a3c1ce40a4458cc00db8e71bb5882c99b1fe86bdc25899bb2ce::leon_dev_1024_faucet_coin::LEON_DEV_1024_FAUCET_COIN>,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    public entry fun add_sui(arg0: &mut Game, arg1: 0x2::coin::Coin<0xd3929e729b017a3c1ce40a4458cc00db8e71bb5882c99b1fe86bdc25899bb2ce::leon_dev_1024_faucet_coin::LEON_DEV_1024_FAUCET_COIN>, arg2: &0x2::tx_context::TxContext) {
        0x2::balance::join<0xd3929e729b017a3c1ce40a4458cc00db8e71bb5882c99b1fe86bdc25899bb2ce::leon_dev_1024_faucet_coin::LEON_DEV_1024_FAUCET_COIN>(&mut arg0.val, 0x2::coin::into_balance<0xd3929e729b017a3c1ce40a4458cc00db8e71bb5882c99b1fe86bdc25899bb2ce::leon_dev_1024_faucet_coin::LEON_DEV_1024_FAUCET_COIN>(arg1));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Game{
            id  : 0x2::object::new(arg0),
            val : 0x2::balance::zero<0xd3929e729b017a3c1ce40a4458cc00db8e71bb5882c99b1fe86bdc25899bb2ce::leon_dev_1024_faucet_coin::LEON_DEV_1024_FAUCET_COIN>(),
        };
        0x2::transfer::share_object<Game>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    entry fun play(arg0: &mut Game, arg1: bool, arg2: 0x2::coin::Coin<0xd3929e729b017a3c1ce40a4458cc00db8e71bb5882c99b1fe86bdc25899bb2ce::leon_dev_1024_faucet_coin::LEON_DEV_1024_FAUCET_COIN>, arg3: &0x2::random::Random, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0xd3929e729b017a3c1ce40a4458cc00db8e71bb5882c99b1fe86bdc25899bb2ce::leon_dev_1024_faucet_coin::LEON_DEV_1024_FAUCET_COIN>(&arg2);
        let v1 = 0x2::tx_context::sender(arg4);
        let v2 = 0x2::balance::value<0xd3929e729b017a3c1ce40a4458cc00db8e71bb5882c99b1fe86bdc25899bb2ce::leon_dev_1024_faucet_coin::LEON_DEV_1024_FAUCET_COIN>(&arg0.val);
        if (v2 < v0) {
            abort 100
        };
        if (v0 > v2 / 10) {
            abort 101
        };
        let v3 = 0x2::random::new_generator(arg3, arg4);
        if (arg1 == 0x2::random::generate_bool(&mut v3)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xd3929e729b017a3c1ce40a4458cc00db8e71bb5882c99b1fe86bdc25899bb2ce::leon_dev_1024_faucet_coin::LEON_DEV_1024_FAUCET_COIN>>(0x2::coin::from_balance<0xd3929e729b017a3c1ce40a4458cc00db8e71bb5882c99b1fe86bdc25899bb2ce::leon_dev_1024_faucet_coin::LEON_DEV_1024_FAUCET_COIN>(0x2::balance::split<0xd3929e729b017a3c1ce40a4458cc00db8e71bb5882c99b1fe86bdc25899bb2ce::leon_dev_1024_faucet_coin::LEON_DEV_1024_FAUCET_COIN>(&mut arg0.val, v0), arg4), v1);
            0x2::transfer::public_transfer<0x2::coin::Coin<0xd3929e729b017a3c1ce40a4458cc00db8e71bb5882c99b1fe86bdc25899bb2ce::leon_dev_1024_faucet_coin::LEON_DEV_1024_FAUCET_COIN>>(arg2, v1);
        } else {
            0x2::balance::join<0xd3929e729b017a3c1ce40a4458cc00db8e71bb5882c99b1fe86bdc25899bb2ce::leon_dev_1024_faucet_coin::LEON_DEV_1024_FAUCET_COIN>(&mut arg0.val, 0x2::coin::into_balance<0xd3929e729b017a3c1ce40a4458cc00db8e71bb5882c99b1fe86bdc25899bb2ce::leon_dev_1024_faucet_coin::LEON_DEV_1024_FAUCET_COIN>(arg2));
        };
    }

    public entry fun remove_sui(arg0: &AdminCap, arg1: &mut Game, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0xd3929e729b017a3c1ce40a4458cc00db8e71bb5882c99b1fe86bdc25899bb2ce::leon_dev_1024_faucet_coin::LEON_DEV_1024_FAUCET_COIN>>(0x2::coin::from_balance<0xd3929e729b017a3c1ce40a4458cc00db8e71bb5882c99b1fe86bdc25899bb2ce::leon_dev_1024_faucet_coin::LEON_DEV_1024_FAUCET_COIN>(0x2::balance::split<0xd3929e729b017a3c1ce40a4458cc00db8e71bb5882c99b1fe86bdc25899bb2ce::leon_dev_1024_faucet_coin::LEON_DEV_1024_FAUCET_COIN>(&mut arg1.val, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

