module 0xa8731fa812f39c631151fda4fb1020ce959247a8dfe1ae1f8491d8b3f03978e6::phi {
    struct PHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PHI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/AEY2YBqD4NAY7eM76iUxFrc9vhDWS14AoULJCDS8pump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<PHI>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"PHI         ")))), trim_right(b"Pepehini                        "), trim_right(x"496e74726f647563696e67205065706568696e69202041204c6f6e672d5465726d204d656d65636f696e20627920536f6c616e61636172730a0a536f6c616e616361727320697320612067726f7570206f6620636c6f736520667269656e647320626173656420696e20416d7374657264616d2c20746865204e65746865726c616e64732c20756e69746564206279206f75722070617373696f6e20666f722063727970746f2e200a4d6f7374206f662075732068617665206265656e2061637469766520696e207468652063727970746f20737061636520666f72207365766572616c2079656172732c2077697468206f7572206c65616420646576656c6f70657220646976696e6720696e206173206561726c7920617320323031372e0a0a496e697469616c6c792c207765207765726520736b6570746963616c206f66"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PHI>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PHI>>(v4);
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

