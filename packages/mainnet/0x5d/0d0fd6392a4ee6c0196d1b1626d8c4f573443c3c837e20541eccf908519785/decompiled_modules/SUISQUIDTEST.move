module 0x5d0d0fd6392a4ee6c0196d1b1626d8c4f573443c3c837e20541eccf908519785::SUISQUIDTEST {
    struct SUISQUIDTEST has drop {
        dummy_field: bool,
    }

    struct SUISQUIDTESTStorage has key {
        id: 0x2::object::UID,
        supply: 0x2::balance::Supply<SUISQUIDTEST>,
        minters: 0x2::vec_set::VecSet<0x2::object::ID>,
    }

    struct SUISQUIDTESTAdminCap has key {
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

    public entry fun transfer(arg0: 0x2::coin::Coin<SUISQUIDTEST>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SUISQUIDTEST>>(arg0, arg1);
    }

    public entry fun add_minter(arg0: &SUISQUIDTESTAdminCap, arg1: &mut SUISQUIDTESTStorage, arg2: 0x2::object::ID) {
        0x2::vec_set::insert<0x2::object::ID>(&mut arg1.minters, arg2);
        let v0 = MinterAdded{id: arg2};
        0x2::event::emit<MinterAdded>(v0);
    }

    public fun burn(arg0: &mut SUISQUIDTESTStorage, arg1: 0x2::coin::Coin<SUISQUIDTEST>) : u64 {
        0x2::balance::decrease_supply<SUISQUIDTEST>(&mut arg0.supply, 0x2::coin::into_balance<SUISQUIDTEST>(arg1))
    }

    fun init(arg0: SUISQUIDTEST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISQUIDTEST>(arg0, 9, b"SUISQUIDTEST", b"Interest Protocol Token", b"The governance token of Interest Protocol", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://interestprotocol.infura-ipfs.io/ipfs/QmXCQHziDxHP3b4tvoYLUs5h6RyaX1z5zNP9zdYNRjjxsP")), arg1);
        let v2 = 0x2::coin::treasury_into_supply<SUISQUIDTEST>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<SUISQUIDTEST>>(0x2::coin::from_balance<SUISQUIDTEST>(0x2::balance::increase_supply<SUISQUIDTEST>(&mut v2, 600000000000000000), arg1), 0x2::tx_context::sender(arg1));
        let v3 = SUISQUIDTESTAdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<SUISQUIDTESTAdminCap>(v3, 0x2::tx_context::sender(arg1));
        let v4 = SUISQUIDTESTStorage{
            id      : 0x2::object::new(arg1),
            supply  : v2,
            minters : 0x2::vec_set::empty<0x2::object::ID>(),
        };
        0x2::transfer::share_object<SUISQUIDTESTStorage>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUISQUIDTEST>>(v1);
    }

    public fun is_minter(arg0: &SUISQUIDTESTStorage, arg1: 0x2::object::ID) : bool {
        0x2::vec_set::contains<0x2::object::ID>(&arg0.minters, &arg1)
    }

    public fun mint(arg0: &mut SUISQUIDTESTStorage, arg1: &0x2::package::Publisher, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<SUISQUIDTEST> {
        assert!(is_minter(arg0, 0x2::object::id<0x2::package::Publisher>(arg1)), 1);
        0x2::coin::from_balance<SUISQUIDTEST>(0x2::balance::increase_supply<SUISQUIDTEST>(&mut arg0.supply, arg2), arg3)
    }

    public entry fun remove_minter(arg0: &SUISQUIDTESTAdminCap, arg1: &mut SUISQUIDTESTStorage, arg2: 0x2::object::ID) {
        0x2::vec_set::remove<0x2::object::ID>(&mut arg1.minters, &arg2);
        let v0 = MinterRemoved{id: arg2};
        0x2::event::emit<MinterRemoved>(v0);
    }

    public fun total_supply(arg0: &SUISQUIDTESTStorage) : u64 {
        0x2::balance::supply_value<SUISQUIDTEST>(&arg0.supply)
    }

    public entry fun transfer_admin(arg0: SUISQUIDTESTAdminCap, arg1: address) {
        assert!(arg1 != @0x0, 2);
        0x2::transfer::transfer<SUISQUIDTESTAdminCap>(arg0, arg1);
        let v0 = NewAdmin{admin: arg1};
        0x2::event::emit<NewAdmin>(v0);
    }

    // decompiled from Move bytecode v6
}

