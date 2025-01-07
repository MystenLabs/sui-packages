module 0xac1b4e3d1361a997bfebca08f111ae1886cafd05056207db16babd7ff1d6991d::swap {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct Swap has store, key {
        id: 0x2::object::UID,
        usd: 0x2::balance::Balance<0x736c1778ab365c338da127c6e22a0593fdfa6d281b6b923c736e558373570f11::usd::USD>,
        eig: 0x2::balance::Balance<0xf855a34f6870634a444260ec3a7ad5581334849d8388f63d67e703b06428edc4::eig::EIG>,
        eig_profit: 0x2::balance::Balance<0xf855a34f6870634a444260ec3a7ad5581334849d8388f63d67e703b06428edc4::eig::EIG>,
        usd_prifit: 0x2::balance::Balance<0x736c1778ab365c338da127c6e22a0593fdfa6d281b6b923c736e558373570f11::usd::USD>,
    }

    public entry fun deposit_eig(arg0: &AdminCap, arg1: &mut Swap, arg2: 0x2::coin::Coin<0xf855a34f6870634a444260ec3a7ad5581334849d8388f63d67e703b06428edc4::eig::EIG>, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0xf855a34f6870634a444260ec3a7ad5581334849d8388f63d67e703b06428edc4::eig::EIG>(&mut arg1.eig, 0x2::coin::into_balance<0xf855a34f6870634a444260ec3a7ad5581334849d8388f63d67e703b06428edc4::eig::EIG>(arg2));
    }

    public entry fun deposit_usd(arg0: &AdminCap, arg1: &mut Swap, arg2: 0x2::coin::Coin<0x736c1778ab365c338da127c6e22a0593fdfa6d281b6b923c736e558373570f11::usd::USD>, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0x736c1778ab365c338da127c6e22a0593fdfa6d281b6b923c736e558373570f11::usd::USD>(&mut arg1.usd, 0x2::coin::into_balance<0x736c1778ab365c338da127c6e22a0593fdfa6d281b6b923c736e558373570f11::usd::USD>(arg2));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = Swap{
            id         : 0x2::object::new(arg0),
            usd        : 0x2::balance::zero<0x736c1778ab365c338da127c6e22a0593fdfa6d281b6b923c736e558373570f11::usd::USD>(),
            eig        : 0x2::balance::zero<0xf855a34f6870634a444260ec3a7ad5581334849d8388f63d67e703b06428edc4::eig::EIG>(),
            eig_profit : 0x2::balance::zero<0xf855a34f6870634a444260ec3a7ad5581334849d8388f63d67e703b06428edc4::eig::EIG>(),
            usd_prifit : 0x2::balance::zero<0x736c1778ab365c338da127c6e22a0593fdfa6d281b6b923c736e558373570f11::usd::USD>(),
        };
        0x2::transfer::share_object<Swap>(v1);
    }

    public entry fun swap_eig(arg0: &mut Swap, arg1: &mut 0x2::coin::Coin<0x736c1778ab365c338da127c6e22a0593fdfa6d281b6b923c736e558373570f11::usd::USD>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x736c1778ab365c338da127c6e22a0593fdfa6d281b6b923c736e558373570f11::usd::USD>(arg1) > 0, 2);
        assert!(0x2::balance::value<0x736c1778ab365c338da127c6e22a0593fdfa6d281b6b923c736e558373570f11::usd::USD>(&arg0.usd) > 0 && 0x2::balance::value<0xf855a34f6870634a444260ec3a7ad5581334849d8388f63d67e703b06428edc4::eig::EIG>(&arg0.eig) > 0, 3);
        let v0 = 0x2::coin::value<0x736c1778ab365c338da127c6e22a0593fdfa6d281b6b923c736e558373570f11::usd::USD>(arg1) / 100;
        let v1 = 0x2::coin::value<0x736c1778ab365c338da127c6e22a0593fdfa6d281b6b923c736e558373570f11::usd::USD>(arg1) - v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<0xf855a34f6870634a444260ec3a7ad5581334849d8388f63d67e703b06428edc4::eig::EIG>>(0x2::coin::from_balance<0xf855a34f6870634a444260ec3a7ad5581334849d8388f63d67e703b06428edc4::eig::EIG>(0x2::balance::split<0xf855a34f6870634a444260ec3a7ad5581334849d8388f63d67e703b06428edc4::eig::EIG>(&mut arg0.eig, 0x2::balance::value<0xf855a34f6870634a444260ec3a7ad5581334849d8388f63d67e703b06428edc4::eig::EIG>(&arg0.eig) - 0x2::balance::value<0x736c1778ab365c338da127c6e22a0593fdfa6d281b6b923c736e558373570f11::usd::USD>(&arg0.usd) * 0x2::balance::value<0xf855a34f6870634a444260ec3a7ad5581334849d8388f63d67e703b06428edc4::eig::EIG>(&arg0.eig) / (v1 + 0x2::balance::value<0x736c1778ab365c338da127c6e22a0593fdfa6d281b6b923c736e558373570f11::usd::USD>(&arg0.usd))), arg2), 0x2::tx_context::sender(arg2));
        0x2::balance::join<0x736c1778ab365c338da127c6e22a0593fdfa6d281b6b923c736e558373570f11::usd::USD>(&mut arg0.usd_prifit, 0x2::coin::into_balance<0x736c1778ab365c338da127c6e22a0593fdfa6d281b6b923c736e558373570f11::usd::USD>(0x2::coin::split<0x736c1778ab365c338da127c6e22a0593fdfa6d281b6b923c736e558373570f11::usd::USD>(arg1, v0, arg2)));
        0x2::balance::join<0x736c1778ab365c338da127c6e22a0593fdfa6d281b6b923c736e558373570f11::usd::USD>(&mut arg0.usd, 0x2::coin::into_balance<0x736c1778ab365c338da127c6e22a0593fdfa6d281b6b923c736e558373570f11::usd::USD>(0x2::coin::split<0x736c1778ab365c338da127c6e22a0593fdfa6d281b6b923c736e558373570f11::usd::USD>(arg1, v1, arg2)));
    }

    public entry fun swap_usd(arg0: &mut Swap, arg1: &mut 0x2::coin::Coin<0xf855a34f6870634a444260ec3a7ad5581334849d8388f63d67e703b06428edc4::eig::EIG>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0xf855a34f6870634a444260ec3a7ad5581334849d8388f63d67e703b06428edc4::eig::EIG>(arg1) > 0, 2);
        assert!(0x2::balance::value<0x736c1778ab365c338da127c6e22a0593fdfa6d281b6b923c736e558373570f11::usd::USD>(&arg0.usd) > 0 && 0x2::balance::value<0xf855a34f6870634a444260ec3a7ad5581334849d8388f63d67e703b06428edc4::eig::EIG>(&arg0.eig) > 0, 3);
        let v0 = 0x2::coin::value<0xf855a34f6870634a444260ec3a7ad5581334849d8388f63d67e703b06428edc4::eig::EIG>(arg1) / 100;
        let v1 = 0x2::coin::value<0xf855a34f6870634a444260ec3a7ad5581334849d8388f63d67e703b06428edc4::eig::EIG>(arg1) - v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x736c1778ab365c338da127c6e22a0593fdfa6d281b6b923c736e558373570f11::usd::USD>>(0x2::coin::from_balance<0x736c1778ab365c338da127c6e22a0593fdfa6d281b6b923c736e558373570f11::usd::USD>(0x2::balance::split<0x736c1778ab365c338da127c6e22a0593fdfa6d281b6b923c736e558373570f11::usd::USD>(&mut arg0.usd, 0x2::balance::value<0x736c1778ab365c338da127c6e22a0593fdfa6d281b6b923c736e558373570f11::usd::USD>(&arg0.usd) - 0x2::balance::value<0x736c1778ab365c338da127c6e22a0593fdfa6d281b6b923c736e558373570f11::usd::USD>(&arg0.usd) * 0x2::balance::value<0xf855a34f6870634a444260ec3a7ad5581334849d8388f63d67e703b06428edc4::eig::EIG>(&arg0.eig) / (v1 + 0x2::balance::value<0xf855a34f6870634a444260ec3a7ad5581334849d8388f63d67e703b06428edc4::eig::EIG>(&arg0.eig))), arg2), 0x2::tx_context::sender(arg2));
        0x2::balance::join<0xf855a34f6870634a444260ec3a7ad5581334849d8388f63d67e703b06428edc4::eig::EIG>(&mut arg0.eig_profit, 0x2::coin::into_balance<0xf855a34f6870634a444260ec3a7ad5581334849d8388f63d67e703b06428edc4::eig::EIG>(0x2::coin::split<0xf855a34f6870634a444260ec3a7ad5581334849d8388f63d67e703b06428edc4::eig::EIG>(arg1, v0, arg2)));
        0x2::balance::join<0xf855a34f6870634a444260ec3a7ad5581334849d8388f63d67e703b06428edc4::eig::EIG>(&mut arg0.eig, 0x2::coin::into_balance<0xf855a34f6870634a444260ec3a7ad5581334849d8388f63d67e703b06428edc4::eig::EIG>(0x2::coin::split<0xf855a34f6870634a444260ec3a7ad5581334849d8388f63d67e703b06428edc4::eig::EIG>(arg1, v1, arg2)));
    }

    public entry fun withdraw_eig(arg0: &AdminCap, arg1: &mut Swap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 <= 0x2::balance::value<0xf855a34f6870634a444260ec3a7ad5581334849d8388f63d67e703b06428edc4::eig::EIG>(&arg1.eig), 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xf855a34f6870634a444260ec3a7ad5581334849d8388f63d67e703b06428edc4::eig::EIG>>(0x2::coin::from_balance<0xf855a34f6870634a444260ec3a7ad5581334849d8388f63d67e703b06428edc4::eig::EIG>(0x2::balance::split<0xf855a34f6870634a444260ec3a7ad5581334849d8388f63d67e703b06428edc4::eig::EIG>(&mut arg1.eig, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    public entry fun withdraw_prifit(arg0: &AdminCap, arg1: &mut Swap, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0xf855a34f6870634a444260ec3a7ad5581334849d8388f63d67e703b06428edc4::eig::EIG>>(0x2::coin::from_balance<0xf855a34f6870634a444260ec3a7ad5581334849d8388f63d67e703b06428edc4::eig::EIG>(0x2::balance::withdraw_all<0xf855a34f6870634a444260ec3a7ad5581334849d8388f63d67e703b06428edc4::eig::EIG>(&mut arg1.eig_profit), arg2), 0x2::tx_context::sender(arg2));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x736c1778ab365c338da127c6e22a0593fdfa6d281b6b923c736e558373570f11::usd::USD>>(0x2::coin::from_balance<0x736c1778ab365c338da127c6e22a0593fdfa6d281b6b923c736e558373570f11::usd::USD>(0x2::balance::withdraw_all<0x736c1778ab365c338da127c6e22a0593fdfa6d281b6b923c736e558373570f11::usd::USD>(&mut arg1.usd_prifit), arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun withdraw_usd(arg0: &AdminCap, arg1: &mut Swap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 <= 0x2::balance::value<0x736c1778ab365c338da127c6e22a0593fdfa6d281b6b923c736e558373570f11::usd::USD>(&arg1.usd), 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x736c1778ab365c338da127c6e22a0593fdfa6d281b6b923c736e558373570f11::usd::USD>>(0x2::coin::from_balance<0x736c1778ab365c338da127c6e22a0593fdfa6d281b6b923c736e558373570f11::usd::USD>(0x2::balance::split<0x736c1778ab365c338da127c6e22a0593fdfa6d281b6b923c736e558373570f11::usd::USD>(&mut arg1.usd, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

