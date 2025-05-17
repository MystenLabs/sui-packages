module 0x399d20be25192a6664a4f69e7c9292ae3e55b0183e34bab35ab77dc72d5d636d::accela {
    struct ACCELA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ACCELA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/qB6AgtckmdwdZV4NVr4XSQjmjEQjzNV9PjT1mPCpump.png                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<ACCELA>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"ACCEL       ")))), trim_right(b"ACCEL 166x ACCELERATE on SOLANA!"), trim_right(x"414343454c203136367820414343454c4552415445206f6e20534f4c414e4121202824414343454c290a496e73706972656420627920534f4c414e412024414343454c203136367820414343454c455241544520697320612066616e2d63726561746564206d656d65636f696e206f6e2074686520536f6c616e6120426c6f636b636861696e2e20546869732070726f6a65637420697320707572656c7920666f7220656e7465727461696e6d656e7420616e6420636f6d6d756e6974792066756e202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ACCELA>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ACCELA>>(v4);
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

