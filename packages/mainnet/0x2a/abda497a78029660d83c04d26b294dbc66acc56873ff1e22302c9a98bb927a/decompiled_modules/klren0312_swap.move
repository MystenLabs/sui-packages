module 0x2aabda497a78029660d83c04d26b294dbc66acc56873ff1e22302c9a98bb927a::klren0312_swap {
    struct SwapPool has key {
        id: 0x2::object::UID,
        trump_coin: 0x2::balance::Balance<0xc9fbe1280a650aecbfdad2a06fcb3d9caee10c07a1c0ae405e8494727d3a29a5::TRUMP_COIN::TRUMP_COIN>,
        zcdc_coin: 0x2::balance::Balance<0x443d66aba5c1406566704a5dee8f59ff79e2c667b32022a5daf054530d4ab1e3::ZCDCCOIN::ZCDCCOIN>,
    }

    entry fun create_swap_pool(arg0: 0x2::coin::Coin<0xc9fbe1280a650aecbfdad2a06fcb3d9caee10c07a1c0ae405e8494727d3a29a5::TRUMP_COIN::TRUMP_COIN>, arg1: 0x2::coin::Coin<0x443d66aba5c1406566704a5dee8f59ff79e2c667b32022a5daf054530d4ab1e3::ZCDCCOIN::ZCDCCOIN>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = SwapPool{
            id         : 0x2::object::new(arg2),
            trump_coin : 0x2::coin::into_balance<0xc9fbe1280a650aecbfdad2a06fcb3d9caee10c07a1c0ae405e8494727d3a29a5::TRUMP_COIN::TRUMP_COIN>(arg0),
            zcdc_coin  : 0x2::coin::into_balance<0x443d66aba5c1406566704a5dee8f59ff79e2c667b32022a5daf054530d4ab1e3::ZCDCCOIN::ZCDCCOIN>(arg1),
        };
        0x2::transfer::share_object<SwapPool>(v0);
    }

    entry fun swap_trump_to_zcdc(arg0: &mut SwapPool, arg1: 0x2::coin::Coin<0xc9fbe1280a650aecbfdad2a06fcb3d9caee10c07a1c0ae405e8494727d3a29a5::TRUMP_COIN::TRUMP_COIN>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::into_balance<0xc9fbe1280a650aecbfdad2a06fcb3d9caee10c07a1c0ae405e8494727d3a29a5::TRUMP_COIN::TRUMP_COIN>(arg1);
        let v1 = 0x2::balance::value<0xc9fbe1280a650aecbfdad2a06fcb3d9caee10c07a1c0ae405e8494727d3a29a5::TRUMP_COIN::TRUMP_COIN>(&v0) * 4;
        assert!(0x2::balance::value<0x443d66aba5c1406566704a5dee8f59ff79e2c667b32022a5daf054530d4ab1e3::ZCDCCOIN::ZCDCCOIN>(&arg0.zcdc_coin) >= v1, 0);
        0x2::balance::join<0xc9fbe1280a650aecbfdad2a06fcb3d9caee10c07a1c0ae405e8494727d3a29a5::TRUMP_COIN::TRUMP_COIN>(&mut arg0.trump_coin, v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x443d66aba5c1406566704a5dee8f59ff79e2c667b32022a5daf054530d4ab1e3::ZCDCCOIN::ZCDCCOIN>>(0x2::coin::from_balance<0x443d66aba5c1406566704a5dee8f59ff79e2c667b32022a5daf054530d4ab1e3::ZCDCCOIN::ZCDCCOIN>(0x2::balance::split<0x443d66aba5c1406566704a5dee8f59ff79e2c667b32022a5daf054530d4ab1e3::ZCDCCOIN::ZCDCCOIN>(&mut arg0.zcdc_coin, v1), arg2), 0x2::tx_context::sender(arg2));
    }

    entry fun swap_zcdc_to_trump(arg0: &mut SwapPool, arg1: 0x2::coin::Coin<0x443d66aba5c1406566704a5dee8f59ff79e2c667b32022a5daf054530d4ab1e3::ZCDCCOIN::ZCDCCOIN>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::into_balance<0x443d66aba5c1406566704a5dee8f59ff79e2c667b32022a5daf054530d4ab1e3::ZCDCCOIN::ZCDCCOIN>(arg1);
        let v1 = 0x2::balance::value<0x443d66aba5c1406566704a5dee8f59ff79e2c667b32022a5daf054530d4ab1e3::ZCDCCOIN::ZCDCCOIN>(&v0) / 4;
        assert!(0x2::balance::value<0xc9fbe1280a650aecbfdad2a06fcb3d9caee10c07a1c0ae405e8494727d3a29a5::TRUMP_COIN::TRUMP_COIN>(&arg0.trump_coin) >= v1, 0);
        0x2::balance::join<0x443d66aba5c1406566704a5dee8f59ff79e2c667b32022a5daf054530d4ab1e3::ZCDCCOIN::ZCDCCOIN>(&mut arg0.zcdc_coin, v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xc9fbe1280a650aecbfdad2a06fcb3d9caee10c07a1c0ae405e8494727d3a29a5::TRUMP_COIN::TRUMP_COIN>>(0x2::coin::from_balance<0xc9fbe1280a650aecbfdad2a06fcb3d9caee10c07a1c0ae405e8494727d3a29a5::TRUMP_COIN::TRUMP_COIN>(0x2::balance::split<0xc9fbe1280a650aecbfdad2a06fcb3d9caee10c07a1c0ae405e8494727d3a29a5::TRUMP_COIN::TRUMP_COIN>(&mut arg0.trump_coin, v1), arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

