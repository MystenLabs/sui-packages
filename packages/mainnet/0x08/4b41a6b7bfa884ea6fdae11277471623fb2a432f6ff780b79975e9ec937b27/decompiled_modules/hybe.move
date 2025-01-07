module 0x84b41a6b7bfa884ea6fdae11277471623fb2a432f6ff780b79975e9ec937b27::hybe {
    struct HYBE has drop {
        dummy_field: bool,
    }

    fun init(arg0: HYBE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HYBE>(arg0, 6, b"HYBE", b"Honey Badger", b"Honey Badger has a close connection with Bitcoin and is considered a famous Bitcoin mascot in the cryptocurrency community. The honey badger is an animal famous for its brave, strong and fearless personality even when facing larger enemies. This image is consistent with how Bitcoin is seen as \"resilient\" in the face of challenges and opposition from traditional financial systems, governments, and other extreme factors.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pfp_c200276afe.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HYBE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HYBE>>(v1);
    }

    // decompiled from Move bytecode v6
}

