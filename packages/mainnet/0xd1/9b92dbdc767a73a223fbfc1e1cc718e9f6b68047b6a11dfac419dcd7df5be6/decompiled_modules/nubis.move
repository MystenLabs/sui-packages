module 0xd19b92dbdc767a73a223fbfc1e1cc718e9f6b68047b6a11dfac419dcd7df5be6::nubis {
    struct NUBIS has drop {
        dummy_field: bool,
    }

    fun init(arg0: NUBIS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"929d5e759edadbb2bcbda312ccdb2b9f2db0d2d871a6ee3a0bef322cfef44238                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<NUBIS>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"NUBIS       ")))), trim_right(b"Nubis.fun                       "), trim_right(x"4e756269732020507265646963742e20506c61792e2057696e2e200a0a5468652066697273742070726564696374696f6e206d61726b65747320706c6174666f726d206f6e2054656c656772616d2e0a0a5472616e73706172656e742c2067616d69666965642c20616e6420706f776572656420627920244e55424953206f6e20536f6c616e612e20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NUBIS>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NUBIS>>(v4);
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

