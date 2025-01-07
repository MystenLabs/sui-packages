module 0x4479f41ce2694aa57b3343e60ce4ecc176059d9b3b7fea0a80489a313a29f73e::ikun {
    struct IKUN has drop {
        dummy_field: bool,
    }

    struct SwapAdmin has key {
        id: 0x2::object::UID,
    }

    struct SwapStorage has store, key {
        id: 0x2::object::UID,
        sui_balance: 0x2::balance::Balance<0x2::sui::SUI>,
        ikun_balance: 0x2::balance::Balance<IKUN>,
        swap_rate: u64,
    }

    struct IKUNTrade has copy, drop {
        buyer: address,
        amount: u64,
    }

    public entry fun buy(arg0: &mut SwapStorage, arg1: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(1 <= arg2 && arg2 <= 100, 1);
        let v0 = arg2 * arg0.swap_rate;
        assert!(v0 <= 0x2::balance::value<IKUN>(&arg0.ikun_balance), 2);
        let v1 = 0x2::tx_context::sender(arg3);
        let v2 = IKUNTrade{
            buyer  : v1,
            amount : v0,
        };
        0x2::event::emit<IKUNTrade>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<IKUN>>(0x2::coin::take<IKUN>(&mut arg0.ikun_balance, v0, arg3), v1);
        0x2::coin::put<0x2::sui::SUI>(&mut arg0.sui_balance, 0x2::coin::split<0x2::sui::SUI>(arg1, arg2 * 1000000000, arg3));
    }

    fun init(arg0: IKUN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IKUN>(arg0, 0, b"IKUN", b"IKUN Token", b"Only true fans can acquire IKUN coin. Website https://ikunidol.com Twitter@ikunidol", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://arweave.net/vzx9XwyYdTb5DzjDe9xzn514tMK3YGd55dyjyxwII44")), arg1);
        let v2 = v0;
        let v3 = 0x2::tx_context::sender(arg1);
        let v4 = SwapAdmin{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<SwapAdmin>(v4, v3);
        let v5 = SwapStorage{
            id           : 0x2::object::new(arg1),
            sui_balance  : 0x2::balance::zero<0x2::sui::SUI>(),
            ikun_balance : 0x2::coin::mint_balance<IKUN>(&mut v2, 1000000000000000000 * 15),
            swap_rate    : 1000000000000,
        };
        0x2::transfer::share_object<SwapStorage>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<IKUN>>(0x2::coin::mint<IKUN>(&mut v2, 1000000000000000000 * 3, arg1), v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IKUN>>(v2, v3);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<IKUN>>(v1, v3);
    }

    public entry fun release(arg0: &mut SwapStorage, arg1: &SwapAdmin, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 <= 0x2::balance::value<IKUN>(&arg0.ikun_balance), 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<IKUN>>(0x2::coin::take<IKUN>(&mut arg0.ikun_balance, arg2, arg3), 0x2::tx_context::sender(arg3));
    }

    public entry fun set_swap_rate(arg0: &mut SwapStorage, arg1: &SwapAdmin, arg2: u64) {
        arg0.swap_rate = arg2;
    }

    public entry fun withdraw_sui(arg0: &mut SwapStorage, arg1: &SwapAdmin, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.sui_balance), arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

