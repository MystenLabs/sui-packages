module 0xdb3034eb52a5da620f4752604a6f54879562e547e554b34d26e2144ed9ab3246::flx {
    struct FLX has drop {
        dummy_field: bool,
    }

    struct TreasuryManagement has key {
        id: 0x2::object::UID,
        treasury_cap: 0x2::coin::TreasuryCap<FLX>,
    }

    struct Mint has copy, drop {
        amount: u64,
        minter: address,
    }

    struct Burn has copy, drop {
        amount: u64,
        sender: address,
    }

    public entry fun burn(arg0: &mut TreasuryManagement, arg1: 0x2::coin::Coin<FLX>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Burn{
            amount : 0x2::coin::burn<FLX>(&mut arg0.treasury_cap, arg1),
            sender : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<Burn>(v0);
    }

    public fun mint(arg0: &mut TreasuryManagement, arg1: &0x9145333f34ed7fab143bffc5622632892c3e742c7fd6c3f0679a2d67bb42e5e1::access_control::Role<0xdb3034eb52a5da620f4752604a6f54879562e547e554b34d26e2144ed9ab3246::minter_role::MINTER_ROLE>, arg2: &0x9145333f34ed7fab143bffc5622632892c3e742c7fd6c3f0679a2d67bb42e5e1::access_control::Member<0xdb3034eb52a5da620f4752604a6f54879562e547e554b34d26e2144ed9ab3246::minter_role::MINTER_ROLE>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<FLX> {
        0x9145333f34ed7fab143bffc5622632892c3e742c7fd6c3f0679a2d67bb42e5e1::access_control::check_role<0xdb3034eb52a5da620f4752604a6f54879562e547e554b34d26e2144ed9ab3246::minter_role::MINTER_ROLE>(arg1, arg2);
        assert!(arg3 <= 1000000000000000 - 0x2::coin::total_supply<FLX>(&arg0.treasury_cap), 1);
        let v0 = Mint{
            amount : arg3,
            minter : 0x2::object::id_address<0x9145333f34ed7fab143bffc5622632892c3e742c7fd6c3f0679a2d67bb42e5e1::access_control::Member<0xdb3034eb52a5da620f4752604a6f54879562e547e554b34d26e2144ed9ab3246::minter_role::MINTER_ROLE>>(arg2),
        };
        0x2::event::emit<Mint>(v0);
        0x2::coin::mint<FLX>(&mut arg0.treasury_cap, arg3, arg4)
    }

    public entry fun transfer(arg0: 0x2::coin::Coin<FLX>, arg1: address) {
        assert!(arg1 != @0x0, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<FLX>>(arg0, arg1);
    }

    fun init(arg0: FLX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLX>(arg0, 8, b"FLX", b"FlowX", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FLX>>(v1);
        let v2 = TreasuryManagement{
            id           : 0x2::object::new(arg1),
            treasury_cap : v0,
        };
        0x2::transfer::share_object<TreasuryManagement>(v2);
    }

    public entry fun mint_and_transfer(arg0: &mut TreasuryManagement, arg1: &0x9145333f34ed7fab143bffc5622632892c3e742c7fd6c3f0679a2d67bb42e5e1::access_control::Role<0xdb3034eb52a5da620f4752604a6f54879562e547e554b34d26e2144ed9ab3246::minter_role::MINTER_ROLE>, arg2: &0x9145333f34ed7fab143bffc5622632892c3e742c7fd6c3f0679a2d67bb42e5e1::access_control::Member<0xdb3034eb52a5da620f4752604a6f54879562e547e554b34d26e2144ed9ab3246::minter_role::MINTER_ROLE>, arg3: address, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg3 != @0x0, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<FLX>>(mint(arg0, arg1, arg2, arg4, arg5), arg3);
    }

    // decompiled from Move bytecode v6
}

