module 0xf6369f638fc34c341a1fa8c784a369a204e79887374772b31999c0e0d9940ef0::casui {
    struct CASUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CASUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CASUI>(arg0, 6, b"CASUI", b"CASUI TIME", b"Move over Casio, the real timepiece of the future is hereC ASUI! The memecoin that proves theres no better time than SUI time. Dont miss the moment. Strap in, HODL tight, and lets show the world what happens when memes meet precision timing.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sui_logo_f4490b8c10.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CASUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CASUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

