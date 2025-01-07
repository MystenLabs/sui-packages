module 0xe9448fd83ec650803c069dfdd42bc514b6e698cb535746e753865c22d7152b83::suirim {
    struct SUIRIM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIRIM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIRIM>(arg0, 6, b"SUIRIM", b"THE SUIRIM", b"Hello have you been a good boy? or a bad one?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/OIF_8f730ea6d2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIRIM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIRIM>>(v1);
    }

    // decompiled from Move bytecode v6
}

