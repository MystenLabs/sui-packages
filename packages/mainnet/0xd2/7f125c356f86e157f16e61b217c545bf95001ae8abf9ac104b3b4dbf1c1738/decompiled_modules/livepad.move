module 0xd27f125c356f86e157f16e61b217c545bf95001ae8abf9ac104b3b4dbf1c1738::livepad {
    struct LIVEPAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: LIVEPAD, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"5d7250df534428c8270344da7b08128122e69ef9723c359316daec98320c23e5                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<LIVEPAD>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"LivePad     ")))), trim_right(b"Launchpad                       "), trim_right(b"LivePad is a next generation launchpad on Solana that helps creators launch tokens and engage with their communities. Tokens start on Meteora DBC with bonding and migrate to Meteora for higher rewards. Creators earn 1.6 percent fees during bonding and 2.4 percent after migration. LivePad also offers AI tools for instan"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LIVEPAD>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LIVEPAD>>(v4);
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

