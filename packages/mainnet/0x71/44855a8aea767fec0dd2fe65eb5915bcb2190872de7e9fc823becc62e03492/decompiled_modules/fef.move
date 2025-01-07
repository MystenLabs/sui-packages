module 0x7144855a8aea767fec0dd2fe65eb5915bcb2190872de7e9fc823becc62e03492::fef {
    struct FEF has drop {
        dummy_field: bool,
    }

    fun init(arg0: FEF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FEF>(arg0, 6, b"FEF", b"FourEyesFrog", b"this is a fun and impactful meme cryptocurrency represented by a quirky frog with oversized glasses. Dedicated to raising awareness about youth eye care, $FEF donates 25% of its total revenue to vision protection charities.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731850566623.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FEF>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FEF>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

