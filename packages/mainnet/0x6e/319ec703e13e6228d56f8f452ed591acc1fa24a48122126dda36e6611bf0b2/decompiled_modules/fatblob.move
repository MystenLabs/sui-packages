module 0x6e319ec703e13e6228d56f8f452ed591acc1fa24a48122126dda36e6611bf0b2::fatblob {
    struct FATBLOB has drop {
        dummy_field: bool,
    }

    fun init(arg0: FATBLOB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FATBLOB>(arg0, 9, b"FATBLOB", b"FATBLOBFISH", b"FAT&BLOB&FISSHY", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<FATBLOB>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FATBLOB>>(v2, @0xf129ff0022c360c932fb549dff4debb7285552dc737084268b57f9d26e06a3a3);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FATBLOB>>(v1);
    }

    // decompiled from Move bytecode v6
}

