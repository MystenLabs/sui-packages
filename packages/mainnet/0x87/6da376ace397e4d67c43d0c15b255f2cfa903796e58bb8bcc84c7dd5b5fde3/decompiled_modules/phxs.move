module 0x876da376ace397e4d67c43d0c15b255f2cfa903796e58bb8bcc84c7dd5b5fde3::phxs {
    struct PHXS has drop {
        dummy_field: bool,
    }

    fun init(arg0: PHXS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PHXS>(arg0, 6, b"PHXS", b"Phoenix Sui Hosting", b"Phoenix SUI offers a unique web hosting and website building service tailored for the crypto and meme communities. Powered by the SUI blockchain, this service ensures decentralized, secure, and fast hosting for your websites. Whether you're building a crypto-related website or a meme platform, Phoenix SUI provides a seamless experience with easy-to-use tools for creating, managing, and scaling your online presence. With blockchain integration, your website enjoys enhanced security, transparency, and speed, making it the ideal choice for anyone looking to host or build in the world of crypto and digital content.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_5712_2_optimized_1000_f93e01cc27.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PHXS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PHXS>>(v1);
    }

    // decompiled from Move bytecode v6
}

