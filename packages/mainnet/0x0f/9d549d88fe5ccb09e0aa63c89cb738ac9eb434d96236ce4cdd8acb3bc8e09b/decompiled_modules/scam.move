module 0xf9d549d88fe5ccb09e0aa63c89cb738ac9eb434d96236ce4cdd8acb3bc8e09b::scam {
    struct SCAM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCAM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCAM>(arg0, 6, b"SCAM", b"SCAMS", b"SCAM TOKEN ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1_FA_Yn_Fek_400x400_3f903817db.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCAM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SCAM>>(v1);
    }

    // decompiled from Move bytecode v6
}

