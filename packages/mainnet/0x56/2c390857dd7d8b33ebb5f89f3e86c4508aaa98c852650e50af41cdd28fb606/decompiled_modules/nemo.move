module 0x562c390857dd7d8b33ebb5f89f3e86c4508aaa98c852650e50af41cdd28fb606::nemo {
    struct NEMO has drop {
        dummy_field: bool,
    }

    struct NEMOStorage has key {
        id: 0x2::object::UID,
        supply: 0x2::balance::Supply<NEMO>,
        minters: 0x2::vec_set::VecSet<0x2::object::ID>,
    }

    struct NEMOAdminCap has key {
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

    public entry fun transfer(arg0: 0x2::coin::Coin<NEMO>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<NEMO>>(arg0, arg1);
    }

    public entry fun add_minter(arg0: &NEMOAdminCap, arg1: &mut NEMOStorage, arg2: 0x2::object::ID) {
        0x2::vec_set::insert<0x2::object::ID>(&mut arg1.minters, arg2);
        let v0 = MinterAdded{id: arg2};
        0x2::event::emit<MinterAdded>(v0);
    }

    public fun burn(arg0: &mut NEMOStorage, arg1: 0x2::coin::Coin<NEMO>) : u64 {
        0x2::balance::decrease_supply<NEMO>(&mut arg0.supply, 0x2::coin::into_balance<NEMO>(arg1))
    }

    fun init(arg0: NEMO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEMO>(arg0, 9, b"NEMO", b"Nemo Swap Finance Token", b"The governance token of Nemo Swap Finance", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeibrba7j2ptxqsdhhdwcduhcwavr463ui2reejln256jpu2w3rdvyi")), arg1);
        let v2 = 0x2::coin::treasury_into_supply<NEMO>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<NEMO>>(0x2::coin::from_balance<NEMO>(0x2::balance::increase_supply<NEMO>(&mut v2, 600000000000000000), arg1), 0x2::tx_context::sender(arg1));
        let v3 = NEMOAdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<NEMOAdminCap>(v3, 0x2::tx_context::sender(arg1));
        let v4 = NEMOStorage{
            id      : 0x2::object::new(arg1),
            supply  : v2,
            minters : 0x2::vec_set::empty<0x2::object::ID>(),
        };
        0x2::transfer::share_object<NEMOStorage>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NEMO>>(v1);
    }

    public fun is_minter(arg0: &NEMOStorage, arg1: 0x2::object::ID) : bool {
        0x2::vec_set::contains<0x2::object::ID>(&arg0.minters, &arg1)
    }

    public fun mint(arg0: &mut NEMOStorage, arg1: &0x2::package::Publisher, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<NEMO> {
        assert!(is_minter(arg0, 0x2::object::id<0x2::package::Publisher>(arg1)), 1);
        0x2::coin::from_balance<NEMO>(0x2::balance::increase_supply<NEMO>(&mut arg0.supply, arg2), arg3)
    }

    public entry fun remove_minter(arg0: &NEMOAdminCap, arg1: &mut NEMOStorage, arg2: 0x2::object::ID) {
        0x2::vec_set::remove<0x2::object::ID>(&mut arg1.minters, &arg2);
        let v0 = MinterRemoved{id: arg2};
        0x2::event::emit<MinterRemoved>(v0);
    }

    public fun total_supply(arg0: &NEMOStorage) : u64 {
        0x2::balance::supply_value<NEMO>(&arg0.supply)
    }

    public entry fun transfer_admin(arg0: NEMOAdminCap, arg1: address) {
        assert!(arg1 != @0x0, 2);
        0x2::transfer::transfer<NEMOAdminCap>(arg0, arg1);
        let v0 = NewAdmin{admin: arg1};
        0x2::event::emit<NewAdmin>(v0);
    }

    // decompiled from Move bytecode v6
}

