module 0xfe690000e4380419f420fc91c5b9ad1cb70cdb2817fdd78a78b5a902754c070b::blub {
    struct BLUB has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUB>(arg0, 6, b"BLUB", b"Blub", b"Distinguished blobfish, connoisseur of fine dining and questionable life choices.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1749331850114.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BLUB>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUB>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

