module 0x7ecdf2ea685b74f33d15d9f54b181fcbdf302a18791e1542cece469c05d7f04a::wha {
    struct WHA has drop {
        dummy_field: bool,
    }

    fun init(arg0: WHA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WHA>(arg0, 6, b"WHA", b"SuiWhale", b"Whale meme on Sui. The token of people ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_9552_e54f97ab93.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WHA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WHA>>(v1);
    }

    // decompiled from Move bytecode v6
}

