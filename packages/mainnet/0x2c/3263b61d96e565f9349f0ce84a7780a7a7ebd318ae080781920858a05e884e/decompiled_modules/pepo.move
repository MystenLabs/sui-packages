module 0x2c3263b61d96e565f9349f0ce84a7780a7a7ebd318ae080781920858a05e884e::pepo {
    struct PEPO has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<PEPO>(arg0, 6, b"PEPO", b"Pepeandoge by SuiAI", b".pepo agent ia that mixes the 2 biggest memecoins on the market let's surf this wave and strengthen our AI with our vision.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/1000008722_4b1f566e45.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PEPO>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPO>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

