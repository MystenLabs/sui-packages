module 0x2e190d55b00c4cf6b068305530753b149c2e5618ddd39a8ac3cd0b76deec8c35::fly_game {
    struct FlyGame has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0x4c6dc55a1d670c1cf6e5fc05af631f6108bdbc603826aaef1e51abe329a8e1c4::faucet_fly::FAUCET_FLY>,
    }

    struct Admin has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
    }

    public entry fun Deposit(arg0: &mut FlyGame, arg1: &mut 0x2::coin::Coin<0x4c6dc55a1d670c1cf6e5fc05af631f6108bdbc603826aaef1e51abe329a8e1c4::faucet_fly::FAUCET_FLY>, arg2: u64) {
        assert!(0x2::coin::value<0x4c6dc55a1d670c1cf6e5fc05af631f6108bdbc603826aaef1e51abe329a8e1c4::faucet_fly::FAUCET_FLY>(arg1) >= arg2, 1000);
        0x2::balance::join<0x4c6dc55a1d670c1cf6e5fc05af631f6108bdbc603826aaef1e51abe329a8e1c4::faucet_fly::FAUCET_FLY>(&mut arg0.balance, 0x2::balance::split<0x4c6dc55a1d670c1cf6e5fc05af631f6108bdbc603826aaef1e51abe329a8e1c4::faucet_fly::FAUCET_FLY>(0x2::coin::balance_mut<0x4c6dc55a1d670c1cf6e5fc05af631f6108bdbc603826aaef1e51abe329a8e1c4::faucet_fly::FAUCET_FLY>(arg1), arg2));
    }

    entry fun Play(arg0: &mut FlyGame, arg1: &0x2::random::Random, arg2: bool, arg3: &mut 0x2::coin::Coin<0x4c6dc55a1d670c1cf6e5fc05af631f6108bdbc603826aaef1e51abe329a8e1c4::faucet_fly::FAUCET_FLY>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<0x4c6dc55a1d670c1cf6e5fc05af631f6108bdbc603826aaef1e51abe329a8e1c4::faucet_fly::FAUCET_FLY>(&arg0.balance) >= arg4, 1001);
        assert!(0x2::coin::value<0x4c6dc55a1d670c1cf6e5fc05af631f6108bdbc603826aaef1e51abe329a8e1c4::faucet_fly::FAUCET_FLY>(arg3) >= arg4, 1000);
        assert!(arg4 * 10 <= 0x2::balance::value<0x4c6dc55a1d670c1cf6e5fc05af631f6108bdbc603826aaef1e51abe329a8e1c4::faucet_fly::FAUCET_FLY>(&arg0.balance), 1001);
        let v0 = 0x2::random::new_generator(arg1, arg5);
        if (0x2::random::generate_bool(&mut v0) == arg2) {
            0x2::coin::join<0x4c6dc55a1d670c1cf6e5fc05af631f6108bdbc603826aaef1e51abe329a8e1c4::faucet_fly::FAUCET_FLY>(arg3, 0x2::coin::take<0x4c6dc55a1d670c1cf6e5fc05af631f6108bdbc603826aaef1e51abe329a8e1c4::faucet_fly::FAUCET_FLY>(&mut arg0.balance, arg4, arg5));
        } else {
            Deposit(arg0, arg3, arg4);
        };
    }

    public entry fun Withdraw(arg0: &mut FlyGame, arg1: &Admin, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<0x4c6dc55a1d670c1cf6e5fc05af631f6108bdbc603826aaef1e51abe329a8e1c4::faucet_fly::FAUCET_FLY>(&arg0.balance) >= arg2, 1001);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x4c6dc55a1d670c1cf6e5fc05af631f6108bdbc603826aaef1e51abe329a8e1c4::faucet_fly::FAUCET_FLY>>(0x2::coin::take<0x4c6dc55a1d670c1cf6e5fc05af631f6108bdbc603826aaef1e51abe329a8e1c4::faucet_fly::FAUCET_FLY>(&mut arg0.balance, arg2, arg3), 0x2::tx_context::sender(arg3));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = FlyGame{
            id      : 0x2::object::new(arg0),
            balance : 0x2::balance::zero<0x4c6dc55a1d670c1cf6e5fc05af631f6108bdbc603826aaef1e51abe329a8e1c4::faucet_fly::FAUCET_FLY>(),
        };
        let v1 = Admin{
            id   : 0x2::object::new(arg0),
            name : 0x1::string::utf8(b"coachafei"),
        };
        0x2::transfer::transfer<Admin>(v1, 0x2::tx_context::sender(arg0));
        0x2::transfer::share_object<FlyGame>(v0);
    }

    // decompiled from Move bytecode v6
}

