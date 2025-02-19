module 0x68cada9eb34c2e15e249177a7617f87bc92e2ac7eacdd66ba47fd0fb15fa135a::bst {
    struct BST has drop {
        dummy_field: bool,
    }

    fun init(arg0: BST, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/BSTKPTQ2sHk6Dp73hhZ37wDWvSiZ7TynhLZqEhAEZNZN.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<BST>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"BST         ")))), trim_right(b"MrBeastMeme                     "), trim_right(x"4d7242656173744d656d6520436f696e20282442535429202054686520556c74696d617465204d656d6520436f696e20666f72207468652047656e65726f757320446567656e732120200a0a57656c636f6d6520746f204d7242656173744d656d6520436f696e2028244253542920207468652063727970746f2074686174206272696e67732066756e2c206d656d65732c20616e642067656e65726f7369747920746f2074686520626c6f636b636861696e2120496e73706972656420627920746865206c6567656e6461727920696e7465726e6574207068696c616e7468726f706973742c20244245415354206973206d6f7265207468616e206a7573742061206d656d65202069742773206120636f6d6d756e6974792d64726976656e20746f6b656e2064657369676e656420666f722074686f73652077686f206c6f"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BST>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BST>>(v4);
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

