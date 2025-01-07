module 0x620e8aaab8cc7174769898337d317dc1ec5a4a97bff73f2b9a91c5f82f136d9a::pepeonsui {
    struct PEPEONSUI has drop {
        dummy_field: bool,
    }

    struct PEPEONSUIStorage has key {
        id: 0x2::object::UID,
        supply: 0x2::balance::Supply<PEPEONSUI>,
        minters: 0x2::vec_set::VecSet<0x2::object::ID>,
    }

    struct PEPEONSUIAdminCap has key {
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

    public entry fun transfer(arg0: 0x2::coin::Coin<PEPEONSUI>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<PEPEONSUI>>(arg0, arg1);
    }

    public entry fun add_minter(arg0: &PEPEONSUIAdminCap, arg1: &mut PEPEONSUIStorage, arg2: 0x2::object::ID) {
        0x2::vec_set::insert<0x2::object::ID>(&mut arg1.minters, arg2);
        let v0 = MinterAdded{id: arg2};
        0x2::event::emit<MinterAdded>(v0);
    }

    public fun burn(arg0: &mut PEPEONSUIStorage, arg1: 0x2::coin::Coin<PEPEONSUI>) : u64 {
        0x2::balance::decrease_supply<PEPEONSUI>(&mut arg0.supply, 0x2::coin::into_balance<PEPEONSUI>(arg1))
    }

    fun init(arg0: PEPEONSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPEONSUI>(arg0, 4, b"PepeOnSui", b"Pepe On Sui", b"PepeOnSui. The most memeable memecoin On Sui Blockchain. Telegram : t.me/Pepecoinsui , Twitter : https://twitter.com/pepecoin_sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gateway.pinata.cloud/ipfs/QmaJ3skCH8idaYBLoPRM4jvSWSy6J2X9DqFiNXLaCeNMmd?_gl=1*1eoty5y*rs_ga*ODJhNjIwYmEtMWRiOC00MTRlLWIwMDctOTI1NDY2ODFjZGQ2*rs_ga_5RMPXG14TE*MTY4MzI5ODYxNC40LjEuMTY4MzI5OTUwOS42MC4wLjA.")), arg1);
        let v2 = 0x2::coin::treasury_into_supply<PEPEONSUI>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<PEPEONSUI>>(0x2::coin::from_balance<PEPEONSUI>(0x2::balance::increase_supply<PEPEONSUI>(&mut v2, 10000000000000000000), arg1), 0x2::tx_context::sender(arg1));
        let v3 = PEPEONSUIAdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<PEPEONSUIAdminCap>(v3, 0x2::tx_context::sender(arg1));
        let v4 = PEPEONSUIStorage{
            id      : 0x2::object::new(arg1),
            supply  : v2,
            minters : 0x2::vec_set::empty<0x2::object::ID>(),
        };
        0x2::transfer::share_object<PEPEONSUIStorage>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PEPEONSUI>>(v1);
    }

    public fun is_minter(arg0: &PEPEONSUIStorage, arg1: 0x2::object::ID) : bool {
        0x2::vec_set::contains<0x2::object::ID>(&arg0.minters, &arg1)
    }

    public fun mint(arg0: &mut PEPEONSUIStorage, arg1: &0x2::package::Publisher, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<PEPEONSUI> {
        assert!(is_minter(arg0, 0x2::object::id<0x2::package::Publisher>(arg1)), 1);
        0x2::coin::from_balance<PEPEONSUI>(0x2::balance::increase_supply<PEPEONSUI>(&mut arg0.supply, arg2), arg3)
    }

    public entry fun remove_minter(arg0: &PEPEONSUIAdminCap, arg1: &mut PEPEONSUIStorage, arg2: 0x2::object::ID) {
        0x2::vec_set::remove<0x2::object::ID>(&mut arg1.minters, &arg2);
        let v0 = MinterRemoved{id: arg2};
        0x2::event::emit<MinterRemoved>(v0);
    }

    public fun total_supply(arg0: &PEPEONSUIStorage) : u64 {
        0x2::balance::supply_value<PEPEONSUI>(&arg0.supply)
    }

    public entry fun transfer_admin(arg0: PEPEONSUIAdminCap, arg1: address) {
        assert!(arg1 != @0x0, 2);
        0x2::transfer::transfer<PEPEONSUIAdminCap>(arg0, arg1);
        let v0 = NewAdmin{admin: arg1};
        0x2::event::emit<NewAdmin>(v0);
    }

    // decompiled from Move bytecode v6
}

