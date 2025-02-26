module 0xeba5d42aa7127e32bf0b5770c194a14db985af4ac44b3dcb114287a73cc10588::sfm {
    struct SFM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SFM, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/ELPrcU7qRV3DUz8AP6siTE7GkR3gkkBvGmgBRiLnC19Y.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<SFM>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"SFM         ")))), trim_right(b"SafeMoon                        "), trim_right(b"SafeMoon is reborn as a fully community-driven memecoin, backed by a transparent, on-chain token swap. This fresh start ensures holders receive their tokens fairly while embracing the power of decentralized ownership. With a focus on community engagement, viral growth, and open governance, SafeMoon is no longer stuck i"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SFM>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SFM>>(v4);
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

