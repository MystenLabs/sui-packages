module 0x6238b7a06500482547a79f9e81628ec688fe6c900bb9dbf2f3131eaf27dba896::dkss {
    struct DKSS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DKSS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DKSS>(arg0, 6, b"DKSS", b"DarkSeraph on sui", b"Glad to have more companions in the world of DarkSeraph.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2025_01_24_20_15_30_9512353fe2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DKSS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DKSS>>(v1);
    }

    // decompiled from Move bytecode v6
}

