module 0x9b538a27410b25691dbfb5a71269e33604579300db04e1581329040e351ec004::pnut {
    struct PNUT has drop {
        dummy_field: bool,
    }

    fun init(arg0: PNUT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PNUT>(arg0, 6, b"PNUT", b"Peanut The Squirrel", b"Beloved Peanut the Squirrel was taken away from his home by NYSDEC and euthanized.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731080683455.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PNUT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PNUT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

