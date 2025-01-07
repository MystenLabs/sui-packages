module 0xd847a048cd0e334ceec9f2f9f7cb9f327e8d45b0da08544fbdbe9784c13ea9e6::honys {
    struct HONYS has drop {
        dummy_field: bool,
    }

    fun init(arg0: HONYS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HONYS>(arg0, 6, b"HONYS", b"HONEYFRENS", b"Welcome to HONEYFRENS (HONYS)  The Sweetest Fren-ship on the SUI Blockchain!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/HONPOST_f7a6a808f6.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HONYS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HONYS>>(v1);
    }

    // decompiled from Move bytecode v6
}

