module 0x2c3faadfbc7176762d563ffbb1375c7d5459b408aa5043b3b4ab7bd22c6b58a7::guess_dice {
    struct GuessDice has key {
        id: 0x2::object::UID,
        amt: 0x2::balance::Balance<0xd0ed551927a06ebc54ed5aaaf9e45ccf8b0c5ee1da96fdc91ecd90cea3ae1b0c::my_token_faucet::MY_TOKEN_FAUCET>,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    public entry fun add(arg0: 0x2::coin::Coin<0xd0ed551927a06ebc54ed5aaaf9e45ccf8b0c5ee1da96fdc91ecd90cea3ae1b0c::my_token_faucet::MY_TOKEN_FAUCET>, arg1: &mut GuessDice, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0xd0ed551927a06ebc54ed5aaaf9e45ccf8b0c5ee1da96fdc91ecd90cea3ae1b0c::my_token_faucet::MY_TOKEN_FAUCET>(&mut arg1.amt, 0x2::coin::into_balance<0xd0ed551927a06ebc54ed5aaaf9e45ccf8b0c5ee1da96fdc91ecd90cea3ae1b0c::my_token_faucet::MY_TOKEN_FAUCET>(arg0));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = GuessDice{
            id  : 0x2::object::new(arg0),
            amt : 0x2::balance::zero<0xd0ed551927a06ebc54ed5aaaf9e45ccf8b0c5ee1da96fdc91ecd90cea3ae1b0c::my_token_faucet::MY_TOKEN_FAUCET>(),
        };
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<GuessDice>(v0);
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    entry fun play(arg0: u8, arg1: 0x2::coin::Coin<0xd0ed551927a06ebc54ed5aaaf9e45ccf8b0c5ee1da96fdc91ecd90cea3ae1b0c::my_token_faucet::MY_TOKEN_FAUCET>, arg2: &0x2::random::Random, arg3: &mut GuessDice, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0xd0ed551927a06ebc54ed5aaaf9e45ccf8b0c5ee1da96fdc91ecd90cea3ae1b0c::my_token_faucet::MY_TOKEN_FAUCET>(&arg1);
        assert!(0x2::balance::value<0xd0ed551927a06ebc54ed5aaaf9e45ccf8b0c5ee1da96fdc91ecd90cea3ae1b0c::my_token_faucet::MY_TOKEN_FAUCET>(&arg3.amt) >= v0 * 2, 8738);
        let v1 = 0x2::random::new_generator(arg2, arg4);
        assert!(arg0 > 6, 273);
        if (arg0 == 0x2::random::generate_u8_in_range(&mut v1, 1, 6)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xd0ed551927a06ebc54ed5aaaf9e45ccf8b0c5ee1da96fdc91ecd90cea3ae1b0c::my_token_faucet::MY_TOKEN_FAUCET>>(arg1, 0x2::tx_context::sender(arg4));
            0x2::transfer::public_transfer<0x2::coin::Coin<0xd0ed551927a06ebc54ed5aaaf9e45ccf8b0c5ee1da96fdc91ecd90cea3ae1b0c::my_token_faucet::MY_TOKEN_FAUCET>>(0x2::coin::from_balance<0xd0ed551927a06ebc54ed5aaaf9e45ccf8b0c5ee1da96fdc91ecd90cea3ae1b0c::my_token_faucet::MY_TOKEN_FAUCET>(0x2::balance::split<0xd0ed551927a06ebc54ed5aaaf9e45ccf8b0c5ee1da96fdc91ecd90cea3ae1b0c::my_token_faucet::MY_TOKEN_FAUCET>(&mut arg3.amt, v0), arg4), 0x2::tx_context::sender(arg4));
        } else {
            0x2::balance::join<0xd0ed551927a06ebc54ed5aaaf9e45ccf8b0c5ee1da96fdc91ecd90cea3ae1b0c::my_token_faucet::MY_TOKEN_FAUCET>(&mut arg3.amt, 0x2::coin::into_balance<0xd0ed551927a06ebc54ed5aaaf9e45ccf8b0c5ee1da96fdc91ecd90cea3ae1b0c::my_token_faucet::MY_TOKEN_FAUCET>(arg1));
        };
    }

    public entry fun remove(arg0: &AdminCap, arg1: u64, arg2: &mut GuessDice, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0xd0ed551927a06ebc54ed5aaaf9e45ccf8b0c5ee1da96fdc91ecd90cea3ae1b0c::my_token_faucet::MY_TOKEN_FAUCET>>(0x2::coin::from_balance<0xd0ed551927a06ebc54ed5aaaf9e45ccf8b0c5ee1da96fdc91ecd90cea3ae1b0c::my_token_faucet::MY_TOKEN_FAUCET>(0x2::balance::split<0xd0ed551927a06ebc54ed5aaaf9e45ccf8b0c5ee1da96fdc91ecd90cea3ae1b0c::my_token_faucet::MY_TOKEN_FAUCET>(&mut arg2.amt, arg1), arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

