module 0xd3470f017eeb5846f78e83b365048d680505683355dff1d71aae9c7f5caa0121::ryu {
    struct RYU has drop {
        dummy_field: bool,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
        total_aloc: u64,
    }

    struct MintCap has drop, store {
        minted_amount: u64,
        aloc_amount: u64,
    }

    struct AddCapEvent has copy, drop {
        role_id: address,
        aloc_amount: u64,
    }

    struct DestroyCapEvent has copy, drop {
        role_id: address,
    }

    struct RYUInfo has key {
        id: 0x2::object::UID,
        mint_cap: 0x2::coin::TreasuryCap<RYU>,
        max_supply: u64,
        minted_amount: u64,
        burned_amount: u64,
    }

    public entry fun burn(arg0: &mut RYUInfo, arg1: 0x2::coin::Coin<RYU>) {
        arg0.burned_amount = arg0.burned_amount + 0x2::coin::burn<RYU>(&mut arg0.mint_cap, arg1);
    }

    fun mint(arg0: &mut RYUInfo, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<RYU> {
        assert!((arg0.max_supply as u128) >= (arg1 as u128) + (arg0.minted_amount as u128), 1116);
        arg0.minted_amount = arg1 + arg0.minted_amount;
        0x2::coin::mint<RYU>(&mut arg0.mint_cap, arg1, arg2)
    }

    public fun add_role_aloc(arg0: &mut AdminCap, arg1: u64, arg2: &mut MintCap) {
        arg0.total_aloc = arg0.total_aloc + arg1;
        arg2.aloc_amount = arg2.aloc_amount + arg1;
    }

    public fun destory_role(arg0: &mut AdminCap, arg1: &mut MintCap, arg2: &mut 0x2::object::UID) {
        arg1.aloc_amount = arg1.minted_amount;
        arg0.total_aloc = arg0.total_aloc - arg1.aloc_amount - arg1.minted_amount;
        let v0 = DestroyCapEvent{role_id: 0x2::object::uid_to_address(arg2)};
        0x2::event::emit<DestroyCapEvent>(v0);
    }

    public fun get_burned_amount(arg0: &RYUInfo) : u64 {
        arg0.burned_amount
    }

    public fun get_circulation_amount(arg0: &RYUInfo) : u64 {
        0x2::coin::total_supply<RYU>(&arg0.mint_cap)
    }

    public fun get_max_supply(arg0: &RYUInfo) : u64 {
        arg0.max_supply
    }

    public fun get_minted_amount(arg0: &RYUInfo) : u64 {
        arg0.minted_amount
    }

    fun init(arg0: RYU, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(v0 == @0x98aeaac9956b31410eb27c0205799e9b0a7f8929391d8fa5903406984382739c, 1111);
        let (v1, v2) = 0x2::coin::create_currency<RYU>(arg0, 8, b"RYU", b"RYU FINANCE COIN", b"RYU FINANCE COIN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ryu-logo.4everland.store/RYU.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RYU>>(v2);
        let v3 = RYUInfo{
            id            : 0x2::object::new(arg1),
            mint_cap      : v1,
            max_supply    : 10000000000000000,
            minted_amount : 0,
            burned_amount : 0,
        };
        let v4 = AdminCap{
            id         : 0x2::object::new(arg1),
            total_aloc : 0,
        };
        0x2::transfer::transfer<AdminCap>(v4, v0);
        0x2::transfer::share_object<RYUInfo>(v3);
    }

    public entry fun m_addr(arg0: &mut RYUInfo, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == @0x98aeaac9956b31410eb27c0205799e9b0a7f8929391d8fa5903406984382739c, 1111);
        0x2::transfer::public_transfer<0x2::coin::Coin<RYU>>(mint(arg0, arg1, arg3), arg2);
    }

    public fun m_coin(arg0: &mut RYUInfo, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<RYU> {
        assert!(0x2::tx_context::sender(arg2) == @0x98aeaac9956b31410eb27c0205799e9b0a7f8929391d8fa5903406984382739c, 1111);
        mint(arg0, arg1, arg2)
    }

    public fun mint_addr(arg0: &mut MintCap, arg1: &mut RYUInfo, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        arg0.minted_amount = arg0.minted_amount + arg2;
        assert!(arg0.aloc_amount >= arg0.minted_amount, 1117);
        0x2::transfer::public_transfer<0x2::coin::Coin<RYU>>(mint(arg1, arg2, arg4), arg3);
    }

    public fun mint_coin(arg0: &mut MintCap, arg1: &mut RYUInfo, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<RYU> {
        arg0.minted_amount = arg0.minted_amount + arg2;
        assert!(arg0.aloc_amount >= arg0.minted_amount, 1117);
        mint(arg1, arg2, arg3)
    }

    public fun set_new_role(arg0: &mut AdminCap, arg1: &mut 0x2::object::UID, arg2: u64) : MintCap {
        arg0.total_aloc = arg0.total_aloc + arg2;
        let v0 = AddCapEvent{
            role_id     : 0x2::object::uid_to_address(arg1),
            aloc_amount : arg2,
        };
        0x2::event::emit<AddCapEvent>(v0);
        MintCap{
            minted_amount : 0,
            aloc_amount   : arg2,
        }
    }

    // decompiled from Move bytecode v6
}

