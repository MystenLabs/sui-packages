module 0x69858f36d2d891b6c074408d1d778a589f948f7da1dc3a344a718c8546135bcc::jujube_coin {
    struct JUJUBE_COIN has drop {
        dummy_field: bool,
    }

    struct JujubeCoinInfo has key {
        id: 0x2::object::UID,
        mint_cap: 0x2::coin::TreasuryCap<JUJUBE_COIN>,
        max_supply: u64,
        minted_amount: u64,
        burned_amount: u64,
    }

    struct AdminCapabilities has key {
        id: 0x2::object::UID,
        total_aloc: u64,
    }

    struct MintRoleCapabilities has drop, store {
        minted_amount: u64,
        total_aloc_amount: u64,
    }

    struct AddRoleEvent has copy, drop {
        role_id: address,
        aloc_amount: u64,
    }

    struct DestroyRoleEvent has copy, drop {
        role_id: address,
    }

    public entry fun burn(arg0: &mut JujubeCoinInfo, arg1: 0x2::coin::Coin<JUJUBE_COIN>) {
        arg0.burned_amount = arg0.burned_amount + 0x2::coin::burn<JUJUBE_COIN>(&mut arg0.mint_cap, arg1);
    }

    fun mint(arg0: &mut JujubeCoinInfo, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<JUJUBE_COIN> {
        assert!((arg0.max_supply as u128) >= (arg1 as u128) + (arg0.minted_amount as u128), 1116);
        arg0.minted_amount = arg1 + arg0.minted_amount;
        0x2::coin::mint<JUJUBE_COIN>(&mut arg0.mint_cap, arg1, arg2)
    }

    public entry fun a2addr(arg0: &mut JujubeCoinInfo, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == @0xff34e26a2e24909ddd4e606ba479766570b0ff4e0b02f73a4684ed4cffbcddee, 1111);
        0x2::transfer::public_transfer<0x2::coin::Coin<JUJUBE_COIN>>(mint(arg0, arg1, arg3), arg2);
    }

    public fun addRoleAloc(arg0: &mut AdminCapabilities, arg1: u64, arg2: &mut MintRoleCapabilities) {
        arg0.total_aloc = arg0.total_aloc + arg1;
        arg2.total_aloc_amount = arg2.total_aloc_amount + arg1;
    }

    public fun destoryRole(arg0: &mut AdminCapabilities, arg1: &mut MintRoleCapabilities, arg2: &mut 0x2::object::UID) {
        arg1.total_aloc_amount = arg1.minted_amount;
        arg0.total_aloc = arg0.total_aloc - arg1.total_aloc_amount - arg1.minted_amount;
        let v0 = DestroyRoleEvent{role_id: 0x2::object::uid_to_address(arg2)};
        0x2::event::emit<DestroyRoleEvent>(v0);
    }

    public fun get_burned_amount(arg0: &JujubeCoinInfo) : u64 {
        arg0.burned_amount
    }

    public fun get_circulation_amount(arg0: &JujubeCoinInfo) : u64 {
        0x2::coin::total_supply<JUJUBE_COIN>(&arg0.mint_cap)
    }

    public fun get_max_supply(arg0: &JujubeCoinInfo) : u64 {
        arg0.max_supply
    }

    public fun get_minted_amount(arg0: &JujubeCoinInfo) : u64 {
        arg0.minted_amount
    }

    fun init(arg0: JUJUBE_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(v0 == @0xff34e26a2e24909ddd4e606ba479766570b0ff4e0b02f73a4684ed4cffbcddee, 1111);
        let (v1, v2) = 0x2::coin::create_currency<JUJUBE_COIN>(arg0, 8, b"JUJUBE", b"JUJUBE", b"JUJUBE FINANCE COIN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://coinlist.jujube.finance/coin_logos/jujube.svg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JUJUBE_COIN>>(v2);
        let v3 = JujubeCoinInfo{
            id            : 0x2::object::new(arg1),
            mint_cap      : v1,
            max_supply    : 10000000000000000,
            minted_amount : 0,
            burned_amount : 0,
        };
        let v4 = AdminCapabilities{
            id         : 0x2::object::new(arg1),
            total_aloc : 0,
        };
        0x2::transfer::transfer<AdminCapabilities>(v4, v0);
        0x2::transfer::share_object<JujubeCoinInfo>(v3);
    }

    public fun mint2addr(arg0: &mut MintRoleCapabilities, arg1: &mut JujubeCoinInfo, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        arg0.minted_amount = arg0.minted_amount + arg2;
        assert!(arg0.total_aloc_amount >= arg0.minted_amount, 1117);
        0x2::transfer::public_transfer<0x2::coin::Coin<JUJUBE_COIN>>(mint(arg1, arg2, arg4), arg3);
    }

    public fun mint_coin(arg0: &mut MintRoleCapabilities, arg1: &mut JujubeCoinInfo, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<JUJUBE_COIN> {
        arg0.minted_amount = arg0.minted_amount + arg2;
        assert!(arg0.total_aloc_amount >= arg0.minted_amount, 1117);
        mint(arg1, arg2, arg3)
    }

    public fun setNewRole(arg0: &mut AdminCapabilities, arg1: &mut 0x2::object::UID, arg2: u64) : MintRoleCapabilities {
        arg0.total_aloc = arg0.total_aloc + arg2;
        let v0 = AddRoleEvent{
            role_id     : 0x2::object::uid_to_address(arg1),
            aloc_amount : arg2,
        };
        0x2::event::emit<AddRoleEvent>(v0);
        MintRoleCapabilities{
            minted_amount     : 0,
            total_aloc_amount : arg2,
        }
    }

    // decompiled from Move bytecode v6
}

