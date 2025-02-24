module 0x549fd7ca5e45bf128d158b682399c9278254863b82a30ce78ac1be40b71922c4::dirtyjeeto {
    struct DIRTYJEETO has drop {
        dummy_field: bool,
    }

    fun init(arg0: DIRTYJEETO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/2M1JuYot3qZsCbFpBzn2BB7Eh3ws3a85xZsFjz6Hpump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<DIRTYJEETO>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"DirtyJeeto  ")))), trim_right(b"DirtyJeeto                      "), trim_right(x"446f6e742062652061202444697274794a6565746f2120496e73746561642076696265207769746820757320616e6420486f644c20796f75722062616721200a0a24434f4b452028364d204d4329204445562026205465616d206f6e2074686973206f6e652e20436f6d6520696e746f2074686520564320616e64207361792068656c6c6f2e202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DIRTYJEETO>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DIRTYJEETO>>(v4);
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

