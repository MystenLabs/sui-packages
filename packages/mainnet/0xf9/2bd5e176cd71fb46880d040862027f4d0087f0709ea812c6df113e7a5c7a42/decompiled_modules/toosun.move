module 0xf92bd5e176cd71fb46880d040862027f4d0087f0709ea812c6df113e7a5c7a42::toosun {
    struct TOOSUN has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOOSUN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOOSUN>(arg0, 6, b"Toosun", b"ToSun", b"Tosun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/parker_probe_update_547fdb9b71.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOOSUN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TOOSUN>>(v1);
    }

    // decompiled from Move bytecode v6
}

