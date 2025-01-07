module 0x4cc3fca19c323e48113f0363e4aca3a5e815543261d8dc2049372f895a0d6085::ming {
    struct MING has drop {
        dummy_field: bool,
    }

    struct MINGStorage has key {
        id: 0x2::object::UID,
        supply: 0x2::balance::Supply<MING>,
        minters: 0x2::vec_set::VecSet<0x2::object::ID>,
    }

    struct MINGAdminCap has key {
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

    public entry fun transfer(arg0: 0x2::coin::Coin<MING>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<MING>>(arg0, arg1);
    }

    public entry fun add_minter(arg0: &MINGAdminCap, arg1: &mut MINGStorage, arg2: 0x2::object::ID) {
        0x2::vec_set::insert<0x2::object::ID>(&mut arg1.minters, arg2);
        let v0 = MinterAdded{id: arg2};
        0x2::event::emit<MinterAdded>(v0);
    }

    public fun burn(arg0: &mut MINGStorage, arg1: 0x2::coin::Coin<MING>) : u64 {
        0x2::balance::decrease_supply<MING>(&mut arg0.supply, 0x2::coin::into_balance<MING>(arg1))
    }

    fun init(arg0: MING, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MING>(arg0, 4, b"MING", b"Yao Ming", b"Yao Ming is the first Chinese token on the Sui Network. Telegram : t.me/yaomingsui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gateway.pinata.cloud/ipfs/QmStCTURmMXWgsHsvamvxYUgxr3PiWRQXpLHtW41UvAo4i?_gl=1*13vjfpg*rs_ga*ODJhNjIwYmEtMWRiOC00MTRlLWIwMDctOTI1NDY2ODFjZGQ2*rs_ga_5RMPXG14TE*MTY4MzQ4ODgxOC4xNC4xLjE2ODM0ODg5MDEuNjAuMC4w")), arg1);
        let v2 = 0x2::coin::treasury_into_supply<MING>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<MING>>(0x2::coin::from_balance<MING>(0x2::balance::increase_supply<MING>(&mut v2, 1000000000), arg1), 0x2::tx_context::sender(arg1));
        let v3 = MINGAdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<MINGAdminCap>(v3, 0x2::tx_context::sender(arg1));
        let v4 = MINGStorage{
            id      : 0x2::object::new(arg1),
            supply  : v2,
            minters : 0x2::vec_set::empty<0x2::object::ID>(),
        };
        0x2::transfer::share_object<MINGStorage>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MING>>(v1);
    }

    public fun is_minter(arg0: &MINGStorage, arg1: 0x2::object::ID) : bool {
        0x2::vec_set::contains<0x2::object::ID>(&arg0.minters, &arg1)
    }

    public fun mint(arg0: &mut MINGStorage, arg1: &0x2::package::Publisher, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<MING> {
        assert!(is_minter(arg0, 0x2::object::id<0x2::package::Publisher>(arg1)), 1);
        0x2::coin::from_balance<MING>(0x2::balance::increase_supply<MING>(&mut arg0.supply, arg2), arg3)
    }

    public entry fun remove_minter(arg0: &MINGAdminCap, arg1: &mut MINGStorage, arg2: 0x2::object::ID) {
        0x2::vec_set::remove<0x2::object::ID>(&mut arg1.minters, &arg2);
        let v0 = MinterRemoved{id: arg2};
        0x2::event::emit<MinterRemoved>(v0);
    }

    public fun total_supply(arg0: &MINGStorage) : u64 {
        0x2::balance::supply_value<MING>(&arg0.supply)
    }

    public entry fun transfer_admin(arg0: MINGAdminCap, arg1: address) {
        assert!(arg1 != @0x0, 2);
        0x2::transfer::transfer<MINGAdminCap>(arg0, arg1);
        let v0 = NewAdmin{admin: arg1};
        0x2::event::emit<NewAdmin>(v0);
    }

    // decompiled from Move bytecode v6
}

