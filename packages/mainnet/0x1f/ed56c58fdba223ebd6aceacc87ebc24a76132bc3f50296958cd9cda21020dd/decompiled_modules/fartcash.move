module 0x1fed56c58fdba223ebd6aceacc87ebc24a76132bc3f50296958cd9cda21020dd::fartcash {
    struct FARTCASH has drop {
        dummy_field: bool,
    }

    fun init(arg0: FARTCASH, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/EJUbsyWDuJvnHSWQYXMnqcqD4XefA9WM4ftjZtSmpump.png?claimId=Aho-zXlBwB6MX079                                                                                                                                                                                                      ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<FARTCASH>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"fartcash    ")))), trim_right(b"fartcoin cash                   "), trim_right(x"576520776f756c64206c6f766520746f2067697665207468652066696e67657220746f2074686520776f726c6420616e6420686176652066617274636f696e206361736820686f6c6465727320737461727420627579696e6720686f7573657320776974682066617274636173682e0a0a23626974636f696e203d202366617274636f696e0a23626974636f696e63617368203d20236661727463617368202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FARTCASH>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FARTCASH>>(v4);
    }

    fun trim_right(arg0: vector<u8>) : vector<u8> {
        let v0 = 32;
        let v1 = &v0;
        while (0x1::vector::length<u8>(&arg0) > 0) {
            if (0x1::vector::borrow<u8>(&arg0, 0x1::vector::length<u8>(&arg0) - 1) != v1) {
                break
            };
            0x1::vector::pop_back<u8>(&mut arg0);
        };
        arg0
    }

    // decompiled from Move bytecode v6
}

