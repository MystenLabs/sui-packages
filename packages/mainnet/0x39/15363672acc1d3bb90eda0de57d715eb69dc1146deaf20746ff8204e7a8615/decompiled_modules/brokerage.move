module 0x3915363672acc1d3bb90eda0de57d715eb69dc1146deaf20746ff8204e7a8615::brokerage {
    struct BROKERAGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BROKERAGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BROKERAGE>(arg0, 6, b"BROKERAGE", b"OG BROKERAGE", b"OG Brokerage is a next-generation forum and marketplace that introduces a secure, token-powered ecosystem for trading digital handles, services, and products. By integrating a deflationary token economy, a robust escrow system, and strategic buybacks", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1734745009897.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BROKERAGE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BROKERAGE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

