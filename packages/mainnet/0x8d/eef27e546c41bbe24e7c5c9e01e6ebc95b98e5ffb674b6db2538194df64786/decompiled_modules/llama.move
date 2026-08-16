module 0xdc66338d84e3d73e8c245fa7b7f551a8100c073161e35fc81990a011afed7280::llama {
    struct LLAMA has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct MinterCap has store, key {
        id: 0x2::object::UID,
    }

    struct MintController has key {
        id: 0x2::object::UID,
        cap: 0x2::coin::TreasuryCap<LLAMA>,
        minted: u64,
        max_supply: u64,
    }

    struct Minted has copy, drop {
        amount: u64,
        total_minted: u64,
        remaining: u64,
    }

    struct Burned has copy, drop {
        amount: u64,
        total_minted: u64,
    }

    struct MaxSupplyLowered has copy, drop {
        old_max: u64,
        new_max: u64,
    }

    struct MinterCapIssued has copy, drop {
        cap: 0x2::object::ID,
    }

    public fun burn(arg0: &mut MintController, arg1: 0x2::coin::Coin<LLAMA>) {
        let v0 = 0x2::coin::value<LLAMA>(&arg1);
        assert!(v0 > 0, 1);
        arg0.minted = arg0.minted - v0;
        0x2::coin::burn<LLAMA>(&mut arg0.cap, arg1);
        let v1 = Burned{
            amount       : v0,
            total_minted : arg0.minted,
        };
        0x2::event::emit<Burned>(v1);
    }

    public fun mint(arg0: &mut MintController, arg1: &MinterCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<LLAMA> {
        assert!(arg2 > 0, 1);
        assert!(arg0.minted + arg2 <= arg0.max_supply, 0);
        arg0.minted = arg0.minted + arg2;
        let v0 = Minted{
            amount       : arg2,
            total_minted : arg0.minted,
            remaining    : arg0.max_supply - arg0.minted,
        };
        0x2::event::emit<Minted>(v0);
        0x2::coin::mint<LLAMA>(&mut arg0.cap, arg2, arg3)
    }

    public fun claim_metadata_cap(arg0: &AdminCap, arg1: &MintController, arg2: &mut 0x2::coin_registry::Currency<LLAMA>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin_registry::MetadataCap<LLAMA> {
        0x2::coin_registry::claim_metadata_cap<LLAMA>(arg2, &arg1.cap, arg3)
    }

    fun init(arg0: LLAMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LLAMA>(arg0, 9, b"LLAMA", b"Llamabet", b"Revenue-share token for the Llamabet provably-fair casino on Sui.", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LLAMA>>(v1);
        let v2 = MintController{
            id         : 0x2::object::new(arg1),
            cap        : v0,
            minted     : 0,
            max_supply : 100000000000000000,
        };
        0x2::transfer::share_object<MintController>(v2);
        let v3 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v3, 0x2::tx_context::sender(arg1));
    }

    public fun issue_minter(arg0: &AdminCap, arg1: &mut 0x2::tx_context::TxContext) : MinterCap {
        let v0 = MinterCap{id: 0x2::object::new(arg1)};
        let v1 = MinterCapIssued{cap: 0x2::object::id<MinterCap>(&v0)};
        0x2::event::emit<MinterCapIssued>(v1);
        v0
    }

    public fun lower_max_supply(arg0: &AdminCap, arg1: &mut MintController, arg2: u64) {
        assert!(arg2 < arg1.max_supply, 2);
        assert!(arg2 >= arg1.minted, 2);
        arg1.max_supply = arg2;
        let v0 = MaxSupplyLowered{
            old_max : arg1.max_supply,
            new_max : arg2,
        };
        0x2::event::emit<MaxSupplyLowered>(v0);
    }

    public fun max_supply(arg0: &MintController) : u64 {
        arg0.max_supply
    }

    public fun minted(arg0: &MintController) : u64 {
        arg0.minted
    }

    public fun remaining(arg0: &MintController) : u64 {
        arg0.max_supply - arg0.minted
    }

    public fun revoke_minter(arg0: MinterCap) {
        let MinterCap { id: v0 } = arg0;
        0x2::object::delete(v0);
    }

    // decompiled from Move bytecode v7
}

