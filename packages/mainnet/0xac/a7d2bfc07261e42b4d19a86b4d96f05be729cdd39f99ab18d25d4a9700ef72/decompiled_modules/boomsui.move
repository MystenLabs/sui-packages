module 0xaca7d2bfc07261e42b4d19a86b4d96f05be729cdd39f99ab18d25d4a9700ef72::boomsui {
    struct BOOMSUI has drop {
        dummy_field: bool,
    }

    struct BOOMSUIStorage has key {
        id: 0x2::object::UID,
        supply: 0x2::balance::Supply<BOOMSUI>,
        minters: 0x2::vec_set::VecSet<0x2::object::ID>,
    }

    struct BOOMSUIAdminCap has key {
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

    public entry fun transfer(arg0: 0x2::coin::Coin<BOOMSUI>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<BOOMSUI>>(arg0, arg1);
    }

    public entry fun add_minter(arg0: &BOOMSUIAdminCap, arg1: &mut BOOMSUIStorage, arg2: 0x2::object::ID) {
        0x2::vec_set::insert<0x2::object::ID>(&mut arg1.minters, arg2);
        let v0 = MinterAdded{id: arg2};
        0x2::event::emit<MinterAdded>(v0);
    }

    public fun burn(arg0: &mut BOOMSUIStorage, arg1: 0x2::coin::Coin<BOOMSUI>) : u64 {
        0x2::balance::decrease_supply<BOOMSUI>(&mut arg0.supply, 0x2::coin::into_balance<BOOMSUI>(arg1))
    }

    fun init(arg0: BOOMSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOOMSUI>(arg0, 4, b"BOOMSUI", b"boomsui", b"The first meme token on Sui Blockchain,", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://w7.pngwing.com/pngs/310/173/png-transparent-t-shirt-the-hundreds-2017-arish-attack-logo-bomb-bomb-logo-explosion-sticker.png")), arg1);
        let v2 = 0x2::coin::treasury_into_supply<BOOMSUI>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<BOOMSUI>>(0x2::coin::from_balance<BOOMSUI>(0x2::balance::increase_supply<BOOMSUI>(&mut v2, 10000000000000000000), arg1), 0x2::tx_context::sender(arg1));
        let v3 = BOOMSUIAdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<BOOMSUIAdminCap>(v3, 0x2::tx_context::sender(arg1));
        let v4 = BOOMSUIStorage{
            id      : 0x2::object::new(arg1),
            supply  : v2,
            minters : 0x2::vec_set::empty<0x2::object::ID>(),
        };
        0x2::transfer::share_object<BOOMSUIStorage>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BOOMSUI>>(v1);
    }

    public fun is_minter(arg0: &BOOMSUIStorage, arg1: 0x2::object::ID) : bool {
        0x2::vec_set::contains<0x2::object::ID>(&arg0.minters, &arg1)
    }

    public fun mint(arg0: &mut BOOMSUIStorage, arg1: &0x2::package::Publisher, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<BOOMSUI> {
        assert!(is_minter(arg0, 0x2::object::id<0x2::package::Publisher>(arg1)), 1);
        0x2::coin::from_balance<BOOMSUI>(0x2::balance::increase_supply<BOOMSUI>(&mut arg0.supply, arg2), arg3)
    }

    public entry fun remove_minter(arg0: &BOOMSUIAdminCap, arg1: &mut BOOMSUIStorage, arg2: 0x2::object::ID) {
        0x2::vec_set::remove<0x2::object::ID>(&mut arg1.minters, &arg2);
        let v0 = MinterRemoved{id: arg2};
        0x2::event::emit<MinterRemoved>(v0);
    }

    public fun total_supply(arg0: &BOOMSUIStorage) : u64 {
        0x2::balance::supply_value<BOOMSUI>(&arg0.supply)
    }

    public entry fun transfer_admin(arg0: BOOMSUIAdminCap, arg1: address) {
        assert!(arg1 != @0x0, 2);
        0x2::transfer::transfer<BOOMSUIAdminCap>(arg0, arg1);
        let v0 = NewAdmin{admin: arg1};
        0x2::event::emit<NewAdmin>(v0);
    }

    // decompiled from Move bytecode v6
}

