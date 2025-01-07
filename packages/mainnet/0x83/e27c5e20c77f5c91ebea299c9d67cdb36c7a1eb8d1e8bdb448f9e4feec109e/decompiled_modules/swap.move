module 0x83e27c5e20c77f5c91ebea299c9d67cdb36c7a1eb8d1e8bdb448f9e4feec109e::swap {
    struct Bank has key {
        id: 0x2::object::UID,
        gy: 0x2::balance::Balance<0x8712a36ab8b40aeb50d18951fccf4f6775eb9404119ac9312c8ae623bb006c5b::gy::GY>,
        rmb: 0x2::balance::Balance<0x6388a5b287e979f5f51632e320c6ae0cfdd96b39b087113ae58c3b26c5d03d4e::rmb::RMB>,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    public fun add_gy(arg0: &mut Bank, arg1: 0x2::coin::Coin<0x8712a36ab8b40aeb50d18951fccf4f6775eb9404119ac9312c8ae623bb006c5b::gy::GY>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0x8712a36ab8b40aeb50d18951fccf4f6775eb9404119ac9312c8ae623bb006c5b::gy::GY>(&mut arg0.gy, 0x2::coin::into_balance<0x8712a36ab8b40aeb50d18951fccf4f6775eb9404119ac9312c8ae623bb006c5b::gy::GY>(arg1));
    }

    public fun add_rmb(arg0: &mut Bank, arg1: 0x2::coin::Coin<0x6388a5b287e979f5f51632e320c6ae0cfdd96b39b087113ae58c3b26c5d03d4e::rmb::RMB>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0x6388a5b287e979f5f51632e320c6ae0cfdd96b39b087113ae58c3b26c5d03d4e::rmb::RMB>(&mut arg0.rmb, 0x2::coin::into_balance<0x6388a5b287e979f5f51632e320c6ae0cfdd96b39b087113ae58c3b26c5d03d4e::rmb::RMB>(arg1));
    }

    public fun gy_to_rmb(arg0: &mut Bank, arg1: 0x2::coin::Coin<0x8712a36ab8b40aeb50d18951fccf4f6775eb9404119ac9312c8ae623bb006c5b::gy::GY>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0x8712a36ab8b40aeb50d18951fccf4f6775eb9404119ac9312c8ae623bb006c5b::gy::GY>(&mut arg0.gy, 0x2::coin::into_balance<0x8712a36ab8b40aeb50d18951fccf4f6775eb9404119ac9312c8ae623bb006c5b::gy::GY>(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x6388a5b287e979f5f51632e320c6ae0cfdd96b39b087113ae58c3b26c5d03d4e::rmb::RMB>>(0x2::coin::from_balance<0x6388a5b287e979f5f51632e320c6ae0cfdd96b39b087113ae58c3b26c5d03d4e::rmb::RMB>(0x2::balance::split<0x6388a5b287e979f5f51632e320c6ae0cfdd96b39b087113ae58c3b26c5d03d4e::rmb::RMB>(&mut arg0.rmb, 0x2::coin::value<0x8712a36ab8b40aeb50d18951fccf4f6775eb9404119ac9312c8ae623bb006c5b::gy::GY>(&arg1) * 2000 / 1000), arg2), 0x2::tx_context::sender(arg2));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Bank{
            id  : 0x2::object::new(arg0),
            gy  : 0x2::balance::zero<0x8712a36ab8b40aeb50d18951fccf4f6775eb9404119ac9312c8ae623bb006c5b::gy::GY>(),
            rmb : 0x2::balance::zero<0x6388a5b287e979f5f51632e320c6ae0cfdd96b39b087113ae58c3b26c5d03d4e::rmb::RMB>(),
        };
        0x2::transfer::share_object<Bank>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun remove_gy(arg0: &AdminCap, arg1: &mut Bank, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x8712a36ab8b40aeb50d18951fccf4f6775eb9404119ac9312c8ae623bb006c5b::gy::GY>>(0x2::coin::from_balance<0x8712a36ab8b40aeb50d18951fccf4f6775eb9404119ac9312c8ae623bb006c5b::gy::GY>(0x2::balance::split<0x8712a36ab8b40aeb50d18951fccf4f6775eb9404119ac9312c8ae623bb006c5b::gy::GY>(&mut arg1.gy, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    public fun remove_rmb(arg0: &AdminCap, arg1: &mut Bank, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x6388a5b287e979f5f51632e320c6ae0cfdd96b39b087113ae58c3b26c5d03d4e::rmb::RMB>>(0x2::coin::from_balance<0x6388a5b287e979f5f51632e320c6ae0cfdd96b39b087113ae58c3b26c5d03d4e::rmb::RMB>(0x2::balance::split<0x6388a5b287e979f5f51632e320c6ae0cfdd96b39b087113ae58c3b26c5d03d4e::rmb::RMB>(&mut arg1.rmb, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    public fun rmb_to_gy(arg0: &mut Bank, arg1: 0x2::coin::Coin<0x6388a5b287e979f5f51632e320c6ae0cfdd96b39b087113ae58c3b26c5d03d4e::rmb::RMB>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0x6388a5b287e979f5f51632e320c6ae0cfdd96b39b087113ae58c3b26c5d03d4e::rmb::RMB>(&mut arg0.rmb, 0x2::coin::into_balance<0x6388a5b287e979f5f51632e320c6ae0cfdd96b39b087113ae58c3b26c5d03d4e::rmb::RMB>(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x8712a36ab8b40aeb50d18951fccf4f6775eb9404119ac9312c8ae623bb006c5b::gy::GY>>(0x2::coin::from_balance<0x8712a36ab8b40aeb50d18951fccf4f6775eb9404119ac9312c8ae623bb006c5b::gy::GY>(0x2::balance::split<0x8712a36ab8b40aeb50d18951fccf4f6775eb9404119ac9312c8ae623bb006c5b::gy::GY>(&mut arg0.gy, 0x2::coin::value<0x6388a5b287e979f5f51632e320c6ae0cfdd96b39b087113ae58c3b26c5d03d4e::rmb::RMB>(&arg1) * 1000 / 2000), arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

