module 0x62f8727abe0ec229205aa8c7e6b774acdf62f95b2b10050791ba6b8460a84403::nobullies {
    struct NOBULLIES has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOBULLIES, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"3aab154a67ce60d39e488aa4ce49f9b36e72966bb5671dded27c9f8e855ff0de                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<NOBULLIES>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"NOBULLIES   ")))), trim_right(b"No Bully                        "), trim_right(b"No bully token($NOBULLIES) represents strength. A anti-bully coin that stands against bullies across the world. Cyber bullying to physical bullying is not allowed. The beauty behind this project is that it resignates with anyone who ever felt bullied or a friend/loved one lost their life from being bullied.            "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOBULLIES>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NOBULLIES>>(v4);
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

