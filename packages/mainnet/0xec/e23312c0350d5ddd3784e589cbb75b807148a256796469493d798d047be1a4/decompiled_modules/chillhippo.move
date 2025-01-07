module 0xece23312c0350d5ddd3784e589cbb75b807148a256796469493d798d047be1a4::chillhippo {
    struct CHILLHIPPO has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHILLHIPPO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHILLHIPPO>(arg0, 6, b"CHILLHIPPO", b"CHILLHIPO", b"CHILL", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_6236_9b78a8e84e.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHILLHIPPO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHILLHIPPO>>(v1);
    }

    // decompiled from Move bytecode v6
}

