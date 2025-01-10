module 0x23c3f2d8020c37b4f411c6d35369e70c9b343c77258991f7e37f9b76a35f6312::jota {
    struct JOTA has drop {
        dummy_field: bool,
    }

    fun init(arg0: JOTA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JOTA>(arg0, 6, b"JOTA", b"Jota", b"May da forz b wit u", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/jota_profil_90a1d43af7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JOTA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JOTA>>(v1);
    }

    // decompiled from Move bytecode v6
}

