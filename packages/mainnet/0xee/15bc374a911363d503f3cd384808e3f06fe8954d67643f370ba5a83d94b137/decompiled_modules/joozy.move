module 0xee15bc374a911363d503f3cd384808e3f06fe8954d67643f370ba5a83d94b137::joozy {
    struct JOOZY has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<JOOZY>, arg1: 0x2::coin::Coin<JOOZY>) {
        0x2::coin::burn<JOOZY>(arg0, arg1);
    }

    fun mint_and_transfer(arg0: &mut 0x2::coin::TreasuryCap<JOOZY>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<JOOZY>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: JOOZY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://static.wixstatic.com/media/8d9f7b_9bc45d9dcd5047b582709c16cca7f6b1~mv2.png/v1/fill/w_298,h_650,al_c,q_85,usm_0.66_1.00_0.01,enc_avif,quality_auto/8d9f7b_9bc45d9dcd5047b582709c16cca7f6b1~mv2.png                                                                                                                       ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<JOOZY>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"JOOZY     ")))), trim_right(b"JOOZY AI                        "), trim_right(x"446563656e7472616c697a65642043656c65737469616c20446973636f76657279202620446f63756d656e746174696f6e0a4a2e412e54207574696c697a657320626c6f636b636861696e20746563686e6f6c6f677920746f20637265617465206120646563656e7472616c697a656420636174616c6f67206f6620617374726f6e6f6d6963616c20646174612e20457665727920696d6167652c206f62736572766174696f6e2c20616e6420646973636f76657279206d616465206279207468652074656c6573636f7065206973207365637572656c79207265636f72646564206f6e2d636861696e2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        let v5 = v3;
        let v6 = &mut v5;
        let v7 = 0x2::tx_context::sender(arg1);
        mint_and_transfer(v6, 1000000000000000000, v7, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JOOZY>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<JOOZY>>(v5);
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

