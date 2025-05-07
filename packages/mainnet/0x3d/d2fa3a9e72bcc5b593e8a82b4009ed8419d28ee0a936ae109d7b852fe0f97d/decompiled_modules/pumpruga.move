module 0x3dd2fa3a9e72bcc5b593e8a82b4009ed8419d28ee0a936ae109d7b852fe0f97d::pumpruga {
    struct PUMPRUGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUMPRUGA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/EqTREkvNmUUNBqZbREFQjV1qk3r8JKNESYciQHCgpump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<PUMPRUGA>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"PUMPRUG     ")))), trim_right(b"PUMPRUG                         "), trim_right(x"50657270657475616c205275673a2054686520556c74696d6174652043727970746f2047616d626c650a0a547261646520686f75726c7920746f6b656e206c61756e6368657320776974682072616e646f6d2072756770756c6c732e2048696768205269736b2c2048696768205265776172642e0a0a50756d7052756720282450554d505255472920697320746865207365636f6e64207072696d61727920746f6b656e206f6620746865205065727052756720706c6174666f726d2e20353025206f6620616c6c2070726f666974732067656e65726174656420627920506572705275672061726520646973747269627574656420746f207072696d61727920746f6b656e20686f6c646572732e0a0a5072696d61727920746f6b656e732063616e206e657665722072756720284c50206275726e65642920616e64206172"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUMPRUGA>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUMPRUGA>>(v4);
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

