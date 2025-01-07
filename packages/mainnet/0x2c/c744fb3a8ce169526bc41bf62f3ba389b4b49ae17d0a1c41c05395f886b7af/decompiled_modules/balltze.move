module 0x2cc744fb3a8ce169526bc41bf62f3ba389b4b49ae17d0a1c41c05395f886b7af::balltze {
    struct BALLTZE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BALLTZE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BALLTZE>(arg0, 6, b"BALLTZE", b"Balltze", b"affectionately known as \"Cheems,\" was a Shiba Inu dog who became an internet sensation.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241003_013005_671_177809a877.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BALLTZE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BALLTZE>>(v1);
    }

    // decompiled from Move bytecode v6
}

