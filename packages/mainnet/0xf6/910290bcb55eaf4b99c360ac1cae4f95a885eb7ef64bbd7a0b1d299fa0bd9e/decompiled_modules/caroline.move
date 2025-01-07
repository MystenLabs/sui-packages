module 0xf6910290bcb55eaf4b99c360ac1cae4f95a885eb7ef64bbd7a0b1d299fa0bd9e::caroline {
    struct CAROLINE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAROLINE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAROLINE>(arg0, 6, b"Caroline", b"Suiit Caroline", b"Neil Diamond wrote a song about Sui Caroline.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Sweet_Caroline_cover_4a3a070bc5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAROLINE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CAROLINE>>(v1);
    }

    // decompiled from Move bytecode v6
}

