module 0x3158a8d153e8e83be2c81250787bd86b5b57f1aa3ad3401c6c8bd5b9f33a3ade::hfsh {
    struct HFSH has drop {
        dummy_field: bool,
    }

    fun init(arg0: HFSH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HFSH>(arg0, 6, b"HFSH", b"HopFish", b"They say fish don't jump, I'm an exception #sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/HOPIS_579ec582b8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HFSH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HFSH>>(v1);
    }

    // decompiled from Move bytecode v6
}

