module 0xa39f558d0b5d82f4ab6f962f6fd907e634f97b64e6a8d26f3f63d6b4ccdb2c1f::chadcat {
    struct CHADCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHADCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHADCAT>(arg0, 6, b"CHADCAT", b"Chad Cat on SUI", b"Top cat in the meme coin market, I'm CHAD CAT!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/p97xfw_Jo_400x400_37c48b4ad5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHADCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHADCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

