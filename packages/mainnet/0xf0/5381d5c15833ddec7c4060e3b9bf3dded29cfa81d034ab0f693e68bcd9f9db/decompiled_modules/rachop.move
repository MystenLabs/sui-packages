module 0xf05381d5c15833ddec7c4060e3b9bf3dded29cfa81d034ab0f693e68bcd9f9db::rachop {
    struct RACHOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: RACHOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RACHOP>(arg0, 6, b"RACHOP", b"Rachop", x"526163686f70206973206f6e65206f66207468652066697273742070726f6a65637473206f6620486f7066756e2e204f7572206c65616420636861726163746572732c20526163686f70207468652070697261746520726163636f6f6e20616e6420686973206c6f79616c20667269656e642c20486f502074686520486f7066756e206d6173636f7420c4b06e7669746520796f7520746f206a6f696e207468656d206f6e20746865697220746872696c6c696e6720616476656e7475726573", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.hop.ag/ipfs/QmcU72eDV2E2SnH9kbTTcNunjXrRUqDJBKMteLuxtJjXPt")), arg1);
        0x2::transfer::public_transfer<0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::Connector<RACHOP>>(0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::new<RACHOP>(15353265774777969942, v0, v1, 0x1::string::utf8(b"https://x.com/RachopSui"), 0x1::string::utf8(b"https://rachop.com"), 0x1::string::utf8(b" https://t.me/RachopSUI"), 0x2::tx_context::sender(arg1), arg1), @0xfa6d14378e545d7da62d15f7f1b5ac26ed9b2d7ffa6b232b245ffe7645591e91);
    }

    // decompiled from Move bytecode v6
}

