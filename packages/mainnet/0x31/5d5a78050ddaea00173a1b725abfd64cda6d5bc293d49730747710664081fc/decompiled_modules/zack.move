module 0x315d5a78050ddaea00173a1b725abfd64cda6d5bc293d49730747710664081fc::zack {
    struct ZACK has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZACK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZACK>(arg0, 6, b"ZACK", b"Zack Morris", b"We are thrilled to announce the official launch of Zack Coin on the revolutionary SUI blockchain, ushering in a new era of innovation, opportunity, and fun for our growing community. Zack Coin is more than just a cryptocurrency its a symbol of our shared vision, creativity, and ambition. Built on the scalable and energy-efficient SUI blockchain, Zack Coin offers lightning-fast transactions, low fees, and a secure environment for everyone, from seasoned crypto enthusiasts to newcomers exploring the digital frontier. Join us as we embark on this exciting journey together, creating a vibrant ecosystem where every member has a voice, a stake, and a chance to thrive.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ZACK_COIN_200_730b83348b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZACK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ZACK>>(v1);
    }

    // decompiled from Move bytecode v6
}

