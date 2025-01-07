module 0xaf90b7789051981de81866a23f46a5311a9f352043218a376ba299b131f6076f::bolme {
    struct BOLME has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOLME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOLME>(arg0, 6, b"BOLME", b"BoloMe", b"the cat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/bitcoin_wallpaper_4k_667f8e28d5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOLME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOLME>>(v1);
    }

    // decompiled from Move bytecode v6
}

