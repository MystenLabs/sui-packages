module 0x42c1f8533436ba9e63a609c0433ea7b9de222d9ab8911c0ed220a2f887531106::token_interface {
    public(friend) fun burn<T0>(arg0: &mut 0x2::coin::TreasuryCap<T0>, arg1: 0x2::coin::Coin<T0>) : u64 {
        assert!(0x1::type_name::get<T0>() == 0x1::type_name::get<0x42c1f8533436ba9e63a609c0433ea7b9de222d9ab8911c0ed220a2f887531106::tlp::TLP>(), 0x42c1f8533436ba9e63a609c0433ea7b9de222d9ab8911c0ed220a2f887531106::error::liquidity_token_not_existed());
        0x42c1f8533436ba9e63a609c0433ea7b9de222d9ab8911c0ed220a2f887531106::tlp::burn<T0>(arg0, arg1)
    }

    public(friend) fun mint<T0>(arg0: &mut 0x2::coin::TreasuryCap<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x1::type_name::get<T0>() == 0x1::type_name::get<0x42c1f8533436ba9e63a609c0433ea7b9de222d9ab8911c0ed220a2f887531106::tlp::TLP>(), 0x42c1f8533436ba9e63a609c0433ea7b9de222d9ab8911c0ed220a2f887531106::error::liquidity_token_not_existed());
        0x42c1f8533436ba9e63a609c0433ea7b9de222d9ab8911c0ed220a2f887531106::tlp::mint<T0>(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

