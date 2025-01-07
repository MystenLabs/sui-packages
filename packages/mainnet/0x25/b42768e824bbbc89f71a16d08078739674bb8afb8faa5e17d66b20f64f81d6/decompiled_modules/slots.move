module 0x68e211b3f6a1ebf59de853561156c6d7eb7f482b2f512fb5cb1e3d05d200b848::slots {
    struct Slots has copy, drop, store {
        dummy_field: bool,
    }

    struct SlotsAdminCap has store, key {
        id: 0x2::object::UID,
        original_id_cap: 0x2::object::ID,
    }

    public fun burn_admin_cap(arg0: SlotsAdminCap) {
        let SlotsAdminCap {
            id              : v0,
            original_id_cap : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun deposit<T0>(arg0: &mut 0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::Unihouse, arg1: 0x2::coin::Coin<T0>) {
        let v0 = Slots{dummy_field: false};
        0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::put_with_fee<T0, Slots>(arg0, v0, arg1);
    }

    public fun deposit_bal<T0>(arg0: &mut 0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::Unihouse, arg1: 0x2::balance::Balance<T0>) {
        let v0 = Slots{dummy_field: false};
        0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::join<T0, Slots>(arg0, v0, arg1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg0);
        let v1 = SlotsAdminCap{
            id              : v0,
            original_id_cap : 0x2::object::uid_to_inner(&v0),
        };
        0x2::transfer::transfer<SlotsAdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun mint_child_admin_cap(arg0: &SlotsAdminCap, arg1: &mut 0x2::tx_context::TxContext) : SlotsAdminCap {
        assert!(0x2::object::uid_to_inner(&arg0.id) == arg0.original_id_cap, 0);
        SlotsAdminCap{
            id              : 0x2::object::new(arg1),
            original_id_cap : 0x2::object::uid_to_inner(&arg0.id),
        }
    }

    public fun withdraw_funds<T0>(arg0: &SlotsAdminCap, arg1: &mut 0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::Unihouse, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = Slots{dummy_field: false};
        0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::take_with_fee_reimbursement<T0, Slots>(arg1, v0, arg2, arg3)
    }

    // decompiled from Move bytecode v6
}

