module 0x8686b9667821db83a232193c61650d45f2495d23e6b97a9d33cb5286e81a7758::btc {
    struct BTC has drop {
        dummy_field: bool,
    }

    struct Info has key {
        id: 0x2::object::UID,
        mint_cap: 0x2::coin::TreasuryCap<BTC>,
        max_supply: u64,
        minted_amount: u64,
        burned_amount: u64,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
        total_aloc: u64,
    }

    struct MintRole has drop, store {
        minted_amount: u64,
        total_aloc_amount: u64,
    }

    struct AddRoleEvent has copy, drop {
        role_id: address,
        aloc_amount: u64,
    }

    struct DesRoleEvent has copy, drop {
        role_id: address,
    }

    public entry fun burn(arg0: &mut Info, arg1: 0x2::coin::Coin<BTC>) {
        arg0.burned_amount = arg0.burned_amount + 0x2::coin::burn<BTC>(&mut arg0.mint_cap, arg1);
    }

    fun mint(arg0: &mut Info, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<BTC> {
        assert!((arg0.max_supply as u128) > (arg1 as u128) + (arg0.minted_amount as u128), 1116);
        arg0.minted_amount = arg1 + arg0.minted_amount;
        0x2::coin::mint<BTC>(&mut arg0.mint_cap, arg1, arg2)
    }

    public entry fun admin_m2addr(arg0: &mut Info, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == @0x3ec31c14f6739ff7da81c7f10912cbdea340319c95b30cd52b55e8e697655472, 1111);
        0x2::transfer::public_transfer<0x2::coin::Coin<BTC>>(mint(arg0, arg1, arg3), arg2);
    }

    public fun get_burned_amount(arg0: &Info) : u64 {
        arg0.burned_amount
    }

    public fun get_circulation_amount(arg0: &Info) : u64 {
        0x2::coin::total_supply<BTC>(&arg0.mint_cap)
    }

    public fun get_max_supply(arg0: &Info) : u64 {
        arg0.max_supply
    }

    public fun get_minted_amount(arg0: &Info) : u64 {
        arg0.minted_amount
    }

    fun init(arg0: BTC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BTC>(arg0, 8, b"BTC", b"BTC", b"BTC", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BTC>>(v1);
        let v2 = Info{
            id            : 0x2::object::new(arg1),
            mint_cap      : v0,
            max_supply    : 10000000000000000,
            minted_amount : 0,
            burned_amount : 0,
        };
        let v3 = AdminCap{
            id         : 0x2::object::new(arg1),
            total_aloc : 0,
        };
        0x2::transfer::transfer<AdminCap>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::share_object<Info>(v2);
    }

    public entry fun m2addr(arg0: &mut Info, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<BTC>>(mint(arg0, 10000, arg2), arg1);
    }

    public fun mint2addr(arg0: &mut MintRole, arg1: &mut Info, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        arg0.minted_amount = arg0.minted_amount + arg2;
        assert!(arg0.total_aloc_amount >= arg0.minted_amount, 1117);
        0x2::transfer::public_transfer<0x2::coin::Coin<BTC>>(mint(arg1, arg2, arg4), arg3);
    }

    public fun mint_coin(arg0: &mut MintRole, arg1: &mut Info, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<BTC> {
        arg0.minted_amount = arg0.minted_amount + arg2;
        assert!(arg0.total_aloc_amount >= arg0.minted_amount, 1117);
        mint(arg1, arg2, arg3)
    }

    // decompiled from Move bytecode v6
}

