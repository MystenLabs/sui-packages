module 0x4e56b39acd75721999cf833062dfb77b1d51e749b02d90f049a5688e21919a64::prl {
    struct PRL has drop {
        dummy_field: bool,
    }

    struct TreasuryManagement has store, key {
        id: 0x2::object::UID,
        total_amount_minted: u64,
        treasury_cap: 0x2::coin::TreasuryCap<PRL>,
    }

    struct Mint has copy, drop {
        amount: u64,
        minter: address,
    }

    struct Burn has copy, drop {
        amount: u64,
        sender: address,
    }

    public entry fun burn(arg0: &mut TreasuryManagement, arg1: 0x2::coin::Coin<PRL>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Burn{
            amount : 0x2::coin::burn<PRL>(&mut arg0.treasury_cap, arg1),
            sender : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<Burn>(v0);
    }

    public fun mint(arg0: &mut TreasuryManagement, arg1: &0x31036527dcef242ded53780d6f493c1d86982c97111a8cf4e7c9e22b60c2a3a5::access_control::Role<0x4e56b39acd75721999cf833062dfb77b1d51e749b02d90f049a5688e21919a64::pearl_minter_role::PEARL_MINTER_ROLE>, arg2: &0x31036527dcef242ded53780d6f493c1d86982c97111a8cf4e7c9e22b60c2a3a5::access_control::Member<0x4e56b39acd75721999cf833062dfb77b1d51e749b02d90f049a5688e21919a64::pearl_minter_role::PEARL_MINTER_ROLE>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<PRL> {
        0x31036527dcef242ded53780d6f493c1d86982c97111a8cf4e7c9e22b60c2a3a5::access_control::check_role<0x4e56b39acd75721999cf833062dfb77b1d51e749b02d90f049a5688e21919a64::pearl_minter_role::PEARL_MINTER_ROLE>(arg1, arg2);
        assert!(arg3 <= 10000000000000000 - arg0.total_amount_minted, 0);
        let v0 = Mint{
            amount : arg3,
            minter : 0x2::object::id_address<0x31036527dcef242ded53780d6f493c1d86982c97111a8cf4e7c9e22b60c2a3a5::access_control::Member<0x4e56b39acd75721999cf833062dfb77b1d51e749b02d90f049a5688e21919a64::pearl_minter_role::PEARL_MINTER_ROLE>>(arg2),
        };
        0x2::event::emit<Mint>(v0);
        arg0.total_amount_minted = arg0.total_amount_minted + arg3;
        0x2::coin::mint<PRL>(&mut arg0.treasury_cap, arg3, arg4)
    }

    public entry fun transfer(arg0: 0x2::coin::Coin<PRL>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<PRL>>(arg0, arg1);
    }

    fun init(arg0: PRL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PRL>(arg0, 12, b"PRL", b"Pearl", b"The governance token of SuiPearl - the Yield Optimizer on Sui Network.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreictaewmj4tunhkcejcnismyrj6s7rxggusircu6hyiaora67uxjhu")), arg1);
        let v2 = v0;
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PRL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<PRL>>(0x2::coin::mint<PRL>(&mut v2, 1000000000000000, arg1), 0x2::tx_context::sender(arg1));
        let v3 = TreasuryManagement{
            id                  : 0x2::object::new(arg1),
            total_amount_minted : 1000000000000000,
            treasury_cap        : v2,
        };
        0x2::transfer::public_share_object<TreasuryManagement>(v3);
    }

    public entry fun mint_and_transfer(arg0: &mut TreasuryManagement, arg1: &0x31036527dcef242ded53780d6f493c1d86982c97111a8cf4e7c9e22b60c2a3a5::access_control::Role<0x4e56b39acd75721999cf833062dfb77b1d51e749b02d90f049a5688e21919a64::pearl_minter_role::PEARL_MINTER_ROLE>, arg2: &0x31036527dcef242ded53780d6f493c1d86982c97111a8cf4e7c9e22b60c2a3a5::access_control::Member<0x4e56b39acd75721999cf833062dfb77b1d51e749b02d90f049a5688e21919a64::pearl_minter_role::PEARL_MINTER_ROLE>, arg3: address, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<PRL>>(mint(arg0, arg1, arg2, arg4, arg5), arg3);
    }

    // decompiled from Move bytecode v6
}

