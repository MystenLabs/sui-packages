module 0x44ddc3da951cff69b5eb1f0d70711480dcc86a3851ccb965c91438afb90ae33f::pcat {
    struct PCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: PCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PCAT>(arg0, 9, b"PCAT", b"PERSIAN CAT", b"PERSIAN CAT COIN ($PCAT) is a crypto token with a maximum supply of 10,000,000,000. This token is designed to provide a unique investment experience with an interesting theme. As a decentralized token, $PCAT aims to become part of a growing blockchain ecosystem, providing opportunities for its holders to engage in various activities and uses of the token in the future.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://7u5ytwpguxvdykekdckyf4wbmr2k7pf23v26e2dcw4kp7rkxodpq.arweave.net/_TuJ2eal6jwoihiVgvLBZHSvvLrddeJoYrcU_8VXcN8")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PCAT>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PCAT>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

