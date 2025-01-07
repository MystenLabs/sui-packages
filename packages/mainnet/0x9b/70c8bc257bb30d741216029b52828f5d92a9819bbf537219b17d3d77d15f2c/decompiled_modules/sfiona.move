module 0x9b70c8bc257bb30d741216029b52828f5d92a9819bbf537219b17d3d77d15f2c::sfiona {
    struct SFIONA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SFIONA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SFIONA>(arg0, 6, b"SFiona", b"Sui Fiona", b"In the rapidly evolving world of cryptocurrency, where meme coins have become a significant trend, the story of Fiona the hippo stands out as a unique blend of cultural phenomenon and blockchain innovation.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000122772_d8adce06e1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SFIONA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SFIONA>>(v1);
    }

    // decompiled from Move bytecode v6
}

