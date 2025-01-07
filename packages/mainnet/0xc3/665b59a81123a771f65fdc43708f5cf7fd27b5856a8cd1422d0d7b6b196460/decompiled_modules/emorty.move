module 0xc3665b59a81123a771f65fdc43708f5cf7fd27b5856a8cd1422d0d7b6b196460::emorty {
    struct EMORTY has drop {
        dummy_field: bool,
    }

    fun init(arg0: EMORTY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EMORTY>(arg0, 6, b"EMorty", b"EvilMorty", b"He is one of the many versions of Morty from across the multiverse, but unique in being notably amoral, ruthless and displaying intelligence rivalling that of Rick. He initially appeared alongside Evil Rick, who was hunting down and killing several R", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1733005822667.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EMORTY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EMORTY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

