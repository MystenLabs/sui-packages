module 0xa12457c1ad2cd244b962528aeca0318b595d11acf57df977599e44d921f6d397::g5 {
    struct G5 has drop {
        dummy_field: bool,
    }

    fun init(arg0: G5, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"https://gateway.irys.xyz/NDZuPAc3jAjlGhLfQR_p-xK9QJgFp9529gvNS0OGx2c";
        let v1 = if (0x1::vector::length<u8>(&v0) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gateway.irys.xyz/NDZuPAc3jAjlGhLfQR_p-xK9QJgFp9529gvNS0OGx2c"))
        };
        let (v2, v3, v4) = 0x2::coin::create_regulated_currency_v2<G5>(arg0, 9, trim_right(b"G5"), trim_right(b"One Piece TCG"), trim_right(b"One Piece Trading Card Game Tokens are issued by the community"), v1, true, arg1);
        let v5 = v2;
        let v6 = 0x2::tx_context::sender(arg1);
        if (100000000000000000 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<G5>>(0x2::coin::mint<G5>(&mut v5, 100000000000000000, arg1), v6);
        };
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<G5>>(v5, v6);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<G5>>(v3, v6);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<G5>>(v4);
    }

    fun trim_right(arg0: vector<u8>) : vector<u8> {
        let v0 = 32;
        while (0x1::vector::length<u8>(&arg0) > 0) {
            if (0x1::vector::borrow<u8>(&arg0, 0x1::vector::length<u8>(&arg0) - 1) != &v0) {
                break
            };
            0x1::vector::pop_back<u8>(&mut arg0);
        };
        arg0
    }

    // decompiled from Move bytecode v6
}

