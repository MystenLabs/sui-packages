module 0x8dc05188d7452fcc30e34b4a7ad0154c99fc4b85808031aa6471dcba78e891be::idog {
    struct IDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: IDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IDOG>(arg0, 6, b"idog", b"instadog", x"496e737461646f67202849444f472920f09f90bee29ca820e2809420546865206d656d65636f696e2063656c6562726174696e672074686520666972737420646f67206576657220706f73746564206f6e20496e7374616772616d2120496e737461646f6720686f6e6f7273207468652069636f6e696320707570207468617420737461727465642074686520736f6369616c206d65646961207265766f6c7574696f6e21", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.hop.ag/ipfs/QmawnaomKYfiWaVdV8tqnDQLh3WKBRFCPEbxNWLinYJATJ")), arg1);
        0x2::transfer::public_transfer<0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::Connector<IDOG>>(0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::new<IDOG>(7071956793283859015, v0, v1, 0x1::string::utf8(b"https://x.com/Instadog_fun"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"https://t.me/Instadog_fun"), 0x2::tx_context::sender(arg1), arg1), @0xfa6d14378e545d7da62d15f7f1b5ac26ed9b2d7ffa6b232b245ffe7645591e91);
    }

    // decompiled from Move bytecode v6
}

