module 0x9719a4c01d418f2e1059fda8be49fddd6ea564ec456887f2eb9a12e8e5725f84::test {
    struct TEST has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<TEST>(arg0, 9, 0x1::string::utf8(b"TEST"), 0x1::string::utf8(b"TEST"), 0x1::string::utf8(x"6c6f6e672e73756920504f43207465737420746f6b656e20e2809420666978656420737570706c79"), 0x1::string::utf8(b""), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<TEST>>(0x2::coin::mint<TEST>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::coin_registry::make_supply_fixed_init<TEST>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<TEST>(v3, arg1);
    }

    // decompiled from Move bytecode v7
}

