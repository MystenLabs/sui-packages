module 0x7d8d2703f38cf17531d778f2a974faff4263b59b8d212d8a1ec90e2982faad45::darkp {
    struct DARKP has drop {
        dummy_field: bool,
    }

    fun init(arg0: DARKP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/AnezLD3geudTCiEJqRBWhjzCxrdUv92R7m86SgsDDARK.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<DARKP>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"DARKP       ")))), trim_right(b"Dark Prompt AI                  "), trim_right(x"4672656520414920666f722045766572796f6e650a4461726b2050726f6d7074204149206f66666572732061206c696d69746c6573732c20756e63656e736f7265642c20616e642066756c6c79207072697661746520414920657870657269656e63652e2054686520244441524b5020746f6b656e20697320746865206261636b626f6e65206f66207468697320646563656e7472616c697a65642065636f73797374656d206f662066726565646f6d2e0a0a2046756c6c20416e6f6e796d69747920204e6f20726567697374726174696f6e2c206e6f20747261636b696e672c206e6f20646174612073746f726167652e0a20556e6c696d69746564204163636573732020436f6e6e65637420746f20756e63656e736f72656420414920616e7974696d652c20616e7977686572652e0a204175746f6e6f6d6f7573202620"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DARKP>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DARKP>>(v4);
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

