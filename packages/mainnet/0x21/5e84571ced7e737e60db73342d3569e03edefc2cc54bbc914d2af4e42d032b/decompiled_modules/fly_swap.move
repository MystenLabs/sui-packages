module 0x215e84571ced7e737e60db73342d3569e03edefc2cc54bbc914d2af4e42d032b::fly_swap {
    struct Admin has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
    }

    struct Pool has key {
        id: 0x2::object::UID,
        my_coin: 0x2::balance::Balance<0xfbac44739874f3881631bc7714e2664592ae668a6a0d73f165893d3eee84b026::fly::FLY>,
        my_faucet_coin: 0x2::balance::Balance<0x4c6dc55a1d670c1cf6e5fc05af631f6108bdbc603826aaef1e51abe329a8e1c4::faucet_fly::FAUCET_FLY>,
    }

    public entry fun WithdrawFAUCET_FLY(arg0: &mut Pool, arg1: &Admin, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x4c6dc55a1d670c1cf6e5fc05af631f6108bdbc603826aaef1e51abe329a8e1c4::faucet_fly::FAUCET_FLY>>(0x2::coin::from_balance<0x4c6dc55a1d670c1cf6e5fc05af631f6108bdbc603826aaef1e51abe329a8e1c4::faucet_fly::FAUCET_FLY>(0x2::balance::split<0x4c6dc55a1d670c1cf6e5fc05af631f6108bdbc603826aaef1e51abe329a8e1c4::faucet_fly::FAUCET_FLY>(&mut arg0.my_faucet_coin, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    public entry fun WithdrawFLY(arg0: &mut Pool, arg1: &Admin, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<0xfbac44739874f3881631bc7714e2664592ae668a6a0d73f165893d3eee84b026::fly::FLY>(&arg0.my_coin) >= arg2, 1000);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xfbac44739874f3881631bc7714e2664592ae668a6a0d73f165893d3eee84b026::fly::FLY>>(0x2::coin::from_balance<0xfbac44739874f3881631bc7714e2664592ae668a6a0d73f165893d3eee84b026::fly::FLY>(0x2::balance::split<0xfbac44739874f3881631bc7714e2664592ae668a6a0d73f165893d3eee84b026::fly::FLY>(&mut arg0.my_coin, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    public entry fun deposit_faucet_fly(arg0: &mut Pool, arg1: &mut 0x2::coin::Coin<0x4c6dc55a1d670c1cf6e5fc05af631f6108bdbc603826aaef1e51abe329a8e1c4::faucet_fly::FAUCET_FLY>, arg2: u64) {
        assert!(0x2::coin::value<0x4c6dc55a1d670c1cf6e5fc05af631f6108bdbc603826aaef1e51abe329a8e1c4::faucet_fly::FAUCET_FLY>(arg1) >= arg2, 1000);
        0x2::balance::join<0x4c6dc55a1d670c1cf6e5fc05af631f6108bdbc603826aaef1e51abe329a8e1c4::faucet_fly::FAUCET_FLY>(&mut arg0.my_faucet_coin, 0x2::balance::split<0x4c6dc55a1d670c1cf6e5fc05af631f6108bdbc603826aaef1e51abe329a8e1c4::faucet_fly::FAUCET_FLY>(0x2::coin::balance_mut<0x4c6dc55a1d670c1cf6e5fc05af631f6108bdbc603826aaef1e51abe329a8e1c4::faucet_fly::FAUCET_FLY>(arg1), arg2));
    }

    public entry fun deposit_fly(arg0: &mut Pool, arg1: &mut 0x2::coin::Coin<0xfbac44739874f3881631bc7714e2664592ae668a6a0d73f165893d3eee84b026::fly::FLY>, arg2: u64) {
        assert!(0x2::coin::value<0xfbac44739874f3881631bc7714e2664592ae668a6a0d73f165893d3eee84b026::fly::FLY>(arg1) >= arg2, 1001);
        0x2::balance::join<0xfbac44739874f3881631bc7714e2664592ae668a6a0d73f165893d3eee84b026::fly::FLY>(&mut arg0.my_coin, 0x2::balance::split<0xfbac44739874f3881631bc7714e2664592ae668a6a0d73f165893d3eee84b026::fly::FLY>(0x2::coin::balance_mut<0xfbac44739874f3881631bc7714e2664592ae668a6a0d73f165893d3eee84b026::fly::FLY>(arg1), arg2));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Pool{
            id             : 0x2::object::new(arg0),
            my_coin        : 0x2::balance::zero<0xfbac44739874f3881631bc7714e2664592ae668a6a0d73f165893d3eee84b026::fly::FLY>(),
            my_faucet_coin : 0x2::balance::zero<0x4c6dc55a1d670c1cf6e5fc05af631f6108bdbc603826aaef1e51abe329a8e1c4::faucet_fly::FAUCET_FLY>(),
        };
        let v1 = Admin{
            id   : 0x2::object::new(arg0),
            name : 0x1::string::utf8(b"coachafei"),
        };
        0x2::transfer::share_object<Pool>(v0);
        0x2::transfer::transfer<Admin>(v1, 0x2::tx_context::sender(arg0));
    }

    public entry fun swap_faucet_fly_to_fly(arg0: &mut Pool, arg1: &mut 0x2::coin::Coin<0x4c6dc55a1d670c1cf6e5fc05af631f6108bdbc603826aaef1e51abe329a8e1c4::faucet_fly::FAUCET_FLY>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x4c6dc55a1d670c1cf6e5fc05af631f6108bdbc603826aaef1e51abe329a8e1c4::faucet_fly::FAUCET_FLY>(arg1) >= arg2 * 2000 / 1000, 1001);
        assert!(arg2 <= 0x2::balance::value<0xfbac44739874f3881631bc7714e2664592ae668a6a0d73f165893d3eee84b026::fly::FLY>(&arg0.my_coin), 1000);
        0x2::balance::join<0x4c6dc55a1d670c1cf6e5fc05af631f6108bdbc603826aaef1e51abe329a8e1c4::faucet_fly::FAUCET_FLY>(&mut arg0.my_faucet_coin, 0x2::balance::split<0x4c6dc55a1d670c1cf6e5fc05af631f6108bdbc603826aaef1e51abe329a8e1c4::faucet_fly::FAUCET_FLY>(0x2::coin::balance_mut<0x4c6dc55a1d670c1cf6e5fc05af631f6108bdbc603826aaef1e51abe329a8e1c4::faucet_fly::FAUCET_FLY>(arg1), arg2 * 2000 / 1000));
        0x2::transfer::public_transfer<0x2::coin::Coin<0xfbac44739874f3881631bc7714e2664592ae668a6a0d73f165893d3eee84b026::fly::FLY>>(0x2::coin::from_balance<0xfbac44739874f3881631bc7714e2664592ae668a6a0d73f165893d3eee84b026::fly::FLY>(0x2::balance::split<0xfbac44739874f3881631bc7714e2664592ae668a6a0d73f165893d3eee84b026::fly::FLY>(&mut arg0.my_coin, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    public entry fun swap_fly_to_faucet_fly(arg0: &mut Pool, arg1: &mut 0x2::coin::Coin<0xfbac44739874f3881631bc7714e2664592ae668a6a0d73f165893d3eee84b026::fly::FLY>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0xfbac44739874f3881631bc7714e2664592ae668a6a0d73f165893d3eee84b026::fly::FLY>(arg1) >= arg2 * 1000 / 2000, 1001);
        assert!(arg2 <= 0x2::balance::value<0x4c6dc55a1d670c1cf6e5fc05af631f6108bdbc603826aaef1e51abe329a8e1c4::faucet_fly::FAUCET_FLY>(&arg0.my_faucet_coin), 1000);
        0x2::balance::join<0xfbac44739874f3881631bc7714e2664592ae668a6a0d73f165893d3eee84b026::fly::FLY>(&mut arg0.my_coin, 0x2::balance::split<0xfbac44739874f3881631bc7714e2664592ae668a6a0d73f165893d3eee84b026::fly::FLY>(0x2::coin::balance_mut<0xfbac44739874f3881631bc7714e2664592ae668a6a0d73f165893d3eee84b026::fly::FLY>(arg1), arg2 * 1000 / 2000));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x4c6dc55a1d670c1cf6e5fc05af631f6108bdbc603826aaef1e51abe329a8e1c4::faucet_fly::FAUCET_FLY>>(0x2::coin::from_balance<0x4c6dc55a1d670c1cf6e5fc05af631f6108bdbc603826aaef1e51abe329a8e1c4::faucet_fly::FAUCET_FLY>(0x2::balance::split<0x4c6dc55a1d670c1cf6e5fc05af631f6108bdbc603826aaef1e51abe329a8e1c4::faucet_fly::FAUCET_FLY>(&mut arg0.my_faucet_coin, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

