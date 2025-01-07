module 0xe6e3e2fe85bc88668f469b8424091c71481aef16460b6610f1c6054aa90e75b6::test101 {
    struct TEST101 has drop {
        dummy_field: bool,
    }

    struct TEST101Storage has key {
        id: 0x2::object::UID,
        supply: 0x2::balance::Supply<TEST101>,
        minters: 0x2::vec_set::VecSet<0x2::object::ID>,
    }

    struct TEST101AdminCap has key {
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

    public entry fun transfer(arg0: 0x2::coin::Coin<TEST101>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<TEST101>>(arg0, arg1);
    }

    public entry fun add_minter(arg0: &TEST101AdminCap, arg1: &mut TEST101Storage, arg2: 0x2::object::ID) {
        0x2::vec_set::insert<0x2::object::ID>(&mut arg1.minters, arg2);
        let v0 = MinterAdded{id: arg2};
        0x2::event::emit<MinterAdded>(v0);
    }

    public fun burn(arg0: &mut TEST101Storage, arg1: 0x2::coin::Coin<TEST101>) : u64 {
        0x2::balance::decrease_supply<TEST101>(&mut arg0.supply, 0x2::coin::into_balance<TEST101>(arg1))
    }

    fun init(arg0: TEST101, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEST101>(arg0, 6, b"TEST101", b"TEST101 Token", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gateway.pinata.cloud/ipfs/Qmc4rzRTCGZiZkTKtA1hZMd9LG6eK2wTTMjo5ZFh6QiJma")), arg1);
        let v2 = 0x2::coin::treasury_into_supply<TEST101>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<TEST101>>(0x2::coin::from_balance<TEST101>(0x2::balance::increase_supply<TEST101>(&mut v2, 1000000000000000), arg1), 0x2::tx_context::sender(arg1));
        let v3 = TEST101AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<TEST101AdminCap>(v3, 0x2::tx_context::sender(arg1));
        let v4 = TEST101Storage{
            id      : 0x2::object::new(arg1),
            supply  : v2,
            minters : 0x2::vec_set::empty<0x2::object::ID>(),
        };
        0x2::transfer::share_object<TEST101Storage>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TEST101>>(v1);
    }

    public fun is_minter(arg0: &TEST101Storage, arg1: 0x2::object::ID) : bool {
        0x2::vec_set::contains<0x2::object::ID>(&arg0.minters, &arg1)
    }

    public fun mint(arg0: &mut TEST101Storage, arg1: &0x2::package::Publisher, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<TEST101> {
        assert!(is_minter(arg0, 0x2::object::id<0x2::package::Publisher>(arg1)), 1);
        0x2::coin::from_balance<TEST101>(0x2::balance::increase_supply<TEST101>(&mut arg0.supply, arg2), arg3)
    }

    public entry fun remove_minter(arg0: &TEST101AdminCap, arg1: &mut TEST101Storage, arg2: 0x2::object::ID) {
        0x2::vec_set::remove<0x2::object::ID>(&mut arg1.minters, &arg2);
        let v0 = MinterRemoved{id: arg2};
        0x2::event::emit<MinterRemoved>(v0);
    }

    public fun total_supply(arg0: &TEST101Storage) : u64 {
        0x2::balance::supply_value<TEST101>(&arg0.supply)
    }

    public entry fun transfer_admin(arg0: TEST101AdminCap, arg1: address) {
        assert!(arg1 != @0x0, 2);
        0x2::transfer::transfer<TEST101AdminCap>(arg0, arg1);
        let v0 = NewAdmin{admin: arg1};
        0x2::event::emit<NewAdmin>(v0);
    }

    // decompiled from Move bytecode v6
}

