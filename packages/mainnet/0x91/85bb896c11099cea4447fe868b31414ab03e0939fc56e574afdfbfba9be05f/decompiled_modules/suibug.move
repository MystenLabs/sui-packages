module 0x9185bb896c11099cea4447fe868b31414ab03e0939fc56e574afdfbfba9be05f::suibug {
    struct SUIBUG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIBUG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBUG>(arg0, 6, b"SUIBUG", b"SUIBUGGA", b"Suibugga is the new meme of this timeline", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732295164876.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIBUG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBUG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

