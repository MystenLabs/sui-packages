module 0xf6b468748dced8435f4407d0ecb0457b921a2e89266a60862e36dbf243c71841::deusd {
    struct DEUSD has drop {
        dummy_field: bool,
    }

    struct DeUSDConfig has key {
        id: 0x2::object::UID,
        treasury_cap: 0x2::coin::TreasuryCap<DEUSD>,
        deny_cap: 0x2::coin::DenyCapV2<DEUSD>,
    }

    struct Mint has copy, drop, store {
        to: address,
        amount: u64,
    }

    struct Burn has copy, drop, store {
        from: address,
        amount: u64,
    }

    public(friend) fun mint(arg0: &mut DeUSDConfig, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 != @0x0, 1);
        assert!(arg2 > 0, 2);
        let v0 = Mint{
            to     : arg1,
            amount : arg2,
        };
        0x2::event::emit<Mint>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<DEUSD>>(0x2::coin::mint<DEUSD>(&mut arg0.treasury_cap, arg2, arg3), arg1);
    }

    public fun total_supply(arg0: &DeUSDConfig) : u64 {
        0x2::coin::total_supply<DEUSD>(&arg0.treasury_cap)
    }

    public(friend) fun burn_from(arg0: &mut DeUSDConfig, arg1: 0x2::coin::Coin<DEUSD>, arg2: address) {
        let v0 = Burn{
            from   : arg2,
            amount : 0x2::coin::value<DEUSD>(&arg1),
        };
        0x2::event::emit<Burn>(v0);
        0x2::coin::burn<DEUSD>(&mut arg0.treasury_cap, arg1);
    }

    public fun decimals() : u8 {
        6
    }

    fun init(arg0: DEUSD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<DEUSD>(arg0, 6, b"deUSD", b"Elixir's deUSD", b"Elixir's deUSD", 0x1::option::none<0x2::url::Url>(), true, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DEUSD>>(v2);
        let v3 = DeUSDConfig{
            id           : 0x2::object::new(arg1),
            treasury_cap : v0,
            deny_cap     : v1,
        };
        0x2::transfer::share_object<DeUSDConfig>(v3);
    }

    // decompiled from Move bytecode v6
}

