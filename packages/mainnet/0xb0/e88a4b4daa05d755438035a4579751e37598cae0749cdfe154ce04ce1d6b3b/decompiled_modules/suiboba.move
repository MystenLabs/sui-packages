module 0xb0e88a4b4daa05d755438035a4579751e37598cae0749cdfe154ce04ce1d6b3b::suiboba {
    struct SUIBOBA has drop {
        dummy_field: bool,
    }

    struct SUIBOBAStorage has key {
        id: 0x2::object::UID,
        supply: 0x2::balance::Supply<SUIBOBA>,
        minters: 0x2::vec_set::VecSet<0x2::object::ID>,
    }

    struct SUIBOBAAdminCap has key {
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

    public entry fun transfer(arg0: 0x2::coin::Coin<SUIBOBA>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SUIBOBA>>(arg0, arg1);
    }

    public entry fun add_minter(arg0: &SUIBOBAAdminCap, arg1: &mut SUIBOBAStorage, arg2: 0x2::object::ID) {
        0x2::vec_set::insert<0x2::object::ID>(&mut arg1.minters, arg2);
        let v0 = MinterAdded{id: arg2};
        0x2::event::emit<MinterAdded>(v0);
    }

    public fun burn(arg0: &mut SUIBOBAStorage, arg1: 0x2::coin::Coin<SUIBOBA>) : u64 {
        0x2::balance::decrease_supply<SUIBOBA>(&mut arg0.supply, 0x2::coin::into_balance<SUIBOBA>(arg1))
    }

    fun init(arg0: SUIBOBA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBOBA>(arg0, 4, b"SUIBOBA", b"SUIBOBA", b"The first meme token on Sui Blockchain,", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://img.freepik.com/premium-vector/cup-bubble-tea-illustration-isolated-drink-logo-vector-icon-illustration-flat-style_126068-83.jpg?w=740")), arg1);
        let v2 = 0x2::coin::treasury_into_supply<SUIBOBA>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<SUIBOBA>>(0x2::coin::from_balance<SUIBOBA>(0x2::balance::increase_supply<SUIBOBA>(&mut v2, 10000000000000000000), arg1), 0x2::tx_context::sender(arg1));
        let v3 = SUIBOBAAdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<SUIBOBAAdminCap>(v3, 0x2::tx_context::sender(arg1));
        let v4 = SUIBOBAStorage{
            id      : 0x2::object::new(arg1),
            supply  : v2,
            minters : 0x2::vec_set::empty<0x2::object::ID>(),
        };
        0x2::transfer::share_object<SUIBOBAStorage>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIBOBA>>(v1);
    }

    public fun is_minter(arg0: &SUIBOBAStorage, arg1: 0x2::object::ID) : bool {
        0x2::vec_set::contains<0x2::object::ID>(&arg0.minters, &arg1)
    }

    public fun mint(arg0: &mut SUIBOBAStorage, arg1: &0x2::package::Publisher, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<SUIBOBA> {
        assert!(is_minter(arg0, 0x2::object::id<0x2::package::Publisher>(arg1)), 1);
        0x2::coin::from_balance<SUIBOBA>(0x2::balance::increase_supply<SUIBOBA>(&mut arg0.supply, arg2), arg3)
    }

    public entry fun remove_minter(arg0: &SUIBOBAAdminCap, arg1: &mut SUIBOBAStorage, arg2: 0x2::object::ID) {
        0x2::vec_set::remove<0x2::object::ID>(&mut arg1.minters, &arg2);
        let v0 = MinterRemoved{id: arg2};
        0x2::event::emit<MinterRemoved>(v0);
    }

    public fun total_supply(arg0: &SUIBOBAStorage) : u64 {
        0x2::balance::supply_value<SUIBOBA>(&arg0.supply)
    }

    public entry fun transfer_admin(arg0: SUIBOBAAdminCap, arg1: address) {
        assert!(arg1 != @0x0, 2);
        0x2::transfer::transfer<SUIBOBAAdminCap>(arg0, arg1);
        let v0 = NewAdmin{admin: arg1};
        0x2::event::emit<NewAdmin>(v0);
    }

    // decompiled from Move bytecode v6
}

