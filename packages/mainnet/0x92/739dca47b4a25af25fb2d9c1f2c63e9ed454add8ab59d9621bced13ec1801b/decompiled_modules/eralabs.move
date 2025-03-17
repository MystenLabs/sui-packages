module 0x92739dca47b4a25af25fb2d9c1f2c63e9ed454add8ab59d9621bced13ec1801b::eralabs {
    struct ERALABS has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<ERALABS>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<ERALABS>>(0x2::coin::mint<ERALABS>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: ERALABS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/bsc/0x1d8351a3f77ac875943772d485eef6bf6550316b.png?size=lg&key=93149a                                                                                                                                                                                                                 ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<ERALABS>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"EraLabs ")))), trim_right(b"EraLabs                         "), trim_right(b"EraLabs fuses AI with Sui's speed, delivering cutting-edge tools like EraChat, EraMixer, and EraSearch for an unparalleled crypto experience.                                                                                                                                                                                   "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ERALABS>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<ERALABS>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<ERALABS>>(0x2::coin::mint<ERALABS>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

