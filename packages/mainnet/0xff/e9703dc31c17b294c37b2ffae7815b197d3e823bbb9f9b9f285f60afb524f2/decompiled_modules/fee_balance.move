module 0xffe9703dc31c17b294c37b2ffae7815b197d3e823bbb9f9b9f285f60afb524f2::fee_balance {
    struct Witness has drop {
        dummy_field: bool,
    }

    struct FeeBalance<phantom T0> has store {
        balance: 0x2::balance::Balance<T0>,
        beneficiary: address,
    }

    struct FeeBalanceDfKey has copy, drop, store {
        dummy_field: bool,
    }

    public fun distribute_fee_to_intermediary<T0, T1>(arg0: &mut 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::transfer_request::TransferRequest<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = FeeBalanceDfKey{dummy_field: false};
        let v1 = 0x2::dynamic_field::remove_if_exists<FeeBalanceDfKey, FeeBalance<T1>>(0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::transfer_request::metadata_mut<T0>(arg0), v0);
        if (0x1::option::is_none<FeeBalance<T1>>(&v1)) {
            0x1::option::destroy_none<FeeBalance<T1>>(v1);
            return
        };
        let FeeBalance {
            balance     : v2,
            beneficiary : v3,
        } = 0x1::option::extract<FeeBalance<T1>>(&mut v1);
        let v4 = v2;
        if (0x2::balance::value<T1>(&v4) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v4, arg1), v3);
        } else {
            0x2::balance::destroy_zero<T1>(v4);
        };
        0x1::option::destroy_none<FeeBalance<T1>>(v1);
    }

    public fun has_fees<T0>(arg0: &0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::transfer_request::TransferRequest<T0>) : bool {
        let v0 = FeeBalanceDfKey{dummy_field: false};
        0x2::dynamic_field::exists_<FeeBalanceDfKey>(0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::transfer_request::metadata<T0>(arg0), v0)
    }

    public fun paid_in_fees<T0, T1>(arg0: &0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::transfer_request::TransferRequest<T0>) : (&0x2::balance::Balance<T1>, address) {
        let v0 = FeeBalanceDfKey{dummy_field: false};
        let v1 = 0x2::dynamic_field::borrow<FeeBalanceDfKey, FeeBalance<T1>>(0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::transfer_request::metadata<T0>(arg0), v0);
        (&v1.balance, v1.beneficiary)
    }

    public fun paid_in_fees_mut<T0, T1>(arg0: &mut 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::transfer_request::TransferRequest<T0>, arg1: &0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::transfer_request::BalanceAccessCap<T0>) : (&mut 0x2::balance::Balance<T1>, address) {
        let v0 = FeeBalanceDfKey{dummy_field: false};
        let v1 = 0x2::dynamic_field::borrow_mut<FeeBalanceDfKey, FeeBalance<T1>>(0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::transfer_request::metadata_mut<T0>(arg0), v0);
        (&mut v1.balance, v1.beneficiary)
    }

    public fun set_paid_fee<T0, T1>(arg0: &mut 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::transfer_request::TransferRequest<T0>, arg1: 0x2::balance::Balance<T1>, arg2: address) {
        let v0 = FeeBalanceDfKey{dummy_field: false};
        let v1 = FeeBalance<T1>{
            balance     : arg1,
            beneficiary : arg2,
        };
        0x2::dynamic_field::add<FeeBalanceDfKey, FeeBalance<T1>>(0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::transfer_request::metadata_mut<T0>(arg0), v0, v1);
    }

    // decompiled from Move bytecode v6
}

