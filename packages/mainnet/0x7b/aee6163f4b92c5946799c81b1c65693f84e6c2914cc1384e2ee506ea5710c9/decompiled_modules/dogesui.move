module 0x7baee6163f4b92c5946799c81b1c65693f84e6c2914cc1384e2ee506ea5710c9::dogesui {
    struct DOGESUI has drop {
        dummy_field: bool,
    }

    struct DOGESUIStorage has key {
        id: 0x2::object::UID,
        supply: 0x2::balance::Supply<DOGESUI>,
        minters: 0x2::vec_set::VecSet<0x2::object::ID>,
    }

    struct DOGESUIAdminCap has key {
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

    public entry fun transfer(arg0: 0x2::coin::Coin<DOGESUI>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<DOGESUI>>(arg0, arg1);
    }

    public entry fun add_minter(arg0: &DOGESUIAdminCap, arg1: &mut DOGESUIStorage, arg2: 0x2::object::ID) {
        0x2::vec_set::insert<0x2::object::ID>(&mut arg1.minters, arg2);
        let v0 = MinterAdded{id: arg2};
        0x2::event::emit<MinterAdded>(v0);
    }

    public fun burn(arg0: &mut DOGESUIStorage, arg1: 0x2::coin::Coin<DOGESUI>) : u64 {
        0x2::balance::decrease_supply<DOGESUI>(&mut arg0.supply, 0x2::coin::into_balance<DOGESUI>(arg1))
    }

    fun init(arg0: DOGESUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGESUI>(arg0, 4, b"DOGESUI", b"Dogecoin Sui", b"The first Meme Coin on Sui Blockchain. LP HAS BEEN BURNT 100%! Telegram : t.me/Dogecoinsui , Twitter : https://twitter.com/dogecoinsui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = 0x2::coin::treasury_into_supply<DOGESUI>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<DOGESUI>>(0x2::coin::from_balance<DOGESUI>(0x2::balance::increase_supply<DOGESUI>(&mut v2, 10000000000000000000), arg1), 0x2::tx_context::sender(arg1));
        let v3 = DOGESUIAdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<DOGESUIAdminCap>(v3, 0x2::tx_context::sender(arg1));
        let v4 = DOGESUIStorage{
            id      : 0x2::object::new(arg1),
            supply  : v2,
            minters : 0x2::vec_set::empty<0x2::object::ID>(),
        };
        0x2::transfer::share_object<DOGESUIStorage>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOGESUI>>(v1);
    }

    public fun is_minter(arg0: &DOGESUIStorage, arg1: 0x2::object::ID) : bool {
        0x2::vec_set::contains<0x2::object::ID>(&arg0.minters, &arg1)
    }

    public fun mint(arg0: &mut DOGESUIStorage, arg1: &0x2::package::Publisher, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<DOGESUI> {
        assert!(is_minter(arg0, 0x2::object::id<0x2::package::Publisher>(arg1)), 1);
        0x2::coin::from_balance<DOGESUI>(0x2::balance::increase_supply<DOGESUI>(&mut arg0.supply, arg2), arg3)
    }

    public entry fun remove_minter(arg0: &DOGESUIAdminCap, arg1: &mut DOGESUIStorage, arg2: 0x2::object::ID) {
        0x2::vec_set::remove<0x2::object::ID>(&mut arg1.minters, &arg2);
        let v0 = MinterRemoved{id: arg2};
        0x2::event::emit<MinterRemoved>(v0);
    }

    public fun total_supply(arg0: &DOGESUIStorage) : u64 {
        0x2::balance::supply_value<DOGESUI>(&arg0.supply)
    }

    public entry fun transfer_admin(arg0: DOGESUIAdminCap, arg1: address) {
        assert!(arg1 != @0x0, 2);
        0x2::transfer::transfer<DOGESUIAdminCap>(arg0, arg1);
        let v0 = NewAdmin{admin: arg1};
        0x2::event::emit<NewAdmin>(v0);
    }

    // decompiled from Move bytecode v6
}

