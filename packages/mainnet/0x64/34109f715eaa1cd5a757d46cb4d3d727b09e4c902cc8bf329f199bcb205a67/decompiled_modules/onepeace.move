module 0x6434109f715eaa1cd5a757d46cb4d3d727b09e4c902cc8bf329f199bcb205a67::onepeace {
    struct ONEPEACE has drop {
        dummy_field: bool,
    }

    fun init(arg0: ONEPEACE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (true) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"3ef25b52a6c23bb8114e6fd70ef332f678b115415f7bd802447a19e8aec24ed7")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"3ef25b52a6c23bb8114e6fd70ef332f678b115415f7bd802447a19e8aec24ed7"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<ONEPEACE>(arg0, 9, 0x1::string::utf8(b"ONEPEACE"), 0x1::string::utf8(b"Luffy"), 0x1::string::utf8(x"4f6e65706561632066616e20776865726520617265207520677579733f20202020200a4920726573637565642073697820636174732066726f6d2074686520737472656574732c20616e6420492067617665206f6e65206f66207468656d2074686520636f6f6c657374206e616d65204920636f756c64207468696e6b206f663a204c756666792c20696e73706972656420627920746865206c6567656e6461727920616e696d65204f6e65205069656365"), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/ebd7c4e39a56f1d3c08d144089447a7a7e313932c7e6107805c1723b3ea33d61.webp"), v0, true, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<ONEPEACE>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<ONEPEACE>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

