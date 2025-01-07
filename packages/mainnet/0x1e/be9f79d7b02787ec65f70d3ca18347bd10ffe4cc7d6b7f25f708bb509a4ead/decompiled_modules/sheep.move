module 0x1ebe9f79d7b02787ec65f70d3ca18347bd10ffe4cc7d6b7f25f708bb509a4ead::sheep {
    struct SHEEP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHEEP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHEEP>(arg0, 9, b"sheep", b"Mr Sheep", b"Mascot Sui ecosystem", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdna.artstation.com/p/assets/images/images/080/743/748/large/matteo-repetto-thumbnail.jpg?1728402760")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SHEEP>(&mut v2, 30000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHEEP>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHEEP>>(v1);
    }

    // decompiled from Move bytecode v6
}

