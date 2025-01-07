module 0x6bc67bf89397b8af31b6144acebd275625bad67d26a628d55f8bcbe6651e8ef3::suishib {
    struct SUISHIB has drop {
        dummy_field: bool,
    }

    struct SUISHIBStorage has key {
        id: 0x2::object::UID,
        supply: 0x2::balance::Supply<SUISHIB>,
        minters: 0x2::vec_set::VecSet<0x2::object::ID>,
    }

    struct SUISHIBAdminCap has key {
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

    public entry fun transfer(arg0: 0x2::coin::Coin<SUISHIB>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SUISHIB>>(arg0, arg1);
    }

    public entry fun add_minter(arg0: &SUISHIBAdminCap, arg1: &mut SUISHIBStorage, arg2: 0x2::object::ID) {
        0x2::vec_set::insert<0x2::object::ID>(&mut arg1.minters, arg2);
        let v0 = MinterAdded{id: arg2};
        0x2::event::emit<MinterAdded>(v0);
    }

    public fun burn(arg0: &mut SUISHIBStorage, arg1: 0x2::coin::Coin<SUISHIB>) : u64 {
        0x2::balance::decrease_supply<SUISHIB>(&mut arg0.supply, 0x2::coin::into_balance<SUISHIB>(arg1))
    }

    fun init(arg0: SUISHIB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISHIB>(arg0, 4, b"SUISHIB", b"SuiShiba Inu", b"The first meme token on Sui Blockchain, @SuiShibaInu", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = 0x2::coin::treasury_into_supply<SUISHIB>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<SUISHIB>>(0x2::coin::from_balance<SUISHIB>(0x2::balance::increase_supply<SUISHIB>(&mut v2, 10000000000000000000), arg1), 0x2::tx_context::sender(arg1));
        let v3 = SUISHIBAdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<SUISHIBAdminCap>(v3, 0x2::tx_context::sender(arg1));
        let v4 = SUISHIBStorage{
            id      : 0x2::object::new(arg1),
            supply  : v2,
            minters : 0x2::vec_set::empty<0x2::object::ID>(),
        };
        0x2::transfer::share_object<SUISHIBStorage>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUISHIB>>(v1);
    }

    public fun is_minter(arg0: &SUISHIBStorage, arg1: 0x2::object::ID) : bool {
        0x2::vec_set::contains<0x2::object::ID>(&arg0.minters, &arg1)
    }

    public fun mint(arg0: &mut SUISHIBStorage, arg1: &0x2::package::Publisher, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<SUISHIB> {
        assert!(is_minter(arg0, 0x2::object::id<0x2::package::Publisher>(arg1)), 1);
        0x2::coin::from_balance<SUISHIB>(0x2::balance::increase_supply<SUISHIB>(&mut arg0.supply, arg2), arg3)
    }

    public entry fun remove_minter(arg0: &SUISHIBAdminCap, arg1: &mut SUISHIBStorage, arg2: 0x2::object::ID) {
        0x2::vec_set::remove<0x2::object::ID>(&mut arg1.minters, &arg2);
        let v0 = MinterRemoved{id: arg2};
        0x2::event::emit<MinterRemoved>(v0);
    }

    public fun total_supply(arg0: &SUISHIBStorage) : u64 {
        0x2::balance::supply_value<SUISHIB>(&arg0.supply)
    }

    public entry fun transfer_admin(arg0: SUISHIBAdminCap, arg1: address) {
        assert!(arg1 != @0x0, 2);
        0x2::transfer::transfer<SUISHIBAdminCap>(arg0, arg1);
        let v0 = NewAdmin{admin: arg1};
        0x2::event::emit<NewAdmin>(v0);
    }

    // decompiled from Move bytecode v6
}

