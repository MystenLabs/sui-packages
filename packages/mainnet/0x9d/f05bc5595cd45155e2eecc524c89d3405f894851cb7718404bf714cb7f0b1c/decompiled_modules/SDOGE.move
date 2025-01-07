module 0x9df05bc5595cd45155e2eecc524c89d3405f894851cb7718404bf714cb7f0b1c::SDOGE {
    struct SDOGE has drop {
        dummy_field: bool,
    }

    struct SDOGEStorage has key {
        id: 0x2::object::UID,
        supply: 0x2::balance::Supply<SDOGE>,
        minters: 0x2::vec_set::VecSet<0x2::object::ID>,
    }

    struct SDOGEAdminCap has key {
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

    public entry fun transfer(arg0: 0x2::coin::Coin<SDOGE>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SDOGE>>(arg0, arg1);
    }

    public entry fun add_minter(arg0: &SDOGEAdminCap, arg1: &mut SDOGEStorage, arg2: 0x2::object::ID) {
        0x2::vec_set::insert<0x2::object::ID>(&mut arg1.minters, arg2);
        let v0 = MinterAdded{id: arg2};
        0x2::event::emit<MinterAdded>(v0);
    }

    public fun burn(arg0: &mut SDOGEStorage, arg1: 0x2::coin::Coin<SDOGE>) : u64 {
        0x2::balance::decrease_supply<SDOGE>(&mut arg0.supply, 0x2::coin::into_balance<SDOGE>(arg1))
    }

    fun init(arg0: SDOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SDOGE>(arg0, 9, b"SDOGE", b"SUIDOGE Token", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gateway.pinata.cloud/ipfs/Qmc4rzRTCGZiZkTKtA1hZMd9LG6eK2wTTMjo5ZFh6QiJma")), arg1);
        let v2 = 0x2::coin::treasury_into_supply<SDOGE>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<SDOGE>>(0x2::coin::from_balance<SDOGE>(0x2::balance::increase_supply<SDOGE>(&mut v2, 1000000000000000000), arg1), @0xde8027e78b89b87a4ab8841034a072bb8ba405b0c7fc9bdd0f2fee1b83c7a178);
        let v3 = SDOGEAdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<SDOGEAdminCap>(v3, @0xde8027e78b89b87a4ab8841034a072bb8ba405b0c7fc9bdd0f2fee1b83c7a178);
        let v4 = SDOGEStorage{
            id      : 0x2::object::new(arg1),
            supply  : v2,
            minters : 0x2::vec_set::empty<0x2::object::ID>(),
        };
        0x2::transfer::share_object<SDOGEStorage>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SDOGE>>(v1);
    }

    public fun is_minter(arg0: &SDOGEStorage, arg1: 0x2::object::ID) : bool {
        0x2::vec_set::contains<0x2::object::ID>(&arg0.minters, &arg1)
    }

    public fun mint(arg0: &mut SDOGEStorage, arg1: &0x2::package::Publisher, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<SDOGE> {
        assert!(is_minter(arg0, 0x2::object::id<0x2::package::Publisher>(arg1)), 1);
        0x2::coin::from_balance<SDOGE>(0x2::balance::increase_supply<SDOGE>(&mut arg0.supply, arg2), arg3)
    }

    public entry fun remove_minter(arg0: &SDOGEAdminCap, arg1: &mut SDOGEStorage, arg2: 0x2::object::ID) {
        0x2::vec_set::remove<0x2::object::ID>(&mut arg1.minters, &arg2);
        let v0 = MinterRemoved{id: arg2};
        0x2::event::emit<MinterRemoved>(v0);
    }

    public fun total_supply(arg0: &SDOGEStorage) : u64 {
        0x2::balance::supply_value<SDOGE>(&arg0.supply)
    }

    public entry fun transfer_admin(arg0: SDOGEAdminCap, arg1: address) {
        assert!(arg1 != @0x0, 2);
        0x2::transfer::transfer<SDOGEAdminCap>(arg0, arg1);
        let v0 = NewAdmin{admin: arg1};
        0x2::event::emit<NewAdmin>(v0);
    }

    // decompiled from Move bytecode v6
}

