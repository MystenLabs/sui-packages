module 0x5fec0b33367b47a1610dd3342d344abca572e6d90318661c7105224f27f6dd1b::pcat {
    struct PCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: PCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PCAT>(arg0, 5, b"PCAT", b"PERSIAN CAT", b"PERSIAN CAT COIN ($PCAT) is a crypto token with a maximum supply of 100,000,000,000,000 This token is designed to provide a unique investment experience with an interesting theme. As a decentralized token, $PCAT aims to become part of a growing blockchain ecosystem, providing opportunities for its holders to engage in various activities and uses of the token in the future.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://xiy4exeeo6gp23hnywzzzqu5u5h7q3fvcvdtv76r4jz4qsu5k4hq.arweave.net/ujHCXIR3jP1s7cWznMKdp0_4bLUVRzr_0eJzyEqdVw8")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PCAT>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PCAT>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

