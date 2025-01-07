module 0x79958a35e5e4562cf2c4c6c8d87ea93e3168cef0558a0a14b0b028fd74cb6c35::sswp {
    struct SSWP has drop {
        dummy_field: bool,
    }

    struct SSWPStorage has key {
        id: 0x2::object::UID,
        supply: 0x2::balance::Supply<SSWP>,
        minters: 0x2::vec_set::VecSet<0x2::object::ID>,
    }

    struct SSWPAdminCap has key {
        id: 0x2::object::UID,
    }

    struct MinterAdded has copy, drop {
        id: 0x2::object::ID,
    }

    struct MinterRemoved has copy, drop {
        id: 0x2::object::ID,
    }

    struct NewAdmin has copy, drop {
        admin: address,
    }

    public entry fun transfer(arg0: 0x2::coin::Coin<SSWP>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SSWP>>(arg0, arg1);
    }

    public entry fun add_minter(arg0: &SSWPAdminCap, arg1: &mut SSWPStorage, arg2: 0x2::object::ID) {
        0x2::vec_set::insert<0x2::object::ID>(&mut arg1.minters, arg2);
        let v0 = MinterAdded{id: arg2};
        0x2::event::emit<MinterAdded>(v0);
    }

    public fun burn(arg0: &mut SSWPStorage, arg1: 0x2::coin::Coin<SSWP>) : u64 {
        0x2::balance::decrease_supply<SSWP>(&mut arg0.supply, 0x2::coin::into_balance<SSWP>(arg1))
    }

    fun init(arg0: SSWP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SSWP>(arg0, 4, b"SSWP", b"Suiswap", b"Suiswap aims to combine trading, swapping, order book, and liquidity into a single trading DeFi System. Telegram : t.me/suiswap_ann , Twitter : https://twitter.com/suiswap_app", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gateway.pinata.cloud/ipfs/QmNRzw4in4nRFqh4MYXYG19GPfKmjgwvzMnwGLCmXsrUrw?_gl=1*15pcnop*rs_ga*ODJhNjIwYmEtMWRiOC00MTRlLWIwMDctOTI1NDY2ODFjZGQ2*rs_ga_5RMPXG14TE*MTY4MzM4MTcwOC44LjEuMTY4MzM4MTczMy4zNS4wLjA.")), arg1);
        let v2 = 0x2::coin::treasury_into_supply<SSWP>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<SSWP>>(0x2::coin::from_balance<SSWP>(0x2::balance::increase_supply<SSWP>(&mut v2, 10000000), arg1), 0x2::tx_context::sender(arg1));
        let v3 = SSWPAdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<SSWPAdminCap>(v3, 0x2::tx_context::sender(arg1));
        let v4 = SSWPStorage{
            id      : 0x2::object::new(arg1),
            supply  : v2,
            minters : 0x2::vec_set::empty<0x2::object::ID>(),
        };
        0x2::transfer::share_object<SSWPStorage>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SSWP>>(v1);
    }

    public fun is_minter(arg0: &SSWPStorage, arg1: 0x2::object::ID) : bool {
        0x2::vec_set::contains<0x2::object::ID>(&arg0.minters, &arg1)
    }

    public fun mint(arg0: &mut SSWPStorage, arg1: &0x2::package::Publisher, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<SSWP> {
        assert!(is_minter(arg0, 0x2::object::id<0x2::package::Publisher>(arg1)), 1);
        0x2::coin::from_balance<SSWP>(0x2::balance::increase_supply<SSWP>(&mut arg0.supply, arg2), arg3)
    }

    public entry fun remove_minter(arg0: &SSWPAdminCap, arg1: &mut SSWPStorage, arg2: 0x2::object::ID) {
        0x2::vec_set::remove<0x2::object::ID>(&mut arg1.minters, &arg2);
        let v0 = MinterRemoved{id: arg2};
        0x2::event::emit<MinterRemoved>(v0);
    }

    public fun total_supply(arg0: &SSWPStorage) : u64 {
        0x2::balance::supply_value<SSWP>(&arg0.supply)
    }

    public entry fun transfer_admin(arg0: SSWPAdminCap, arg1: address) {
        assert!(arg1 != @0x0, 2);
        0x2::transfer::transfer<SSWPAdminCap>(arg0, arg1);
        let v0 = NewAdmin{admin: arg1};
        0x2::event::emit<NewAdmin>(v0);
    }

    // decompiled from Move bytecode v6
}

