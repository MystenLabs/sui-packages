module 0x3a5e80991128370625299a506533cee3a4610fdef5768bfcea01672aebc089a2::lama {
    struct LAMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: LAMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LAMA>(arg0, 6, b"LAMA", b"SuiLama", x"5355c4b0204f4e206c616d61", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://x.com/suirex_/photo")), arg1);
        0x2::transfer::public_transfer<0x931cc23b9c6fd3e6f8b5ef68955a2bf83ab36a7d8c995334afe3616f5fd586c7::connector::Connector<LAMA>>(0x931cc23b9c6fd3e6f8b5ef68955a2bf83ab36a7d8c995334afe3616f5fd586c7::connector::new<LAMA>(v0, v1, 0x2::tx_context::sender(arg1), arg1), @0xaf50f089101e7b4650b028d1567aaeb80b42867143cda135a06bf2f4e95815aa);
    }

    // decompiled from Move bytecode v6
}

