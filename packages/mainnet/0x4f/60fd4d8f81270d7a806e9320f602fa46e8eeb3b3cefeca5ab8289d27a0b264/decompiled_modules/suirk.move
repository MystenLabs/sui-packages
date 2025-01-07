module 0x4f60fd4d8f81270d7a806e9320f602fa46e8eeb3b3cefeca5ab8289d27a0b264::suirk {
    struct SUIRK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIRK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIRK>(arg0, 6, b"SUIRK", b"Suirk", b" The Rise of SUIRK: From the Ark of Moses to the Sui Blockchain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/artwork_440x440_ASDASD_274c8671df.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIRK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIRK>>(v1);
    }

    // decompiled from Move bytecode v6
}

