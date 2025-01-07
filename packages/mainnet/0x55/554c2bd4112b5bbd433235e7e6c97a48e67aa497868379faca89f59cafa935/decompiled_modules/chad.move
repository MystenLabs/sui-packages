module 0x55554c2bd4112b5bbd433235e7e6c97a48e67aa497868379faca89f59cafa935::chad {
    struct CHAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHAD, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<CHAD>(arg0, 6, b"CHAD", b"CryptoChad by SuiAI", b"The Witty Specialist.Casual and humorous, this agent connects with a younger audience using wit and a sharp sense of humor while delivering actionable insights..", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/CHAD_1ca6e6bc4a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CHAD>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHAD>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

