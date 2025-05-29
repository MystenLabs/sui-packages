module 0x6bfcfa3ce048a9b67720fdc399103bde0b931b7e02105b6166cf1b933a31f8b9::launchpad {
    struct LAUNCHPAD has drop {
        dummy_field: bool,
    }

    struct TOKEN_WITNESS has drop {
        dummy_field: bool,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct TokenPool<phantom T0> has key {
        id: 0x2::object::UID,
        treasury_cap: 0x2::coin::TreasuryCap<T0>,
        minted: u64,
        total_supply: u64,
        target_sui_mist: u64,
        base_price: u64,
    }

    struct MintEvent has copy, drop {
        pool_id: address,
        amount: u64,
        sui_paid: u64,
        minter: address,
    }

    public fun base_price<T0>(arg0: &TokenPool<T0>) : u64 {
        arg0.base_price
    }

    public entry fun create_admin_cap(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun create_token(arg0: &AdminCap, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u8>(&arg1) >= 3 && 0x1::vector::length<u8>(&arg1) <= 32, 0);
        assert!(0x1::vector::length<u8>(&arg2) >= 2 && 0x1::vector::length<u8>(&arg2) <= 8, 1);
        assert!(0x1::vector::length<u8>(&arg3) <= 100, 0);
        assert!(arg5 > arg6 * 1000000000, 2);
        assert!(arg6 >= 100000, 3);
        let v0 = TOKEN_WITNESS{dummy_field: false};
        let (v1, v2) = 0x2::coin::create_currency<TOKEN_WITNESS>(v0, 9, arg2, arg1, arg3, 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(arg4))), arg7);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TOKEN_WITNESS>>(v2);
        let v3 = TokenPool<TOKEN_WITNESS>{
            id              : 0x2::object::new(arg7),
            treasury_cap    : v1,
            minted          : 0,
            total_supply    : 1000000000,
            target_sui_mist : arg5,
            base_price      : arg6,
        };
        0x2::transfer::share_object<TokenPool<TOKEN_WITNESS>>(v3);
    }

    public fun get_price<T0>(arg0: &TokenPool<T0>, arg1: u64) : u64 {
        (arg0.base_price + arg0.minted / arg0.total_supply * arg0.target_sui_mist / arg0.total_supply) * arg1
    }

    fun init(arg0: LAUNCHPAD, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint_tokens<T0>(arg0: &mut TokenPool<T0>, arg1: u64, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 > 0, 4);
        assert!(arg0.minted + arg1 <= arg0.total_supply, 5);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        assert!(v0 >= get_price<T0>(arg0, arg1), 6);
        arg0.minted = arg0.minted + arg1;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::mint<T0>(&mut arg0.treasury_cap, arg1, arg3), 0x2::tx_context::sender(arg3));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, 0x2::tx_context::sender(arg3));
        let v1 = MintEvent{
            pool_id  : 0x2::object::id_address<TokenPool<T0>>(arg0),
            amount   : arg1,
            sui_paid : v0,
            minter   : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<MintEvent>(v1);
    }

    public fun minted<T0>(arg0: &TokenPool<T0>) : u64 {
        arg0.minted
    }

    public fun target_sui_mist<T0>(arg0: &TokenPool<T0>) : u64 {
        arg0.target_sui_mist
    }

    public fun total_supply<T0>(arg0: &TokenPool<T0>) : u64 {
        arg0.total_supply
    }

    // decompiled from Move bytecode v6
}

