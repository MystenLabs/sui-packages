module 0x5ad08aa2fc867d0b084ca8c92ef450f1517c6ca94acf43e9f39d2a0a0c5d9841::swap_usd_rmb {
    struct Bank has key {
        id: 0x2::object::UID,
        usd: 0x2::balance::Balance<0x3fa7160c7ba94f821f8575aa75d9741127cd9f80e45e2331a4dcaaa5f9cf7b83::usd::USD>,
        rmb: 0x2::balance::Balance<0x76ed920226db822677e4f23b47776f9ab4e1f5731ce5f7a44786ddf137cdfcd5::rmb::RMB>,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    public fun deposit_rmb(arg0: &mut Bank, arg1: 0x2::coin::Coin<0x76ed920226db822677e4f23b47776f9ab4e1f5731ce5f7a44786ddf137cdfcd5::rmb::RMB>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0x76ed920226db822677e4f23b47776f9ab4e1f5731ce5f7a44786ddf137cdfcd5::rmb::RMB>(&mut arg0.rmb, 0x2::coin::into_balance<0x76ed920226db822677e4f23b47776f9ab4e1f5731ce5f7a44786ddf137cdfcd5::rmb::RMB>(arg1));
    }

    public fun deposit_usd(arg0: &mut Bank, arg1: 0x2::coin::Coin<0x3fa7160c7ba94f821f8575aa75d9741127cd9f80e45e2331a4dcaaa5f9cf7b83::usd::USD>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0x3fa7160c7ba94f821f8575aa75d9741127cd9f80e45e2331a4dcaaa5f9cf7b83::usd::USD>(&mut arg0.usd, 0x2::coin::into_balance<0x3fa7160c7ba94f821f8575aa75d9741127cd9f80e45e2331a4dcaaa5f9cf7b83::usd::USD>(arg1));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Bank{
            id  : 0x2::object::new(arg0),
            usd : 0x2::balance::zero<0x3fa7160c7ba94f821f8575aa75d9741127cd9f80e45e2331a4dcaaa5f9cf7b83::usd::USD>(),
            rmb : 0x2::balance::zero<0x76ed920226db822677e4f23b47776f9ab4e1f5731ce5f7a44786ddf137cdfcd5::rmb::RMB>(),
        };
        0x2::transfer::share_object<Bank>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun rmb_swap_usd(arg0: 0x2::coin::Coin<0x76ed920226db822677e4f23b47776f9ab4e1f5731ce5f7a44786ddf137cdfcd5::rmb::RMB>, arg1: &mut Bank, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::into_balance<0x76ed920226db822677e4f23b47776f9ab4e1f5731ce5f7a44786ddf137cdfcd5::rmb::RMB>(arg0);
        let v1 = 0x2::balance::value<0x76ed920226db822677e4f23b47776f9ab4e1f5731ce5f7a44786ddf137cdfcd5::rmb::RMB>(&v0) * 10 / 72;
        assert!(v1 < 0x2::balance::value<0x3fa7160c7ba94f821f8575aa75d9741127cd9f80e45e2331a4dcaaa5f9cf7b83::usd::USD>(&arg1.usd), 9223372307437715455);
        0x2::balance::join<0x76ed920226db822677e4f23b47776f9ab4e1f5731ce5f7a44786ddf137cdfcd5::rmb::RMB>(&mut arg1.rmb, v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x3fa7160c7ba94f821f8575aa75d9741127cd9f80e45e2331a4dcaaa5f9cf7b83::usd::USD>>(0x2::coin::from_balance<0x3fa7160c7ba94f821f8575aa75d9741127cd9f80e45e2331a4dcaaa5f9cf7b83::usd::USD>(0x2::balance::split<0x3fa7160c7ba94f821f8575aa75d9741127cd9f80e45e2331a4dcaaa5f9cf7b83::usd::USD>(&mut arg1.usd, v1), arg2), 0x2::tx_context::sender(arg2));
    }

    public fun usd_swap_rmb(arg0: 0x2::coin::Coin<0x3fa7160c7ba94f821f8575aa75d9741127cd9f80e45e2331a4dcaaa5f9cf7b83::usd::USD>, arg1: &mut Bank, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::into_balance<0x3fa7160c7ba94f821f8575aa75d9741127cd9f80e45e2331a4dcaaa5f9cf7b83::usd::USD>(arg0);
        let v1 = 0x2::balance::value<0x3fa7160c7ba94f821f8575aa75d9741127cd9f80e45e2331a4dcaaa5f9cf7b83::usd::USD>(&v0) * 72 / 10;
        assert!(v1 > 0x2::balance::value<0x76ed920226db822677e4f23b47776f9ab4e1f5731ce5f7a44786ddf137cdfcd5::rmb::RMB>(&arg1.rmb), 9223372264488042495);
        0x2::balance::join<0x3fa7160c7ba94f821f8575aa75d9741127cd9f80e45e2331a4dcaaa5f9cf7b83::usd::USD>(&mut arg1.usd, v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x76ed920226db822677e4f23b47776f9ab4e1f5731ce5f7a44786ddf137cdfcd5::rmb::RMB>>(0x2::coin::from_balance<0x76ed920226db822677e4f23b47776f9ab4e1f5731ce5f7a44786ddf137cdfcd5::rmb::RMB>(0x2::balance::split<0x76ed920226db822677e4f23b47776f9ab4e1f5731ce5f7a44786ddf137cdfcd5::rmb::RMB>(&mut arg1.rmb, v1), arg2), 0x2::tx_context::sender(arg2));
    }

    public fun withdraw_rmb(arg0: &AdminCap, arg1: u64, arg2: &mut Bank, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 < 0x2::balance::value<0x76ed920226db822677e4f23b47776f9ab4e1f5731ce5f7a44786ddf137cdfcd5::rmb::RMB>(&arg2.rmb), 9223372350387388415);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x76ed920226db822677e4f23b47776f9ab4e1f5731ce5f7a44786ddf137cdfcd5::rmb::RMB>>(0x2::coin::from_balance<0x76ed920226db822677e4f23b47776f9ab4e1f5731ce5f7a44786ddf137cdfcd5::rmb::RMB>(0x2::balance::split<0x76ed920226db822677e4f23b47776f9ab4e1f5731ce5f7a44786ddf137cdfcd5::rmb::RMB>(&mut arg2.rmb, arg1), arg3), 0x2::tx_context::sender(arg3));
    }

    public fun withdraw_usd(arg0: &AdminCap, arg1: u64, arg2: &mut Bank, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 < 0x2::balance::value<0x3fa7160c7ba94f821f8575aa75d9741127cd9f80e45e2331a4dcaaa5f9cf7b83::usd::USD>(&arg2.usd), 9223372384747126783);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x3fa7160c7ba94f821f8575aa75d9741127cd9f80e45e2331a4dcaaa5f9cf7b83::usd::USD>>(0x2::coin::from_balance<0x3fa7160c7ba94f821f8575aa75d9741127cd9f80e45e2331a4dcaaa5f9cf7b83::usd::USD>(0x2::balance::split<0x3fa7160c7ba94f821f8575aa75d9741127cd9f80e45e2331a4dcaaa5f9cf7b83::usd::USD>(&mut arg2.usd, arg1), arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

