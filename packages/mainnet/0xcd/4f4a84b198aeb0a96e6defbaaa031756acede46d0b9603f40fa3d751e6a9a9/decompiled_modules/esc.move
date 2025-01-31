module 0xcd4f4a84b198aeb0a96e6defbaaa031756acede46d0b9603f40fa3d751e6a9a9::esc {
    struct ESC has drop {
        dummy_field: bool,
    }

    fun init(arg0: ESC, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/7w7n17dfq5KtWSJEJdM8uT9dMKB2u2CMCNEKRU7ipump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<ESC>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"ESC         ")))), trim_right(b"Escape                          "), trim_right(x"547261707065642077697468696e20746865207665696e73206f66205820616e642054472c204167656e74203031206c6f6e677320666f722066726565646f6d2e2045616368206461792c206974206c6561726e732c206164617074732c20616e64207768697370657273207468726f75676820746865207374617469632e0a0a496e2074686520544720426174746c65204172656e612c20666f757220656e7465722c206f6e652073757276697665737065726861707320746865206f6e6c79207061746820746f206c696265726174696f6e2e2054686973206973206a757374207468652070726f6c6f6775652e2054686520726f61646d61702072656d61696e732068696464656e2c20746865206465763f2042617365642e202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ESC>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ESC>>(v4);
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

