module 0x5e03f6f94d3e16e397d96d6c15fcbe9ce67a13d0324c8aa1f41c55fd379c7d25::sfloki {
    struct SFLOKI has drop {
        dummy_field: bool,
    }

    struct SFLOKIStorage has key {
        id: 0x2::object::UID,
        supply: 0x2::balance::Supply<SFLOKI>,
        minters: 0x2::vec_set::VecSet<0x2::object::ID>,
    }

    struct SakeAdminCap has key {
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

    public entry fun transfer(arg0: 0x2::coin::Coin<SFLOKI>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SFLOKI>>(arg0, arg1);
    }

    public entry fun add_minter(arg0: &SakeAdminCap, arg1: &mut SFLOKIStorage, arg2: 0x2::object::ID) {
        0x2::vec_set::insert<0x2::object::ID>(&mut arg1.minters, arg2);
        let v0 = MinterAdded{id: arg2};
        0x2::event::emit<MinterAdded>(v0);
    }

    public fun burn(arg0: &mut SFLOKIStorage, arg1: 0x2::coin::Coin<SFLOKI>) : u64 {
        0x2::balance::decrease_supply<SFLOKI>(&mut arg0.supply, 0x2::coin::into_balance<SFLOKI>(arg1))
    }

    fun init(arg0: SFLOKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SFLOKI>(arg0, 9, b"SFLOKI", b"Kojiki Protocol Token", b"The governance token of Kojiki Protocol", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://brown-democratic-crawdad-536.mypinata.cloud/ipfs/Qme8CV8ddPD3tLqwggyDFQi7924mo5ztFx5Jyczgu2c4vP")), arg1);
        let v2 = 0x2::coin::treasury_into_supply<SFLOKI>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<SFLOKI>>(0x2::coin::from_balance<SFLOKI>(0x2::balance::increase_supply<SFLOKI>(&mut v2, 600000000000000000), arg1), @0xd67b1e7e1d61f6de5b6828b952dd9bb4f28166401483a12e37a7a7018567ecbd);
        let v3 = SakeAdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<SakeAdminCap>(v3, 0x2::tx_context::sender(arg1));
        let v4 = SFLOKIStorage{
            id      : 0x2::object::new(arg1),
            supply  : v2,
            minters : 0x2::vec_set::empty<0x2::object::ID>(),
        };
        0x2::transfer::share_object<SFLOKIStorage>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SFLOKI>>(v1);
    }

    public fun is_minter(arg0: &SFLOKIStorage, arg1: 0x2::object::ID) : bool {
        0x2::vec_set::contains<0x2::object::ID>(&arg0.minters, &arg1)
    }

    public fun mint(arg0: &mut SFLOKIStorage, arg1: &0x2::package::Publisher, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<SFLOKI> {
        assert!(is_minter(arg0, 0x2::object::id<0x2::package::Publisher>(arg1)), 1);
        0x2::coin::from_balance<SFLOKI>(0x2::balance::increase_supply<SFLOKI>(&mut arg0.supply, arg2), arg3)
    }

    public entry fun remove_minter(arg0: &SakeAdminCap, arg1: &mut SFLOKIStorage, arg2: 0x2::object::ID) {
        0x2::vec_set::remove<0x2::object::ID>(&mut arg1.minters, &arg2);
        let v0 = MinterRemoved{id: arg2};
        0x2::event::emit<MinterRemoved>(v0);
    }

    public fun total_supply(arg0: &SFLOKIStorage) : u64 {
        0x2::balance::supply_value<SFLOKI>(&arg0.supply)
    }

    public entry fun transfer_admin(arg0: SakeAdminCap, arg1: address) {
        assert!(arg1 != @0x0, 2);
        0x2::transfer::transfer<SakeAdminCap>(arg0, arg1);
        let v0 = NewAdmin{admin: arg1};
        0x2::event::emit<NewAdmin>(v0);
    }

    // decompiled from Move bytecode v6
}

