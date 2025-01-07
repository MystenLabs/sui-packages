module 0x2536e5d179cd6a16dea608bcef6de6223d637b18c7454204fccf875aab41560::dilbry {
    struct DILBRY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DILBRY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DILBRY>(arg0, 6, b"DILBRY", b"Dilbry", x"4d6565742044696c6272792e2041206269742073746f6f706964207768656e20697420636f6d65732074696d6520746f20666c792e200a53656e642068696d20686f6d652074686520626573742077617920796f75206b6e6f7720686f7720776f756c64207961", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1733553390799_raw_b37d0f6632.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DILBRY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DILBRY>>(v1);
    }

    // decompiled from Move bytecode v6
}

