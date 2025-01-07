module 0x1fb95b08698ef15a91faab0f34e72ca880e18c6725ea758d72b8d7086e0cadd5::niggatue {
    struct NIGGATUE has drop {
        dummy_field: bool,
    }

    fun init(arg0: NIGGATUE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NIGGATUE>(arg0, 6, b"Niggatue", b"Nigga Pepe Statue", b"We spent 4 days sculpting the Nigga Pepe Statue, turning it into more than just a meme. It's a symbol. $NIGGATUE is here, to get backed by a community that celebrates this masterpiece. Pepe's legacy lives on the Sui Network.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/PP_5_31bc7b74fe.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NIGGATUE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NIGGATUE>>(v1);
    }

    // decompiled from Move bytecode v6
}

