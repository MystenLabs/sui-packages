module 0x2cbef705f9f831ee028f10ddb66b5a1b551c2d69fb4b6e0a51048f753e5adb59::kier {
    struct KIER has drop {
        dummy_field: bool,
    }

    fun init(arg0: KIER, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/4afVnFuAVLMFeHujzy34uhMjNxAko2jbsyspZvFcpump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<KIER>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"KIER        ")))), trim_right(b"KIER COIN                       "), trim_right(x"496e74726f647563696e67204b494552434f494e202d20746865206f6e6c792063727970746f63757272656e6379206261636b65642062792074686520766973696f6e6172792067656e697573206f66204b69657220456167656e2e0a0a544845204e494e4520434f5245205052494e4349504c4553204f46204b494552434f494e0a0a312e2042656c69656620696e2074686520686f6c696e657373206f66204b494552434f494e20697320697473206f776e207265776172642e0a322e204e65766572207175657374696f6e206d61726b657420666c756374756174696f6e732e2054686520426f617264206b6e6f777320626573742e0a332e20596f75722077616c6c6574206973206e6f7420796f7572206f776e2e0a342e52656d656d6265722074686520706f776572206f662073696c656e6365207768656e206f"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KIER>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KIER>>(v4);
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

