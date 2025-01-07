module 0x610a4d7482bc916d1b5986600b882a9fe18f7f78b783ff5974e75822cb380d91::suili {
    struct SUILI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUILI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUILI>(arg0, 6, b"Suili", b"Suili On Sui", b"Suli on Sui, a tortured soul, wanders the dark expanse of the SUI ecosystem. With hollow eyes and a maniacal grin, Suli embodies the frustrations and despair of navigating the unpredictable world of cryptocurrency. Their sanity unravels as they're tormented by errors, bugs, and inexplicable phenomena. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0541_6ed41eb65a.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUILI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUILI>>(v1);
    }

    // decompiled from Move bytecode v6
}

