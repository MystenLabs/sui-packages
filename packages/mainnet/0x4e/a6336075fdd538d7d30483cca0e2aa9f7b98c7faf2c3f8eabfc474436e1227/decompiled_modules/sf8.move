module 0x4ea6336075fdd538d7d30483cca0e2aa9f7b98c7faf2c3f8eabfc474436e1227::sf8 {
    struct SF8 has drop {
        dummy_field: bool,
    }

    fun init(arg0: SF8, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/4kTW33szA3ezBbAtecJXiV6GUFs4uMwf5eWLVzsppump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<SF8>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"SF8         ")))), trim_right(b"Starship Flight 8 on X-TV       "), trim_right(b"Starship Flight 8 on X TV (SF8) is a digital asset inspired by SpaceXs eighth Starship test flight, set to be broadcast live on X TV. This coin commemorates a pivotal moment in space exploration, as Starship Ship 34 aims for suborbital success and Booster 15 attempts a precision catch by the launch towers chopstick arm"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SF8>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SF8>>(v4);
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

