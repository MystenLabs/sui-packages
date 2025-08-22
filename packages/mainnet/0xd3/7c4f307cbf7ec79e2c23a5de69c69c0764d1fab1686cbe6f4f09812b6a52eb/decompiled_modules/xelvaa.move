module 0xd37c4f307cbf7ec79e2c23a5de69c69c0764d1fab1686cbe6f4f09812b6a52eb::xelvaa {
    struct XELVAA has drop {
        dummy_field: bool,
    }

    fun init(arg0: XELVAA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"eOmnaKahurOYkJOe                                                                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<XELVAA>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"XELVA       ")))), trim_right(b"XELVA COIN                      "), trim_right(x"477265656e2052574120285265616c20576f726c642041737365742920496e6e6f766174696f6e0d0a0d0a58454c564120434f494e20697320612063727970746f63757272656e6379206261636b6564206279207265616c2d776f726c642061737365747320285257412920776974682061207375737461696e61626c6520616e6420656e7669726f6e6d656e74616c20666f6375732e204275696c74206f6e2074686520536f6c616e6120426c6f636b636861696e2c2058454c564120434f494e20696e7465677261746573206469676974616c2066696e616e6369616c20736f6c7574696f6e73207769746820656e7669726f6e6d656e74616c20707265736572766174696f6e20616e6420726567656e65726174696f6e2e0d0a0d0a4b65792046656174757265733a0d0a09312e095265616c20616e6420456e766972"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XELVAA>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<XELVAA>>(v4);
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

