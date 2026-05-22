module 0x13388a74849c3d7d799e888cc9687802c2a4fff68f203f8affb06fc9e390ec57::aix {
    struct AIX has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<AIX>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<AIX>>(0x2::coin::mint<AIX>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: AIX, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://cdn.dexscreener.com/cms/images/965ef2130f798105516cd06af00756b872d7f2e287e67ccea7ab825dfdab1288?width=128&height=128&fit=crop&quality=95&format=auto                                                                                                                                                                    ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<AIX>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"AIX     ")))), trim_right(b"Ai Xovia                        "), trim_right(b"AI XOVIA is an autonomous, hybrid intelligence project designed to address fundamental problems in financial markets, such as inefficiencies, information asymmetry, and manipulative actions.                                                                                                                                  "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AIX>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<AIX>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<AIX>>(0x2::coin::mint<AIX>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

