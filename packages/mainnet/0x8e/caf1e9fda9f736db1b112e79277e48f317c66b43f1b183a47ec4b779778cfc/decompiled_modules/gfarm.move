module 0x8ecaf1e9fda9f736db1b112e79277e48f317c66b43f1b183a47ec4b779778cfc::gfarm {
    struct Farm<phantom T0> has key {
        id: 0x2::object::UID,
        treasury_cap: 0x2::coin::TreasuryCap<T0>,
        supply_limit: u64,
        fee: Fee,
        sheet: 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::Sheet<GFarm, 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>,
        positions: 0x2::vec_map::VecMap<0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::Creditor, 0x1::option::Option<0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::StakeProof<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>>>,
        rewards: 0x2::vec_map::VecMap<0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::Creditor, 0x2::balance::Balance<0x2::sui::SUI>>,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct GFarm has drop {
        dummy_field: bool,
    }

    struct Fee has store {
        deposit_fee_bps: u64,
        withdraw_fee_bps: u64,
    }

    public fun new<T0>(arg0: &AdminCap, arg1: 0x2::coin::TreasuryCap<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = Fee{
            deposit_fee_bps  : 0,
            withdraw_fee_bps : 0,
        };
        let v1 = Farm<T0>{
            id           : 0x2::object::new(arg3),
            treasury_cap : arg1,
            supply_limit : arg2,
            fee          : v0,
            sheet        : 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::new<GFarm, 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(stamp()),
            positions    : 0x2::vec_map::empty<0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::Creditor, 0x1::option::Option<0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::StakeProof<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>>>(),
            rewards      : 0x2::vec_map::empty<0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::Creditor, 0x2::balance::Balance<0x2::sui::SUI>>(),
        };
        0x2::transfer::share_object<Farm<T0>>(v1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun setFee<T0>(arg0: &mut Farm<T0>, arg1: &AdminCap, arg2: u64, arg3: u64) {
        arg0.fee.deposit_fee_bps = arg2;
        arg0.fee.withdraw_fee_bps = arg3;
    }

    fun stamp() : GFarm {
        GFarm{dummy_field: false}
    }

    public fun update_supply_limit<T0>(arg0: &mut Farm<T0>, arg1: &AdminCap, arg2: u64) {
        arg0.supply_limit = arg2;
    }

    // decompiled from Move bytecode v6
}

