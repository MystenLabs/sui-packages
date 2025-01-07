module 0xa0e558a9a5195fe652426f03ee2594b51c5501bbcfd0a332805905861071a1e2::dinoshib {
    struct DINOSHIB has drop {
        dummy_field: bool,
    }

    struct DINOSHIBStorage has key {
        id: 0x2::object::UID,
        supply: 0x2::balance::Supply<DINOSHIB>,
        minters: 0x2::vec_set::VecSet<0x2::object::ID>,
    }

    struct DINOSHIBAdminCap has key {
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

    public entry fun transfer(arg0: 0x2::coin::Coin<DINOSHIB>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<DINOSHIB>>(arg0, arg1);
    }

    public entry fun add_minter(arg0: &DINOSHIBAdminCap, arg1: &mut DINOSHIBStorage, arg2: 0x2::object::ID) {
        0x2::vec_set::insert<0x2::object::ID>(&mut arg1.minters, arg2);
        let v0 = MinterAdded{id: arg2};
        0x2::event::emit<MinterAdded>(v0);
    }

    public fun burn(arg0: &mut DINOSHIBStorage, arg1: 0x2::coin::Coin<DINOSHIB>) : u64 {
        0x2::balance::decrease_supply<DINOSHIB>(&mut arg0.supply, 0x2::coin::into_balance<DINOSHIB>(arg1))
    }

    fun init(arg0: DINOSHIB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DINOSHIB>(arg0, 4, b"DINOSHIB", b"DINOSHIB", b"The first meme token on Sui Blockchain, ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://img.freepik.com/free-vector/cute-shiba-inu-dog-wearing-dino-costume-cartoon-vector-icon-illustration-animal-holiday-isolated_138676-7108.jpg?w=740&t=st=1683882693~exp=1683883293~hmac=943b07a01b528ddbc77b0707c47e2a641944c440c2570d638a84fb0c7c195892")), arg1);
        let v2 = 0x2::coin::treasury_into_supply<DINOSHIB>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<DINOSHIB>>(0x2::coin::from_balance<DINOSHIB>(0x2::balance::increase_supply<DINOSHIB>(&mut v2, 10000000000000000000), arg1), 0x2::tx_context::sender(arg1));
        let v3 = DINOSHIBAdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<DINOSHIBAdminCap>(v3, 0x2::tx_context::sender(arg1));
        let v4 = DINOSHIBStorage{
            id      : 0x2::object::new(arg1),
            supply  : v2,
            minters : 0x2::vec_set::empty<0x2::object::ID>(),
        };
        0x2::transfer::share_object<DINOSHIBStorage>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DINOSHIB>>(v1);
    }

    public fun is_minter(arg0: &DINOSHIBStorage, arg1: 0x2::object::ID) : bool {
        0x2::vec_set::contains<0x2::object::ID>(&arg0.minters, &arg1)
    }

    public fun mint(arg0: &mut DINOSHIBStorage, arg1: &0x2::package::Publisher, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<DINOSHIB> {
        assert!(is_minter(arg0, 0x2::object::id<0x2::package::Publisher>(arg1)), 1);
        0x2::coin::from_balance<DINOSHIB>(0x2::balance::increase_supply<DINOSHIB>(&mut arg0.supply, arg2), arg3)
    }

    public entry fun remove_minter(arg0: &DINOSHIBAdminCap, arg1: &mut DINOSHIBStorage, arg2: 0x2::object::ID) {
        0x2::vec_set::remove<0x2::object::ID>(&mut arg1.minters, &arg2);
        let v0 = MinterRemoved{id: arg2};
        0x2::event::emit<MinterRemoved>(v0);
    }

    public fun total_supply(arg0: &DINOSHIBStorage) : u64 {
        0x2::balance::supply_value<DINOSHIB>(&arg0.supply)
    }

    public entry fun transfer_admin(arg0: DINOSHIBAdminCap, arg1: address) {
        assert!(arg1 != @0x0, 2);
        0x2::transfer::transfer<DINOSHIBAdminCap>(arg0, arg1);
        let v0 = NewAdmin{admin: arg1};
        0x2::event::emit<NewAdmin>(v0);
    }

    // decompiled from Move bytecode v6
}

