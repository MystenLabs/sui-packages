module 0xfe10e3e8cf4fff4f67c2195a0a01d4ee600343e91ccfa3be882721b2d2cbd093::sothis {
    struct SOTHIS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOTHIS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"b2ac204ffce616f6ac7dd6f8e8fcfb9e596c22d362057f90ffa4348dae551616                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<SOTHIS>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"SOTHIS      ")))), trim_right(b"Sothis                          "), trim_right(b"$SOTHIS powers Sothis AI Compiler: text-to-website & dApp builder (IPFS/Solana/EVM). Used for premium access, faster generation, governance. Fair launch, fully community-driven.                                                                                                                                               "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOTHIS>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SOTHIS>>(v4);
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

