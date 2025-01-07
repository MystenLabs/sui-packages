module 0xf0fe2210b4f0c4e3aff7ed147f14980cf14f1114c6ad8fd531ab748ccf33373b::bswt {
    struct BSWT has drop {
        dummy_field: bool,
    }

    struct BSWTStorage has key {
        id: 0x2::object::UID,
        supply: 0x2::balance::Supply<BSWT>,
    }

    struct BSWTAdminCap has store, key {
        id: 0x2::object::UID,
    }

    public fun burn(arg0: &mut BSWTStorage, arg1: 0x2::coin::Coin<BSWT>) : u64 {
        0x2::balance::decrease_supply<BSWT>(&mut arg0.supply, 0x2::coin::into_balance<BSWT>(arg1))
    }

    fun init(arg0: BSWT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BSWT>(arg0, 9, b"BSWT", b"BaySwap Token", b"BaySwap governance token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://app.bayswap.io/bswt.png")), arg1);
        let v2 = BSWTAdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<BSWTAdminCap>(v2, 0x2::tx_context::sender(arg1));
        let v3 = BSWTStorage{
            id     : 0x2::object::new(arg1),
            supply : 0x2::coin::treasury_into_supply<BSWT>(v0),
        };
        0x2::transfer::share_object<BSWTStorage>(v3);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BSWT>>(v1);
    }

    public fun mint(arg0: &BSWTAdminCap, arg1: &mut BSWTStorage, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<BSWT> {
        0x2::coin::from_balance<BSWT>(0x2::balance::increase_supply<BSWT>(&mut arg1.supply, arg2), arg3)
    }

    // decompiled from Move bytecode v6
}

