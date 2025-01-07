module 0x639abfbc3267a06841920f29de1719eb98678530722ed75823eb8f59802c7a28::scat {
    struct SCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCAT>(arg0, 6, b"SCAT", b"Suimons Cat", b"Suimon's cat, we are committed to transparency, integrity, and excellence in everything we do. We prioritize the needs and interests of our community members and strive to maintain open communication channels at all times. With a focus on continuous improvement and customer satisfaction, we aim to be at the forefront of the blockchain gaming revolution.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_6825_806df7feef.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

