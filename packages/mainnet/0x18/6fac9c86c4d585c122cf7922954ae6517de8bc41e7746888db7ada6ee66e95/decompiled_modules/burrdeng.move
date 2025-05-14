module 0x186fac9c86c4d585c122cf7922954ae6517de8bc41e7746888db7ada6ee66e95::burrdeng {
    struct BURRDENG has drop {
        dummy_field: bool,
    }

    struct MintCapability has key {
        id: 0x2::object::UID,
        treasury: 0x2::coin::TreasuryCap<BURRDENG>,
        total_minted: u64,
    }

    struct Locker has store, key {
        id: 0x2::object::UID,
        unlock_date: u64,
        balance: 0x2::balance::Balance<BURRDENG>,
    }

    public fun mint(arg0: &mut MintCapability, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<BURRDENG>>(mint_internal(arg0, arg1, arg3), arg2);
    }

    public entry fun make_immutable(arg0: 0x2::package::UpgradeCap) {
        0x2::package::make_immutable(arg0);
    }

    fun init(arg0: BURRDENG, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(300000000000000000 <= 10000000000000000000, 1);
        let (v0, v1) = 0x2::coin::create_currency<BURRDENG>(arg0, 9, b"BRRG", b"Burrdeng", b"Burrdeng($BRRG) is a meme coin with a viral neigh, galloping on the SUI chain. Join the herd with its derpy snaggletooth charm!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://raw.githubusercontent.com/Burrdeng/logo/main/Burrdeng(BRRG)_Logo_500x500.jpg")), arg1);
        let v2 = MintCapability{
            id           : 0x2::object::new(arg1),
            treasury     : v0,
            total_minted : 0,
        };
        let v3 = &mut v2;
        let v4 = 0x2::tx_context::sender(arg1);
        mint(v3, 300000000000000000, v4, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BURRDENG>>(v1);
        0x2::transfer::transfer<MintCapability>(v2, 0x2::tx_context::sender(arg1));
    }

    fun mint_internal(arg0: &mut MintCapability, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<BURRDENG> {
        assert!(arg1 > 0, 0);
        assert!(arg1 <= 10000000000000000000 - arg0.total_minted, 1);
        arg0.total_minted = arg0.total_minted + arg1;
        0x2::coin::mint<BURRDENG>(&mut arg0.treasury, arg1, arg2)
    }

    public fun mint_locked(arg0: &mut MintCapability, arg1: u64, arg2: address, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 > 0, 0);
        let v0 = mint_internal(arg0, arg1, arg5);
        let v1 = 0x2::clock::timestamp_ms(arg4);
        let v2 = v1 + arg3;
        assert!(v2 >= v1, 999);
        let v3 = Locker{
            id          : 0x2::object::new(arg5),
            unlock_date : v2,
            balance     : 0x2::coin::into_balance<BURRDENG>(v0),
        };
        0x2::transfer::public_transfer<Locker>(v3, arg2);
    }

    entry fun withdraw_locked(arg0: Locker, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let Locker {
            id          : v0,
            unlock_date : v1,
            balance     : v2,
        } = arg0;
        let v3 = v2;
        assert!(0x2::clock::timestamp_ms(arg1) >= v1, 2);
        assert!(0x2::balance::value<BURRDENG>(&v3) > 0, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<BURRDENG>>(0x2::coin::take<BURRDENG>(&mut v3, 0x2::balance::value<BURRDENG>(&v3), arg2), 0x2::tx_context::sender(arg2));
        assert!(0x2::balance::value<BURRDENG>(&v3) == 0, 3);
        0x2::balance::destroy_zero<BURRDENG>(v3);
        0x2::object::delete(v0);
    }

    // decompiled from Move bytecode v6
}

