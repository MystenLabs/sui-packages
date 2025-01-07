module 0x256fb7c8e9ea6a1ac2f7c47afb7dd27ec4921644cffec9228443e55b5390e6f::bvr {
    struct BVR has drop {
        dummy_field: bool,
    }

    fun init(arg0: BVR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BVR>(arg0, 6, b"BVR", b"Beaver", b"beaver is not just a meme its movement", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.hop.ag/ipfs/QmdASx1tdgFPMUaBim37JC9nWTmXoJg8s6Bw21px1uVDLF")), arg1);
        0x2::transfer::public_transfer<0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::Connector<BVR>>(0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::new<BVR>(12771806814224277468, v0, v1, 0x1::string::utf8(b"https://x.com/BeaverSUI"), 0x1::string::utf8(b"https://suibvr.xyz/"), 0x1::string::utf8(b"https://t.me/beaver"), 0x2::tx_context::sender(arg1), arg1), @0xfa6d14378e545d7da62d15f7f1b5ac26ed9b2d7ffa6b232b245ffe7645591e91);
    }

    // decompiled from Move bytecode v6
}

