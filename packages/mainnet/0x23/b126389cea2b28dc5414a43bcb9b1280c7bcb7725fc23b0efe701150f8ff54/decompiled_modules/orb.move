module 0x23b126389cea2b28dc5414a43bcb9b1280c7bcb7725fc23b0efe701150f8ff54::orb {
    struct ORB has drop {
        dummy_field: bool,
    }

    fun init(arg0: ORB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ORB>(arg0, 6, b"Orb", b"ORB", b"ORB is the first token on World Chain, distributed equally to every human. Every human can claim 1,000 ORB once in their lifetime. Claims are open forever and never expire. Universal distribution powered by World ID. One token, for every human. ORB is an independent project and is not affiliated with Tools for Humanity or the Worldcoin Foundation.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000005045_181cd80290.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ORB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ORB>>(v1);
    }

    // decompiled from Move bytecode v6
}

