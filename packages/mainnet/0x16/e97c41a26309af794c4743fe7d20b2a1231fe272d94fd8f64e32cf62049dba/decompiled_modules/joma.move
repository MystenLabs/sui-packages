module 0x16e97c41a26309af794c4743fe7d20b2a1231fe272d94fd8f64e32cf62049dba::joma {
    struct JOMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: JOMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JOMA>(arg0, 6, b"JOMA", b"JOMASHOP", b"JOMASHOP.COM", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/JOMASHOP_d736a5ae20.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JOMA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JOMA>>(v1);
    }

    // decompiled from Move bytecode v6
}

