module 0x554ac01dc71028daabb6cd140640ff7b341daadb62fda22499061fd4f69208dc::babypepe {
    struct BABYPEPE has drop {
        dummy_field: bool,
    }

    struct BABYPEPEStorage has key {
        id: 0x2::object::UID,
        supply: 0x2::balance::Supply<BABYPEPE>,
        minters: 0x2::vec_set::VecSet<0x2::object::ID>,
    }

    struct BABYPEPEAdminCap has key {
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

    public entry fun transfer(arg0: 0x2::coin::Coin<BABYPEPE>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<BABYPEPE>>(arg0, arg1);
    }

    public entry fun add_minter(arg0: &BABYPEPEAdminCap, arg1: &mut BABYPEPEStorage, arg2: 0x2::object::ID) {
        0x2::vec_set::insert<0x2::object::ID>(&mut arg1.minters, arg2);
        let v0 = MinterAdded{id: arg2};
        0x2::event::emit<MinterAdded>(v0);
    }

    public fun burn(arg0: &mut BABYPEPEStorage, arg1: 0x2::coin::Coin<BABYPEPE>) : u64 {
        0x2::balance::decrease_supply<BABYPEPE>(&mut arg0.supply, 0x2::coin::into_balance<BABYPEPE>(arg1))
    }

    fun init(arg0: BABYPEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABYPEPE>(arg0, 4, b"BABYPEPE", b"BabyPepe", b"BABYPEPE. The next PEPE on Sui Blockchain. Telegram : t.me/babypepesui , Twitter : https://twitter.com/babypepe_sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gateway.pinata.cloud/ipfs/QmSeFcmoDTwbHngAYswejM46c6776qEXUNQSxHedPhM7u8?_gl=1*v0v37f*rs_ga*ODJhNjIwYmEtMWRiOC00MTRlLWIwMDctOTI1NDY2ODFjZGQ2*rs_ga_5RMPXG14TE*MTY4MzMxMzc5My42LjEuMTY4MzMxMzk1OS42MC4wLjA.")), arg1);
        let v2 = 0x2::coin::treasury_into_supply<BABYPEPE>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<BABYPEPE>>(0x2::coin::from_balance<BABYPEPE>(0x2::balance::increase_supply<BABYPEPE>(&mut v2, 10000000000000000000), arg1), 0x2::tx_context::sender(arg1));
        let v3 = BABYPEPEAdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<BABYPEPEAdminCap>(v3, 0x2::tx_context::sender(arg1));
        let v4 = BABYPEPEStorage{
            id      : 0x2::object::new(arg1),
            supply  : v2,
            minters : 0x2::vec_set::empty<0x2::object::ID>(),
        };
        0x2::transfer::share_object<BABYPEPEStorage>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BABYPEPE>>(v1);
    }

    public fun is_minter(arg0: &BABYPEPEStorage, arg1: 0x2::object::ID) : bool {
        0x2::vec_set::contains<0x2::object::ID>(&arg0.minters, &arg1)
    }

    public fun mint(arg0: &mut BABYPEPEStorage, arg1: &0x2::package::Publisher, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<BABYPEPE> {
        assert!(is_minter(arg0, 0x2::object::id<0x2::package::Publisher>(arg1)), 1);
        0x2::coin::from_balance<BABYPEPE>(0x2::balance::increase_supply<BABYPEPE>(&mut arg0.supply, arg2), arg3)
    }

    public entry fun remove_minter(arg0: &BABYPEPEAdminCap, arg1: &mut BABYPEPEStorage, arg2: 0x2::object::ID) {
        0x2::vec_set::remove<0x2::object::ID>(&mut arg1.minters, &arg2);
        let v0 = MinterRemoved{id: arg2};
        0x2::event::emit<MinterRemoved>(v0);
    }

    public fun total_supply(arg0: &BABYPEPEStorage) : u64 {
        0x2::balance::supply_value<BABYPEPE>(&arg0.supply)
    }

    public entry fun transfer_admin(arg0: BABYPEPEAdminCap, arg1: address) {
        assert!(arg1 != @0x0, 2);
        0x2::transfer::transfer<BABYPEPEAdminCap>(arg0, arg1);
        let v0 = NewAdmin{admin: arg1};
        0x2::event::emit<NewAdmin>(v0);
    }

    // decompiled from Move bytecode v6
}

