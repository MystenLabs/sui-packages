module 0x30c8fbffab24f083a26279ba6e585e9cb7e64ade2fc9da179155988d8457dbfd::cepy {
    struct CEPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CEPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CEPY>(arg0, 6, b"CEPY", b"CEPYBALA SUIBALA", b"WE ARE THE NEXT TOP MEMECOIN ON SUI !!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20241011_235327_5523923cda.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CEPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CEPY>>(v1);
    }

    // decompiled from Move bytecode v6
}

