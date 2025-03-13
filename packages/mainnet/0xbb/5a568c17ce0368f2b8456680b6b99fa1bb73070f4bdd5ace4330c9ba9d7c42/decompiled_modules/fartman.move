module 0xbb5a568c17ce0368f2b8456680b6b99fa1bb73070f4bdd5ace4330c9ba9d7c42::fartman {
    struct FARTMAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: FARTMAN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/HH2cbmLBpYCGFdmEu6BF9iMVXZpArZHbmXQmZ5Gppump.png?claimId=ofkgYmHs-Awvl5rO                                                                                                                                                                                                      ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<FARTMAN>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"FARTMAN     ")))), trim_right(b"FartMan                         "), trim_right(b"Fartman is a fearless superhero with an unusual yet powerful giftsonic flatulence capable of stopping crime in its tracks. Clad in a striking, skin-tight suit, he soars through the skies, using his explosive emissions to defeat villains, neutralize threats, and bring justice to the world. Though often underestimated, h"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FARTMAN>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FARTMAN>>(v4);
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

