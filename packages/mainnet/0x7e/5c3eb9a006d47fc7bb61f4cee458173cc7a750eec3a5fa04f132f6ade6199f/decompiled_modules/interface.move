module 0x7e5c3eb9a006d47fc7bb61f4cee458173cc7a750eec3a5fa04f132f6ade6199f::interface {
    struct ObligationCollateral has copy, drop {
        collateral: u64,
        type_name: 0x1::type_name::TypeName,
    }

    struct ObligationDebt has copy, drop {
        debt: u64,
        borrow_index: u64,
        type_name: 0x1::type_name::TypeName,
    }

    public fun obligation_afsui_collateral(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation) {
        obligation_collateral<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>(arg0);
    }

    public fun obligation_collateral<T0>(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation) {
        let v0 = 0x1::type_name::get<T0>();
        let v1 = ObligationCollateral{
            collateral : 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::collateral(arg0, v0),
            type_name  : v0,
        };
        0x2::event::emit<ObligationCollateral>(v1);
    }

    public fun obligation_debt<T0>(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation) {
        let v0 = 0x1::type_name::get<T0>();
        let (v1, v2) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::debt(arg0, v0);
        let v3 = ObligationDebt{
            debt         : v1,
            borrow_index : v2,
            type_name    : v0,
        };
        0x2::event::emit<ObligationDebt>(v3);
    }

    public fun obligation_sui_debt(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation) {
        obligation_debt<0x2::sui::SUI>(arg0);
    }

    // decompiled from Move bytecode v6
}

