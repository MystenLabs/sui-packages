module 0xe3635de709b23db278f43b852aacfaa49f8d6edd648a2f57f960d08bdf599be2::launchpad {
    struct LAUNCHPAD has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct TokenPool has key {
        id: 0x2::object::UID,
        treasury_cap: 0x2::coin::TreasuryCap<LAUNCHPAD>,
        minted: u64,
        total_supply: u64,
        target_sui_mist: u64,
        base_price: u64,
        symbol: vector<u8>,
    }

    struct MintEvent has copy, drop {
        pool_id: address,
        amount: u64,
        sui_paid: u64,
        minter: address,
    }

    public fun base_price(arg0: &TokenPool) : u64 {
        arg0.base_price
    }

    public entry fun create_admin_cap(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun create_token(arg0: &AdminCap, arg1: 0x2::coin::TreasuryCap<LAUNCHPAD>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u8>(&arg2) >= 3 && 0x1::vector::length<u8>(&arg2) <= 32, 0);
        assert!(0x1::vector::length<u8>(&arg3) >= 2 && 0x1::vector::length<u8>(&arg3) <= 8, 1);
        assert!(0x1::vector::length<u8>(&arg4) <= 100, 0);
        assert!(0x1::vector::length<u8>(&arg5) >= 12 && 0x1::vector::length<u8>(&arg5) <= 128, 7);
        assert!(arg6 > arg7 * 1000000000, 2);
        assert!(arg7 >= 100000, 3);
        let v0 = 0;
        while (v0 < 0x1::vector::length<u8>(&arg3)) {
            let v1 = *0x1::vector::borrow<u8>(&arg3, v0);
            let v2 = if (v1 >= 65 && v1 <= 90) {
                true
            } else if (v1 >= 97 && v1 <= 122) {
                true
            } else {
                v1 >= 48 && v1 <= 57
            };
            assert!(v2, 1);
            v0 = v0 + 1;
        };
        let v3 = TokenPool{
            id              : 0x2::object::new(arg8),
            treasury_cap    : arg1,
            minted          : 0,
            total_supply    : 1000000000,
            target_sui_mist : arg6,
            base_price      : arg7,
            symbol          : arg3,
        };
        0x2::transfer::share_object<TokenPool>(v3);
    }

    public fun get_price(arg0: &TokenPool, arg1: u64) : u64 {
        (arg0.base_price + arg0.minted / arg0.total_supply * arg0.target_sui_mist / arg0.total_supply) * arg1
    }

    fun init(arg0: LAUNCHPAD, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg1)};
        let (v1, v2) = 0x2::coin::create_currency<LAUNCHPAD>(arg0, 9, b"LAUNCH", b"Launchpad Token", b"Base token for launchpad", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<AdminCap>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LAUNCHPAD>>(v2);
        let v3 = TokenPool{
            id              : 0x2::object::new(arg1),
            treasury_cap    : v1,
            minted          : 0,
            total_supply    : 1000000000,
            target_sui_mist : 1000001,
            base_price      : 100000,
            symbol          : b"LAUNCH",
        };
        0x2::transfer::share_object<TokenPool>(v3);
    }

    public entry fun mint_tokens(arg0: &mut TokenPool, arg1: u64, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 > 0, 4);
        assert!(arg0.minted + arg1 <= arg0.total_supply, 5);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        assert!(v0 >= get_price(arg0, arg1), 6);
        arg0.minted = arg0.minted + arg1;
        0x2::transfer::public_transfer<0x2::coin::Coin<LAUNCHPAD>>(0x2::coin::mint<LAUNCHPAD>(&mut arg0.treasury_cap, arg1, arg3), 0x2::tx_context::sender(arg3));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, 0x2::object::id_address<TokenPool>(arg0));
        let v1 = MintEvent{
            pool_id  : 0x2::object::id_address<TokenPool>(arg0),
            amount   : arg1,
            sui_paid : v0,
            minter   : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<MintEvent>(v1);
    }

    public fun minted(arg0: &TokenPool) : u64 {
        arg0.minted
    }

    public fun symbol(arg0: &TokenPool) : vector<u8> {
        arg0.symbol
    }

    public fun target_sui_mist(arg0: &TokenPool) : u64 {
        arg0.target_sui_mist
    }

    public fun total_supply(arg0: &TokenPool) : u64 {
        arg0.total_supply
    }

    // decompiled from Move bytecode v6
}

