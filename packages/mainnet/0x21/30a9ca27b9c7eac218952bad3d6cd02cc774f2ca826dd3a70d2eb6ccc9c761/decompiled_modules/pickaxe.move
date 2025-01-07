module 0x40eccc7f6302e74de80f905fe80d3caedd008209a3a503b567be02161248c13d::pickaxe {
    struct Pickaxe has store, key {
        id: 0x2::object::UID,
        tier: u8,
    }

    struct PickaxeStore has key {
        id: 0x2::object::UID,
        treasury: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    public fun base_price() : u64 {
        10
    }

    public fun buy(arg0: &mut PickaxeStore, arg1: u8, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) : Pickaxe {
        if (0x2::coin::value<0x2::sui::SUI>(&arg2) < (arg1 as u64) * base_price()) {
            err_payment_not_enough();
        };
        0x2::coin::put<0x2::sui::SUI>(&mut arg0.treasury, arg2);
        Pickaxe{
            id   : 0x2::object::new(arg3),
            tier : arg1,
        }
    }

    entry fun buy_and_transfer(arg0: &mut PickaxeStore, arg1: u8, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::transfer<Pickaxe>(buy(arg0, arg1, arg2, arg4), arg3);
    }

    public fun destroy(arg0: Pickaxe) : u8 {
        let Pickaxe {
            id   : v0,
            tier : v1,
        } = arg0;
        0x2::object::delete(v0);
        v1
    }

    fun err_payment_not_enough() {
        abort 0
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = PickaxeStore{
            id       : 0x2::object::new(arg0),
            treasury : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::transfer::share_object<PickaxeStore>(v0);
    }

    public fun tier(arg0: &Pickaxe) : u8 {
        arg0.tier
    }

    public fun withdraw(arg0: &mut PickaxeStore, arg1: &0xc00d69e58132d45903419bd1734cf0ce6b61352d9eedb241cfd2d0cad32e1de8::kapy_world::GodPower, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.treasury, arg2), arg3)
    }

    entry fun withdraw_to(arg0: &mut PickaxeStore, arg1: &0xc00d69e58132d45903419bd1734cf0ce6b61352d9eedb241cfd2d0cad32e1de8::kapy_world::GodPower, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(withdraw(arg0, arg1, arg2, arg4), arg3);
    }

    // decompiled from Move bytecode v6
}

