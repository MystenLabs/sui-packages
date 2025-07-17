module 0xeb8769fda1da44f1e90de30d5c82599b0f006d1711d63888b28aa981ea6af842::pingu {
    struct PINGU has drop {
        dummy_field: bool,
    }

    fun init(arg0: PINGU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PINGU>(arg0, 6, b"PINGU", b"Pingu the Penguins", b"Pingu is Pinga's adorable little sister, a charming character from the beloved Pingu series. While her brother Pinga is famous for his iconic \"Noot Noot\" catchphrase, Pingu brings her own unique charm to the show with her clever tricks and endearing personality Penguins.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibavakex2llacmgynmdtopkclu2jjifgem7qyux4l3qusjy6zye54")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PINGU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PINGU>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

