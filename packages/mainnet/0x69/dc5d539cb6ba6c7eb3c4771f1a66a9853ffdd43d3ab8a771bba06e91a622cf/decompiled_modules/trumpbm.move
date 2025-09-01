module 0x69dc5d539cb6ba6c7eb3c4771f1a66a9853ffdd43d3ab8a771bba06e91a622cf::trumpbm {
    struct TRUMPBM has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMPBM, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/RUSTLETZCgUSw1V7GmaKAk2RTXbFPH4eXAYjzKnpbDB.png?claimId=GPjH1LI4chmm7csZ                                                                                                                                                                                                       ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<TRUMPBM>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"TRUMPBM     ")))), trim_right(b"Trump's Big Macs                "), trim_right(x"205452554d50424d20205472756d707320426967204d616373200a0a546865206d656d6520636f696e207769746820737570657273697a65642073656375726974792e0a0a5452554d50424d206973206865726520746f2070726f76652074686174206e6f7420616c6c206d656d6520636f696e732061726520736d616c6c2066726965732e20383525206f662074686520737570706c79206973206c6f636b656420696e736964652074776f206d61737369766520426967204d616320627562626c6573206f6e20427562626c654d6170732e204a757374206c696b65205472756d7020737461636b696e6720426967204d61637320736b7920686967682c20746865736520627562626c6573206172652061206d6f6e756d656e7420746f2073746162696c6974792e0a0a54686174206d65616e733a0a205275672d7072"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMPBM>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRUMPBM>>(v4);
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

