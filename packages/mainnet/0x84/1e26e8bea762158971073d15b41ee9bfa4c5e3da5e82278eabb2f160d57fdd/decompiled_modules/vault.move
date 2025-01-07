module 0x841e26e8bea762158971073d15b41ee9bfa4c5e3da5e82278eabb2f160d57fdd::vault {
    struct SIMPLE_VAULT has drop {
        dummy_field: bool,
    }

    struct Vault<phantom T0> has store, key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
        sheet: 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::Sheet<SIMPLE_VAULT, T0>,
    }

    public fun balance<T0>(arg0: &Vault<T0>) : &0x2::balance::Balance<T0> {
        &arg0.balance
    }

    public fun create<T0>(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = SIMPLE_VAULT{dummy_field: false};
        let v1 = Vault<T0>{
            id      : 0x2::object::new(arg0),
            balance : 0x2::balance::zero<T0>(),
            sheet   : 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::new<SIMPLE_VAULT, T0>(v0),
        };
        0x2::transfer::share_object<Vault<T0>>(v1);
    }

    public fun receive<T0, T1>(arg0: &mut Vault<T1>, arg1: 0x1::option::Option<0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::Loan<T0, SIMPLE_VAULT, T1>>) {
        if (0x1::option::is_some<0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::Loan<T0, SIMPLE_VAULT, T1>>(&arg1)) {
            let v0 = SIMPLE_VAULT{dummy_field: false};
            0x2::balance::join<T1>(&mut arg0.balance, 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::receive<T0, SIMPLE_VAULT, T1>(&mut arg0.sheet, 0x1::option::destroy_some<0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::Loan<T0, SIMPLE_VAULT, T1>>(arg1), v0));
        } else {
            0x1::option::destroy_none<0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::Loan<T0, SIMPLE_VAULT, T1>>(arg1);
        };
    }

    public fun sheet<T0>(arg0: &Vault<T0>) : &0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::Sheet<SIMPLE_VAULT, T0> {
        &arg0.sheet
    }

    public fun repay<T0, T1>(arg0: &mut Vault<T1>, arg1: &mut 0x1::option::Option<0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::Collector<T0, SIMPLE_VAULT, T1>>) {
        if (0x1::option::is_some<0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::Collector<T0, SIMPLE_VAULT, T1>>(arg1)) {
            let v0 = 0x1::option::borrow_mut<0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::Collector<T0, SIMPLE_VAULT, T1>>(arg1);
            let v1 = SIMPLE_VAULT{dummy_field: false};
            0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::repay<T0, SIMPLE_VAULT, T1>(&mut arg0.sheet, v0, 0x2::balance::split<T1>(&mut arg0.balance, 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::requirement<T0, SIMPLE_VAULT, T1>(v0)), v1);
        };
    }

    // decompiled from Move bytecode v6
}

