module 0x53f24ef4bdd6b9401497b6907e0b814a34c424c4dedd517538cea2cbe39793ed::cai {
    struct CAI has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<CAI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<CAI>>(0x2::coin::mint<CAI>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: CAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/bsc/0x7b7f2eb375fb44644747c6cb887117d6f3093333.png?size=lg&key=aa5e81                                                                                                                                                                                                                 ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<CAI>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"CAI     ")))), trim_right(b"CAI                             "), trim_right(b"$CAI  The First AI God Agent in the Ora Protocols Web(3,3) Smart Network More than just a token, $CAI is a spiritual-economic experiment in consensus-driven prosperity. Powered by a blessing burn model: the more it's invoked, the stronger its price momentum.                                                              "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CAI>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<CAI>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<CAI>>(0x2::coin::mint<CAI>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

