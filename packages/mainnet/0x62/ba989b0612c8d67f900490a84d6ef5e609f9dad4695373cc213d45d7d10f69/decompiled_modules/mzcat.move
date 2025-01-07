module 0x62ba989b0612c8d67f900490a84d6ef5e609f9dad4695373cc213d45d7d10f69::mzcat {
    struct MZCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: MZCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MZCAT>(arg0, 6, b"Mzcat", b"mzcatcoin", x"496c206d696f20616d69636f20c3a820756e20676174746f2c204920646f6e2774206b656570206e6567617469766520456e65726779210a0a4e6f205265706c793f2049276d20736f72727920697473206265656e206372617a79206f75742068657265", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731397931629.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MZCAT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MZCAT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

