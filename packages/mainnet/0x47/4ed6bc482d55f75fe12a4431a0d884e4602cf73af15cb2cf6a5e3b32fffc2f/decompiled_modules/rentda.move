module 0x474ed6bc482d55f75fe12a4431a0d884e4602cf73af15cb2cf6a5e3b32fffc2f::rentda {
    struct RENTDA has drop {
        dummy_field: bool,
    }

    fun init(arg0: RENTDA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/3a6rkkd3BcFUzYkLCPN6EsSUYG2KbG1uq3Jadr8Fpump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<RENTDA>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"RENTD       ")))), trim_right(b"RentDue                         "), trim_right(x"52656e74447565202852454e544429200a426f726e2066726f6d2052616e64792074686520526163636f6f6e73207374727567676c6520746f207061792072656e742074726164696e67206d656d6520636f696e732066726f6d206869732064757374792076616e20202069742077617320616c6c2062696c6c73202c206e6f6f646c6573202c20616e6420736c6565706c657373206e696768747320756e74696c2074686520466c6f7754726164652066616d206261636b65642068696d20757020204e6f772052616e647973207a617070696e67206869732077617920746f2066726565646f6d2c206f6e65206d656d6520617420612074696d6521202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RENTDA>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RENTDA>>(v4);
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

