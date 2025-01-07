module 0x6c2c4925b6875254124b544da123a1132ea3adeb34e2df3a510b8aa91aa47fbc::blob {
    struct BLOB has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLOB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLOB>(arg0, 6, b"BLOB", b"DE BLOBS BLOBS", b"$Blobs is more than just a memecoin; it's the start of a new movement on the Sui blockchain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731513335865.PNG")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BLOB>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLOB>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

