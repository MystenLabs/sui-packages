module 0x12aa2008a54b7be74ef8f4ee515498f8972299b22a90840ea14379ebc935f62f::mcraffle {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct GamePool has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0x9969677c39e8e668b0bc21db0ddf0aec6d636ebb71f210b593ff9a3154cafeb5::faucetqwrdxercoin::FAUCETQWRDXERCOIN>,
    }

    struct GameNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
        catalog: u8,
    }

    struct GameResultEmit has copy, drop {
        r1: u16,
        user_address: address,
    }

    struct PoolAmountEmit has copy, drop {
        pool_amount: u64,
    }

    struct MCRAFFLE has drop {
        dummy_field: bool,
    }

    public entry fun depositeCoin(arg0: &mut AdminCap, arg1: &mut GamePool, arg2: &mut 0x2::coin::Coin<0x9969677c39e8e668b0bc21db0ddf0aec6d636ebb71f210b593ff9a3154cafeb5::faucetqwrdxercoin::FAUCETQWRDXERCOIN>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x9969677c39e8e668b0bc21db0ddf0aec6d636ebb71f210b593ff9a3154cafeb5::faucetqwrdxercoin::FAUCETQWRDXERCOIN>(arg2) >= arg3, 50);
        0x2::balance::join<0x9969677c39e8e668b0bc21db0ddf0aec6d636ebb71f210b593ff9a3154cafeb5::faucetqwrdxercoin::FAUCETQWRDXERCOIN>(&mut arg1.balance, 0x2::balance::split<0x9969677c39e8e668b0bc21db0ddf0aec6d636ebb71f210b593ff9a3154cafeb5::faucetqwrdxercoin::FAUCETQWRDXERCOIN>(0x2::coin::balance_mut<0x9969677c39e8e668b0bc21db0ddf0aec6d636ebb71f210b593ff9a3154cafeb5::faucetqwrdxercoin::FAUCETQWRDXERCOIN>(arg2), arg3));
        let v0 = PoolAmountEmit{pool_amount: 0x2::balance::value<0x9969677c39e8e668b0bc21db0ddf0aec6d636ebb71f210b593ff9a3154cafeb5::faucetqwrdxercoin::FAUCETQWRDXERCOIN>(&arg1.balance)};
        0x2::event::emit<PoolAmountEmit>(v0);
    }

    fun init(arg0: MCRAFFLE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"raffle"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Raffle"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://sui-raffle.io"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Unknown Sui Fan"));
        let v4 = 0x2::package::claim<MCRAFFLE>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<GameNFT>(&v4, v0, v2, arg1);
        0x2::display::update_version<GameNFT>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<GameNFT>>(v5, 0x2::tx_context::sender(arg1));
        let v6 = GamePool{
            id      : 0x2::object::new(arg1),
            balance : 0x2::balance::zero<0x9969677c39e8e668b0bc21db0ddf0aec6d636ebb71f210b593ff9a3154cafeb5::faucetqwrdxercoin::FAUCETQWRDXERCOIN>(),
        };
        0x2::transfer::share_object<GamePool>(v6);
        let v7 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v7, 0x2::tx_context::sender(arg1));
    }

    public entry fun raffle_exchange(arg0: &mut GamePool, arg1: GameNFT, arg2: &mut 0x2::tx_context::TxContext) {
        let GameNFT {
            id        : v0,
            name      : _,
            image_url : _,
            catalog   : v3,
        } = arg1;
        if (v3 == 1) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x9969677c39e8e668b0bc21db0ddf0aec6d636ebb71f210b593ff9a3154cafeb5::faucetqwrdxercoin::FAUCETQWRDXERCOIN>>(0x2::coin::take<0x9969677c39e8e668b0bc21db0ddf0aec6d636ebb71f210b593ff9a3154cafeb5::faucetqwrdxercoin::FAUCETQWRDXERCOIN>(&mut arg0.balance, 0x2::math::divide_and_round_up(0x2::balance::value<0x9969677c39e8e668b0bc21db0ddf0aec6d636ebb71f210b593ff9a3154cafeb5::faucetqwrdxercoin::FAUCETQWRDXERCOIN>(&arg0.balance), 20), arg2), 0x2::tx_context::sender(arg2));
        };
        if (v3 == 2) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x9969677c39e8e668b0bc21db0ddf0aec6d636ebb71f210b593ff9a3154cafeb5::faucetqwrdxercoin::FAUCETQWRDXERCOIN>>(0x2::coin::take<0x9969677c39e8e668b0bc21db0ddf0aec6d636ebb71f210b593ff9a3154cafeb5::faucetqwrdxercoin::FAUCETQWRDXERCOIN>(&mut arg0.balance, 0x2::math::divide_and_round_up(0x2::balance::value<0x9969677c39e8e668b0bc21db0ddf0aec6d636ebb71f210b593ff9a3154cafeb5::faucetqwrdxercoin::FAUCETQWRDXERCOIN>(&arg0.balance), 33), arg2), 0x2::tx_context::sender(arg2));
        };
        if (v3 == 3) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x9969677c39e8e668b0bc21db0ddf0aec6d636ebb71f210b593ff9a3154cafeb5::faucetqwrdxercoin::FAUCETQWRDXERCOIN>>(0x2::coin::take<0x9969677c39e8e668b0bc21db0ddf0aec6d636ebb71f210b593ff9a3154cafeb5::faucetqwrdxercoin::FAUCETQWRDXERCOIN>(&mut arg0.balance, 0x2::math::divide_and_round_up(0x2::balance::value<0x9969677c39e8e668b0bc21db0ddf0aec6d636ebb71f210b593ff9a3154cafeb5::faucetqwrdxercoin::FAUCETQWRDXERCOIN>(&arg0.balance), 100), arg2), 0x2::tx_context::sender(arg2));
        };
        if (v3 == 4) {
            0x2::balance::value<0x9969677c39e8e668b0bc21db0ddf0aec6d636ebb71f210b593ff9a3154cafeb5::faucetqwrdxercoin::FAUCETQWRDXERCOIN>(&arg0.balance);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x9969677c39e8e668b0bc21db0ddf0aec6d636ebb71f210b593ff9a3154cafeb5::faucetqwrdxercoin::FAUCETQWRDXERCOIN>>(0x2::coin::take<0x9969677c39e8e668b0bc21db0ddf0aec6d636ebb71f210b593ff9a3154cafeb5::faucetqwrdxercoin::FAUCETQWRDXERCOIN>(&mut arg0.balance, 10000000, arg2), 0x2::tx_context::sender(arg2));
        };
        0x2::object::delete(v0);
    }

    public entry fun raffle_play(arg0: &mut GamePool, arg1: &0x2::random::Random, arg2: &mut 0x2::coin::Coin<0x9969677c39e8e668b0bc21db0ddf0aec6d636ebb71f210b593ff9a3154cafeb5::faucetqwrdxercoin::FAUCETQWRDXERCOIN>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x9969677c39e8e668b0bc21db0ddf0aec6d636ebb71f210b593ff9a3154cafeb5::faucetqwrdxercoin::FAUCETQWRDXERCOIN>(arg2) >= 20000000, 50);
        0x2::balance::join<0x9969677c39e8e668b0bc21db0ddf0aec6d636ebb71f210b593ff9a3154cafeb5::faucetqwrdxercoin::FAUCETQWRDXERCOIN>(&mut arg0.balance, 0x2::balance::split<0x9969677c39e8e668b0bc21db0ddf0aec6d636ebb71f210b593ff9a3154cafeb5::faucetqwrdxercoin::FAUCETQWRDXERCOIN>(0x2::coin::balance_mut<0x9969677c39e8e668b0bc21db0ddf0aec6d636ebb71f210b593ff9a3154cafeb5::faucetqwrdxercoin::FAUCETQWRDXERCOIN>(arg2), 20000000));
        let v0 = 0x2::random::new_generator(arg1, arg3);
        let v1 = 0x2::random::generate_u16_in_range(&mut v0, 1, 1000);
        let v2 = GameResultEmit{
            r1           : v1,
            user_address : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<GameResultEmit>(v2);
        if (v1 > 900) {
            let v3 = GameNFT{
                id        : 0x2::object::new(arg3),
                name      : 0x1::string::utf8(b"Congratulations on obtaining the Enchanted Golden Apple!"),
                image_url : 0x1::string::utf8(b"https://i.mcmod.cn/item/icon/128x128/11/118550.png"),
                catalog   : 1,
            };
            0x2::transfer::public_transfer<GameNFT>(v3, 0x2::tx_context::sender(arg3));
        } else if (v1 > 700) {
            let v4 = GameNFT{
                id        : 0x2::object::new(arg3),
                name      : 0x1::string::utf8(b"Congratulations on obtaining the  Golden Apple!"),
                image_url : 0x1::string::utf8(b"https://i.mcmod.cn/editor/upload/20240915/1726376603_899182_aqta.webp"),
                catalog   : 2,
            };
            0x2::transfer::public_transfer<GameNFT>(v4, 0x2::tx_context::sender(arg3));
        } else if (v1 > 400) {
            let v5 = GameNFT{
                id        : 0x2::object::new(arg3),
                name      : 0x1::string::utf8(b"Congratulations on obtaining the  Apple!"),
                image_url : 0x1::string::utf8(b"https://i.mcmod.cn/editor/upload/20241014/1728881348_899182_HjeV.webp"),
                catalog   : 3,
            };
            0x2::transfer::public_transfer<GameNFT>(v5, 0x2::tx_context::sender(arg3));
        } else if (v1 > 200) {
            let v6 = GameNFT{
                id        : 0x2::object::new(arg3),
                name      : 0x1::string::utf8(b"Congratulations on obtaining the  BREAD!"),
                image_url : 0x1::string::utf8(b"https://i.mcmod.cn/editor/upload/20240915/1726382983_899182_YYyp.webp"),
                catalog   : 4,
            };
            0x2::transfer::public_transfer<GameNFT>(v6, 0x2::tx_context::sender(arg3));
        };
    }

    public entry fun withdrawCoin(arg0: &mut AdminCap, arg1: &mut GamePool, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x9969677c39e8e668b0bc21db0ddf0aec6d636ebb71f210b593ff9a3154cafeb5::faucetqwrdxercoin::FAUCETQWRDXERCOIN>>(0x2::coin::take<0x9969677c39e8e668b0bc21db0ddf0aec6d636ebb71f210b593ff9a3154cafeb5::faucetqwrdxercoin::FAUCETQWRDXERCOIN>(&mut arg1.balance, arg2, arg3), 0x2::tx_context::sender(arg3));
        let v0 = PoolAmountEmit{pool_amount: 0x2::balance::value<0x9969677c39e8e668b0bc21db0ddf0aec6d636ebb71f210b593ff9a3154cafeb5::faucetqwrdxercoin::FAUCETQWRDXERCOIN>(&arg1.balance)};
        0x2::event::emit<PoolAmountEmit>(v0);
    }

    // decompiled from Move bytecode v6
}

