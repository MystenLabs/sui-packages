module 0x6d4dd7fffe36cce18887a19a935df4cd45633546c947756ce7d45d1fbca9766e::earthchen {
    struct Bank has key {
        id: 0x2::object::UID,
        mycoin: 0x2::balance::Balance<0x4bc96f381df661fb3d79e15d4139df4fb4d59b8c3f52c3c24b90a0d2f53d5fa9::mycoin::MYCOIN>,
        faucetcoin: 0x2::balance::Balance<0x75f3683f1fcd141ae9831aee3f74262e9ba5458cbfb71297859215dd37e9ed9f::faucetcoin::FAUCETCOIN>,
        mc_prop: u64,
        fc_prop: u64,
    }

    struct AdaminCap has key {
        id: 0x2::object::UID,
    }

    public entry fun deposit_faucetcoin(arg0: &mut Bank, arg1: 0x2::coin::Coin<0x75f3683f1fcd141ae9831aee3f74262e9ba5458cbfb71297859215dd37e9ed9f::faucetcoin::FAUCETCOIN>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0x75f3683f1fcd141ae9831aee3f74262e9ba5458cbfb71297859215dd37e9ed9f::faucetcoin::FAUCETCOIN>(&mut arg0.faucetcoin, 0x2::coin::into_balance<0x75f3683f1fcd141ae9831aee3f74262e9ba5458cbfb71297859215dd37e9ed9f::faucetcoin::FAUCETCOIN>(arg1));
    }

    public entry fun deposit_mycoin(arg0: &mut Bank, arg1: 0x2::coin::Coin<0x4bc96f381df661fb3d79e15d4139df4fb4d59b8c3f52c3c24b90a0d2f53d5fa9::mycoin::MYCOIN>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0x4bc96f381df661fb3d79e15d4139df4fb4d59b8c3f52c3c24b90a0d2f53d5fa9::mycoin::MYCOIN>(&mut arg0.mycoin, 0x2::coin::into_balance<0x4bc96f381df661fb3d79e15d4139df4fb4d59b8c3f52c3c24b90a0d2f53d5fa9::mycoin::MYCOIN>(arg1));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Bank{
            id         : 0x2::object::new(arg0),
            mycoin     : 0x2::balance::zero<0x4bc96f381df661fb3d79e15d4139df4fb4d59b8c3f52c3c24b90a0d2f53d5fa9::mycoin::MYCOIN>(),
            faucetcoin : 0x2::balance::zero<0x75f3683f1fcd141ae9831aee3f74262e9ba5458cbfb71297859215dd37e9ed9f::faucetcoin::FAUCETCOIN>(),
            mc_prop    : 1000,
            fc_prop    : 7300,
        };
        0x2::transfer::share_object<Bank>(v0);
        let v1 = AdaminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdaminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public entry fun swap_faucetcoin(arg0: &mut Bank, arg1: 0x2::coin::Coin<0x4bc96f381df661fb3d79e15d4139df4fb4d59b8c3f52c3c24b90a0d2f53d5fa9::mycoin::MYCOIN>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::into_balance<0x4bc96f381df661fb3d79e15d4139df4fb4d59b8c3f52c3c24b90a0d2f53d5fa9::mycoin::MYCOIN>(arg1);
        0x2::balance::join<0x4bc96f381df661fb3d79e15d4139df4fb4d59b8c3f52c3c24b90a0d2f53d5fa9::mycoin::MYCOIN>(&mut arg0.mycoin, v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x75f3683f1fcd141ae9831aee3f74262e9ba5458cbfb71297859215dd37e9ed9f::faucetcoin::FAUCETCOIN>>(0x2::coin::from_balance<0x75f3683f1fcd141ae9831aee3f74262e9ba5458cbfb71297859215dd37e9ed9f::faucetcoin::FAUCETCOIN>(0x2::balance::split<0x75f3683f1fcd141ae9831aee3f74262e9ba5458cbfb71297859215dd37e9ed9f::faucetcoin::FAUCETCOIN>(&mut arg0.faucetcoin, 0x2::balance::value<0x4bc96f381df661fb3d79e15d4139df4fb4d59b8c3f52c3c24b90a0d2f53d5fa9::mycoin::MYCOIN>(&v0) * arg0.fc_prop / arg0.mc_prop), arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun swap_mycoin(arg0: &mut Bank, arg1: 0x2::coin::Coin<0x75f3683f1fcd141ae9831aee3f74262e9ba5458cbfb71297859215dd37e9ed9f::faucetcoin::FAUCETCOIN>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::into_balance<0x75f3683f1fcd141ae9831aee3f74262e9ba5458cbfb71297859215dd37e9ed9f::faucetcoin::FAUCETCOIN>(arg1);
        0x2::balance::join<0x75f3683f1fcd141ae9831aee3f74262e9ba5458cbfb71297859215dd37e9ed9f::faucetcoin::FAUCETCOIN>(&mut arg0.faucetcoin, v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x4bc96f381df661fb3d79e15d4139df4fb4d59b8c3f52c3c24b90a0d2f53d5fa9::mycoin::MYCOIN>>(0x2::coin::from_balance<0x4bc96f381df661fb3d79e15d4139df4fb4d59b8c3f52c3c24b90a0d2f53d5fa9::mycoin::MYCOIN>(0x2::balance::split<0x4bc96f381df661fb3d79e15d4139df4fb4d59b8c3f52c3c24b90a0d2f53d5fa9::mycoin::MYCOIN>(&mut arg0.mycoin, 0x2::balance::value<0x75f3683f1fcd141ae9831aee3f74262e9ba5458cbfb71297859215dd37e9ed9f::faucetcoin::FAUCETCOIN>(&v0) * arg0.mc_prop / arg0.fc_prop), arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun withdraw_faucetcoin(arg0: &AdaminCap, arg1: &mut Bank, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x4bc96f381df661fb3d79e15d4139df4fb4d59b8c3f52c3c24b90a0d2f53d5fa9::mycoin::MYCOIN>>(0x2::coin::from_balance<0x4bc96f381df661fb3d79e15d4139df4fb4d59b8c3f52c3c24b90a0d2f53d5fa9::mycoin::MYCOIN>(0x2::balance::split<0x4bc96f381df661fb3d79e15d4139df4fb4d59b8c3f52c3c24b90a0d2f53d5fa9::mycoin::MYCOIN>(&mut arg1.mycoin, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    public entry fun withdraw_mycoin(arg0: &AdaminCap, arg1: &mut Bank, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x4bc96f381df661fb3d79e15d4139df4fb4d59b8c3f52c3c24b90a0d2f53d5fa9::mycoin::MYCOIN>>(0x2::coin::from_balance<0x4bc96f381df661fb3d79e15d4139df4fb4d59b8c3f52c3c24b90a0d2f53d5fa9::mycoin::MYCOIN>(0x2::balance::split<0x4bc96f381df661fb3d79e15d4139df4fb4d59b8c3f52c3c24b90a0d2f53d5fa9::mycoin::MYCOIN>(&mut arg1.mycoin, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

