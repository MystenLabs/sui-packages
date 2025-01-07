module 0xd735282698c3093adf91c59ba5fa3294112d7dd713beb4f7753eac4637bd47a1::bark {
    struct BARK has drop {
        dummy_field: bool,
    }

    struct BARKStorage has key {
        id: 0x2::object::UID,
        supply: 0x2::balance::Supply<BARK>,
        minters: 0x2::vec_set::VecSet<0x2::object::ID>,
    }

    struct BARKAdminCap has key {
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

    public entry fun transfer(arg0: 0x2::coin::Coin<BARK>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<BARK>>(arg0, arg1);
    }

    public entry fun add_minter(arg0: &BARKAdminCap, arg1: &mut BARKStorage, arg2: 0x2::object::ID) {
        0x2::vec_set::insert<0x2::object::ID>(&mut arg1.minters, arg2);
        let v0 = MinterAdded{id: arg2};
        0x2::event::emit<MinterAdded>(v0);
    }

    public fun burn(arg0: &mut BARKStorage, arg1: 0x2::coin::Coin<BARK>) : u64 {
        0x2::balance::decrease_supply<BARK>(&mut arg0.supply, 0x2::coin::into_balance<BARK>(arg1))
    }

    fun init(arg0: BARK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BARK>(arg0, 3, b"BARK", b"Sui Bark Token", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gateway.pinata.cloud/ipfs/QmdUdUQwugvqyx4eVkKKaBjE15xDDwYSYhMyY6mgXunioM")), arg1);
        let v2 = 0x2::coin::treasury_into_supply<BARK>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<BARK>>(0x2::coin::from_balance<BARK>(0x2::balance::increase_supply<BARK>(&mut v2, 1000000000000000), arg1), 0x2::tx_context::sender(arg1));
        let v3 = BARKAdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<BARKAdminCap>(v3, 0x2::tx_context::sender(arg1));
        let v4 = BARKStorage{
            id      : 0x2::object::new(arg1),
            supply  : v2,
            minters : 0x2::vec_set::empty<0x2::object::ID>(),
        };
        0x2::transfer::share_object<BARKStorage>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BARK>>(v1);
    }

    public fun is_minter(arg0: &BARKStorage, arg1: 0x2::object::ID) : bool {
        0x2::vec_set::contains<0x2::object::ID>(&arg0.minters, &arg1)
    }

    public fun mint(arg0: &mut BARKStorage, arg1: &0x2::package::Publisher, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<BARK> {
        assert!(is_minter(arg0, 0x2::object::id<0x2::package::Publisher>(arg1)), 1);
        0x2::coin::from_balance<BARK>(0x2::balance::increase_supply<BARK>(&mut arg0.supply, arg2), arg3)
    }

    public entry fun remove_minter(arg0: &BARKAdminCap, arg1: &mut BARKStorage, arg2: 0x2::object::ID) {
        0x2::vec_set::remove<0x2::object::ID>(&mut arg1.minters, &arg2);
        let v0 = MinterRemoved{id: arg2};
        0x2::event::emit<MinterRemoved>(v0);
    }

    public fun total_supply(arg0: &BARKStorage) : u64 {
        0x2::balance::supply_value<BARK>(&arg0.supply)
    }

    public entry fun transfer_admin(arg0: BARKAdminCap, arg1: address) {
        assert!(arg1 != @0x0, 2);
        0x2::transfer::transfer<BARKAdminCap>(arg0, arg1);
        let v0 = NewAdmin{admin: arg1};
        0x2::event::emit<NewAdmin>(v0);
    }

    // decompiled from Move bytecode v6
}

