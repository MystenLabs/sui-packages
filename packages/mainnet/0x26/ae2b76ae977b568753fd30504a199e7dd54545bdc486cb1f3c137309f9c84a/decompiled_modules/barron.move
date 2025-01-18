module 0x26ae2b76ae977b568753fd30504a199e7dd54545bdc486cb1f3c137309f9c84a::barron {
    struct BARRON has drop {
        dummy_field: bool,
    }

    fun init(arg0: BARRON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BARRON>(arg0, 6, b"BARRON", b"BARRONSUI", b"BARRONSUI is a meme coin on the Sui blockchain, combining humor, fast transactions, and community-driven vibes to redefine meme culture in crypto.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_2851_e6d61bd6a8.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BARRON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BARRON>>(v1);
    }

    // decompiled from Move bytecode v6
}

