module 0x7392efcbbe15907d8cf6c8a27cef0a2381d2b716ef84e22ada6e838e04dffd81::tapybaraa {
    struct TAPYBARAA has drop {
        dummy_field: bool,
    }

    fun init(arg0: TAPYBARAA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/AutWy4Y8a5vqtC7CwRZ35rZfzXpktfwsNRuu6finpump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<TAPYBARAA>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"TAPYBARA    ")))), trim_right(b"Trench Capybara                 "), trim_right(x"5472656e63682043617079626172612028544150594241524120290a496e20746865206d75646479207472656e63686573206f6620746865206d656d65636f696e20776172732c205472656e636820436170796261726120646f6467656420612062617272616765206f6620465544206772656e616465732c206f6e6c7920746f20736c6970206f6e20612070696c65206f66206879706520616e64206c616e6420696e206120706f6f6c206f66206c69717569646974792e20224a75737420616e6f746865722064617920646566656e64696e672074686520626c6f636b636861696e20626172726963616465732c22206865206d757474657265642c207368616b696e67206f666620746865206475737420616e642070756d70696e6720686973207061777320666f7220746865206e65787420626174746c652e202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TAPYBARAA>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TAPYBARAA>>(v4);
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

