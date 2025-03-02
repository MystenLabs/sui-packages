module 0x70f8fd7aa9af9a00c0a690c588877194f0001e0e4088a14da835a857ff234205::bogey {
    struct BOGEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOGEY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/4yCcLXswoYbicYLZDpTaGQWcPNUy2yNwu1MhPXNbY52u.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<BOGEY>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"BOGEY       ")))), trim_right(b"Bogey The Bandit                "), trim_right(x"20424f474559205448452042414e4449542020544845204649525354204d454d4520434f494e204f4e2053504f5449465920262053545245414d494e4720504c4154464f524d5321200a0a424f474559205448452042414e4449542069736e74206a7573742061206d656d6520636f696e697473207468652066697273742063727970746f2070726f6a65637420746f2074616b65206f76657220626f746820746865206d757369632063686172747320616e642074686520626c6f636b636861696e2120576974682066756c6c20616c62756d732073747265616d696e67206f6e2053706f746966792c204170706c65204d757369632c20596f7554756265204d757369632c20616e6420416d617a6f6e204d757369632c20426f676579206973206c656164696e672061206d6f76656d656e74207468617420626c656e64"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOGEY>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOGEY>>(v4);
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

