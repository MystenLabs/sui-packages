module 0x9068a8e8a2a7a09488b2568c24df92f7d42f67b94c9a09ace658667f462dbb97::pnc {
    struct PNC has drop {
        dummy_field: bool,
    }

    fun init(arg0: PNC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PNC>(arg0, 6, b"PNC", b"Post Nut Clarity", b"PNC - Post Nut Clarity", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2025_07_05_163654_06d765efb3.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PNC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PNC>>(v1);
    }

    // decompiled from Move bytecode v6
}

