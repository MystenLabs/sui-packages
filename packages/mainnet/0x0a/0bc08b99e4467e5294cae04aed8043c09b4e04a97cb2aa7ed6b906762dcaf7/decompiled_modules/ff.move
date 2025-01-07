module 0xa0bc08b99e4467e5294cae04aed8043c09b4e04a97cb2aa7ed6b906762dcaf7::ff {
    struct FF has drop {
        dummy_field: bool,
    }

    fun init(arg0: FF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FF>(arg0, 6, b"FF", b"FeoFuh", b"FeoFuh for all", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Su_Rt_Dml_WRXM_ba42e0ee4c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FF>>(v1);
    }

    // decompiled from Move bytecode v6
}

