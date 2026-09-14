module 0xe93900a63b0a559d2d64d3444d33fedc8663073eb641bcee7dd137dbe2a0d016::uhad {
    struct UHAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: UHAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<UHAD>(arg0, 9, b"UHAD", b"UHAD ", b"https://gateway.pinata.cloud/ipfs/QmPAcxfNr9r1DVWUMVQyeRG8ec9Ybpa7TskrTppzGFvKse", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gateway.pinata.cloud/ipfs/QmRugTGrrUhVsweUWqtJzu25Wc1yCXQ8eCAjd7YwPdFTXg")), true, arg1);
        let v3 = v0;
        let v4 = 0x2::tx_context::sender(arg1);
        0x2::coin::mint_and_transfer<UHAD>(&mut v3, 10000000000000000, v4, arg1);
        if (111 == 111) {
            0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<UHAD>>(v2);
        } else {
            0x2::transfer::public_transfer<0x2::coin::CoinMetadata<UHAD>>(v2, v4);
        };
        if (110 == 110) {
            0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UHAD>>(v3, @0x0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UHAD>>(v3, v4);
        };
        if (112 == 112) {
            0x2::transfer::public_transfer<0x2::coin::DenyCapV2<UHAD>>(v1, @0x0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::DenyCapV2<UHAD>>(v1, v4);
        };
    }

    // decompiled from Move bytecode v6
}

