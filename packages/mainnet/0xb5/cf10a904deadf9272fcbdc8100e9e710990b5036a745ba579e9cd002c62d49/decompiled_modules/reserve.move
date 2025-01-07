module 0xb5cf10a904deadf9272fcbdc8100e9e710990b5036a745ba579e9cd002c62d49::reserve {
    struct CoinKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    public(friend) fun borrow<T0>(arg0: &mut 0xb5cf10a904deadf9272fcbdc8100e9e710990b5036a745ba579e9cd002c62d49::trust::Trust, arg1: &0xb5cf10a904deadf9272fcbdc8100e9e710990b5036a745ba579e9cd002c62d49::trust::TrusteeCap) : 0x1::option::Option<0x2::balance::Balance<T0>> {
        let v0 = CoinKey<T0>{dummy_field: false};
        0xb5cf10a904deadf9272fcbdc8100e9e710990b5036a745ba579e9cd002c62d49::trust::borrow<CoinKey<T0>, 0x2::balance::Balance<T0>>(arg0, arg1, v0)
    }

    public fun deposit<T0>(arg0: &mut 0xb5cf10a904deadf9272fcbdc8100e9e710990b5036a745ba579e9cd002c62d49::trust::Trust, arg1: &0xb5cf10a904deadf9272fcbdc8100e9e710990b5036a745ba579e9cd002c62d49::trust::SettlorCap, arg2: 0x2::balance::Balance<T0>) {
        let v0 = withdraw<T0>(arg0, arg1);
        if (0x1::option::is_some<0x2::balance::Balance<T0>>(&v0)) {
            let v1 = 0x1::option::destroy_some<0x2::balance::Balance<T0>>(v0);
            0x2::balance::join<T0>(&mut v1, arg2);
            let v2 = CoinKey<T0>{dummy_field: false};
            0xb5cf10a904deadf9272fcbdc8100e9e710990b5036a745ba579e9cd002c62d49::trust::entrust<CoinKey<T0>, 0x2::balance::Balance<T0>>(arg0, arg1, v2, v1);
        } else {
            0x1::option::destroy_none<0x2::balance::Balance<T0>>(v0);
            let v3 = CoinKey<T0>{dummy_field: false};
            0xb5cf10a904deadf9272fcbdc8100e9e710990b5036a745ba579e9cd002c62d49::trust::entrust<CoinKey<T0>, 0x2::balance::Balance<T0>>(arg0, arg1, v3, arg2);
        };
    }

    public fun query<T0>(arg0: &0xb5cf10a904deadf9272fcbdc8100e9e710990b5036a745ba579e9cd002c62d49::trust::Trust) : u64 {
        let v0 = CoinKey<T0>{dummy_field: false};
        if (0xb5cf10a904deadf9272fcbdc8100e9e710990b5036a745ba579e9cd002c62d49::trust::exists_<CoinKey<T0>>(arg0, v0)) {
            let v1 = CoinKey<T0>{dummy_field: false};
            return 0x2::balance::value<T0>(0xb5cf10a904deadf9272fcbdc8100e9e710990b5036a745ba579e9cd002c62d49::trust::query<CoinKey<T0>, 0x2::balance::Balance<T0>>(arg0, v1))
        };
        0
    }

    public fun repay<T0>(arg0: &mut 0xb5cf10a904deadf9272fcbdc8100e9e710990b5036a745ba579e9cd002c62d49::trust::Trust, arg1: &0xb5cf10a904deadf9272fcbdc8100e9e710990b5036a745ba579e9cd002c62d49::trust::TrusteeCap, arg2: 0x2::balance::Balance<T0>) {
        let v0 = borrow<T0>(arg0, arg1);
        if (0x1::option::is_some<0x2::balance::Balance<T0>>(&v0)) {
            let v1 = 0x1::option::destroy_some<0x2::balance::Balance<T0>>(v0);
            0x2::balance::join<T0>(&mut v1, arg2);
            let v2 = CoinKey<T0>{dummy_field: false};
            0xb5cf10a904deadf9272fcbdc8100e9e710990b5036a745ba579e9cd002c62d49::trust::repay<CoinKey<T0>, 0x2::balance::Balance<T0>>(arg0, arg1, v2, v1);
        } else {
            0x1::option::destroy_none<0x2::balance::Balance<T0>>(v0);
            let v3 = CoinKey<T0>{dummy_field: false};
            0xb5cf10a904deadf9272fcbdc8100e9e710990b5036a745ba579e9cd002c62d49::trust::repay<CoinKey<T0>, 0x2::balance::Balance<T0>>(arg0, arg1, v3, arg2);
        };
    }

    public fun withdraw<T0>(arg0: &mut 0xb5cf10a904deadf9272fcbdc8100e9e710990b5036a745ba579e9cd002c62d49::trust::Trust, arg1: &0xb5cf10a904deadf9272fcbdc8100e9e710990b5036a745ba579e9cd002c62d49::trust::SettlorCap) : 0x1::option::Option<0x2::balance::Balance<T0>> {
        let v0 = CoinKey<T0>{dummy_field: false};
        0xb5cf10a904deadf9272fcbdc8100e9e710990b5036a745ba579e9cd002c62d49::trust::withdraw<CoinKey<T0>, 0x2::balance::Balance<T0>>(arg0, arg1, v0)
    }

    public entry fun withdraw_entry<T0>(arg0: &mut 0xb5cf10a904deadf9272fcbdc8100e9e710990b5036a745ba579e9cd002c62d49::trust::Trust, arg1: &0xb5cf10a904deadf9272fcbdc8100e9e710990b5036a745ba579e9cd002c62d49::trust::SettlorCap, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = withdraw<T0>(arg0, arg1);
        if (0x1::option::is_some<0x2::balance::Balance<T0>>(&v0)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x1::option::destroy_some<0x2::balance::Balance<T0>>(v0), arg2), 0x2::tx_context::sender(arg2));
        } else {
            0x1::option::destroy_none<0x2::balance::Balance<T0>>(v0);
        };
    }

    // decompiled from Move bytecode v6
}

