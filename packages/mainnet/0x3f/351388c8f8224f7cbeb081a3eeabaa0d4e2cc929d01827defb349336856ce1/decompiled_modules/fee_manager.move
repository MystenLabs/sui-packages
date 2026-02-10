module 0x3f351388c8f8224f7cbeb081a3eeabaa0d4e2cc929d01827defb349336856ce1::fee_manager {
    struct FeeManager<phantom T0> has store, key {
        id: 0x2::object::UID,
        protocol_fees: 0x2::balance::Balance<T0>,
    }

    public(friend) fun fee_amount(arg0: u64, arg1: u64) : u64 {
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::math::mul(arg0, arg1)
    }

    public(friend) fun new_fee_manager<T0>(arg0: &mut 0x2::tx_context::TxContext) : FeeManager<T0> {
        FeeManager<T0>{
            id            : 0x2::object::new(arg0),
            protocol_fees : 0x2::balance::zero<T0>(),
        }
    }

    public(friend) fun take_fee<T0>(arg0: &mut FeeManager<T0>, arg1: &mut 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = fee_amount(0x2::coin::value<T0>(arg1), arg2);
        0x2::balance::join<T0>(&mut arg0.protocol_fees, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(arg1, v0, arg3)));
        v0
    }

    public(friend) fun withdraw_protocol_fees<T0>(arg0: &mut FeeManager<T0>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg0.protocol_fees), arg1)
    }

    // decompiled from Move bytecode v6
}

