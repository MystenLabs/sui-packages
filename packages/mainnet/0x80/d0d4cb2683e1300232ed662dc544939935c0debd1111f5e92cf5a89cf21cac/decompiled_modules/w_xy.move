module 0x80d0d4cb2683e1300232ed662dc544939935c0debd1111f5e92cf5a89cf21cac::w_xy {
    struct W_XY has drop {
        dummy_field: bool,
    }

    public entry fun mint_and_transfer(arg0: &mut 0x2::coin::TreasuryCap<W_XY>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<W_XY>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: W_XY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<W_XY>(arg0, 9, b"FTST4", b"FinalTest4", b"TestWX", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://fastly.picsum.photos/id/457/200/200.jpg?hmac=joY8RjIQZTMCo8z_GiovGX8NznT0ZEznz7f1Xy0NQQg"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<W_XY>(&mut v2, 123456789000000000, @0x4e3803889934c26540965b8684454a380cecdae5984bdf0e111721a3785d57d2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<W_XY>>(v2, @0xa2a935b425497b6dbc81a5281071a00713f308d902c4900154edd005012dbd2);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<W_XY>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun revoke_metadata(arg0: 0x2::coin::CoinMetadata<W_XY>) {
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<W_XY>>(arg0);
    }

    public entry fun revoke_treasury(arg0: 0x2::coin::TreasuryCap<W_XY>) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<W_XY>>(arg0);
    }

    public entry fun update_metadata(arg0: &0x2::coin::TreasuryCap<W_XY>, arg1: &mut 0x2::coin::CoinMetadata<W_XY>, arg2: 0x1::string::String, arg3: 0x1::ascii::String, arg4: 0x1::string::String, arg5: 0x1::ascii::String) {
        0x2::coin::update_name<W_XY>(arg0, arg1, arg2);
        0x2::coin::update_symbol<W_XY>(arg0, arg1, arg3);
        0x2::coin::update_description<W_XY>(arg0, arg1, arg4);
        0x2::coin::update_icon_url<W_XY>(arg0, arg1, arg5);
    }

    // decompiled from Move bytecode v6
}

